#****c* skn-bashlib/srusrw
# NAME
#  SRU/SRW Functions
#***

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, version 3 of the License.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

#****f* srusrw/getRecordCount
# DESCRIPTION
#  Perform a query to an sru/srw service and retrieve
#  the response recordcount.
#***
function srusrwGetRecordCount {
   local query=${1}
   local totalQuery="$(echo ${query} | sed 's/&maximumRecords=[0-9]*//')&maximumRecords=0"
   requiredVar "${totalQuery}" "$FUNCNAME: provide a query"
   urlRetrieve "${totalQuery}" | xslTranslate ${SKNLIB_DIR}/xslt/srw-to-txt.xsl "data:recordcount"
}

#****f* srusrw/getRecordRecordIdentifiers
# DESCRIPTION
#  Perform a query to an sru/srw service and retrieve
#  the response recordidentifiers.
#***
function srusrwGetRecordIdentifiers {
   local query=${1}
   requiredVar "${query}" "$FUNCNAME: provide a query"
   urlRetrieve "${query}" | xslTranslate ${SKNLIB_DIR}/xslt/srw-to-txt.xsl "data:identifiers"
}

#****f* srusrw/getRecords
# DESCRIPTION
#  Retrieves all records from one SRU/SRW response.
#  When relevancy is true, the original order is kept
#  in order of time (ls -tr).
#***
function srusrwGetRecords {
   requiredArgs $# 2 $FUNCNAME
   local query=${1}
   local destDir=${2}
   local relevancy=${3}
   local result=$(mktemp)

   requiredVar "${query}" "$FUNCNAME: provide a query"
   requiredVar "${destDir}" "$FUNCNAME: provide a destination directory"
   requiredWrite "${destDir}" "$FUNCNAME: the destination directory should be writable"

   urlRetrieve "${query}" ${result}

   for identifier in $(xslTranslate ${SKNLIB_DIR}/xslt/srw-to-txt.xsl "data:identifiers" ${result}); do
      filename=$(echo ${identifier} | sed s/\\//:/g)
      xslTranslate ${SKNLIB_DIR}/xslt/srw-to-xml.xsl "data:recorddata|identifier:${identifier}" ${result} "${destDir}/${filename}"
      checkTrue ${relevancy} && sleep 1
   done

   rm ${result}
}

#****f* srusrw/harvestData
# DESCRIPTION
#  Given a query, retrieves all records for that
#  query until the last available page.
#***
function srusrwHarvestData {
   requiredArgs $# 2 $FUNCNAME
   local query=${1}
   local destDir=${2}
   local firstPage=$(mktemp)

   requiredVar "${query}" "$FUNCNAME: provide a query"

   # get first page for some starting variables
   urlRetrieve "${query}" ${firstPage}
   local recordCount=$(xslTranslate ${SKNLIB_DIR}/xslt/srw-to-txt.xsl "data:recordcount" ${firstPage})
   local maxRecords=$(xslTranslate ${SKNLIB_DIR}/xslt/srw-to-txt.xsl "data:maximumrecords" ${firstPage})
   local startRecord=$(xslTranslate ${SKNLIB_DIR}/xslt/srw-to-txt.xsl "data:startrecord" ${firstPage})
   rm ${firstPage}

   while [ ${startRecord} -le ${recordCount} ]; do
      srusrwGetRecords "${query}" "${destDir}"
      startRecord=$(( ${startRecord} + ${maxRecords} ))
      query="$(echo ${query} | sed 's/&startRecord=[0-9]*//')&startRecord=${startRecord}"
   done
}

#****f* srusrw/updateRecord
# DESCRIPTION
#  Updates the provided record from the
#  endpoint.
#***
function srusrwUpdateRecord {
   requiredArgs $# 4 $FUNCNAME
   local record=${1}
   local endpoint=${2}
   local identifier=${3}
   local recordSchema=${4}
   local updateXml=$(mktemp)
   local curlResult=$(mktemp)

   xslTranslate ${SKNLIB_DIR}/xslt/srw-update.xsl "action:update|identifier:${identifier}|recordschema:${recordSchema}" ${record} ${updateXml}
   # not using urlRetrieve, doesn't support POST data
   curl --silent -o ${curlResult} --data-binary "@${updateXml}" ${endpoint}
   rm ${updateXml}
   srusrwUpdateResponseCheck ${curlResult} ${identifier} "updated"
}

#****f* srusrw/deleteRecord
# DESCRIPTION
#  Deletes the provided upload identifier
#  from the endpoint.
#***
function srusrwDeleteRecord {
   requiredArgs $# 2 $FUNCNAME
   local endpoint=${1}
   local identifier=${2}
   local updateXml=$(mktemp)
   local curlResult=$(mktemp)

   # call to itself, the delete doen't need an input xml
   xslTranslate ${SKNLIB_DIR}/xslt/srw-update.xsl "action:delete|identifier:${identifier}" ${SKNLIB_DIR}/xslt/srw-update.xsl ${updateXml}
   # not using urlRetrieve, doesn't support POST data
   curl --silent -o ${curlResult} --data-binary "@${updateXml}" ${endpoint}
   srusrwUpdateResponseCheck ${curlResult} ${identifier} "deleted"
}

#****f* srusrw/responseCheck
# DESCRIPTION
#  Checks the response provided by and SRU Record Update.
#  if there is a diagnostic uri, it failed, else, it's
#  a succesful update.
#  When failing, the identifier is output to stderr so
#  it can be captured separately.
#***
function srusrwUpdateResponseCheck {
   requiredArgs $# 3 $FUNCNAME
   local responseXml=${1}
   local identifier=${2}
   local successMsg=${3}

   if [ ! -z $(xslTranslate ${SKNLIB_DIR}/xslt/srw-to-txt.xsl "data:diagnostic-uri" ${responseXml}) ]; then
      >&2 echo ${identifier}
      if ! checkValidXml ${1}; then
         msgError "${identifier}: empty response"
      else
         msgError "${identifier}: $(xslTranslate ${SKNLIB_DIR}/xslt/srw-to-txt.xsl "data:diagnostic-msg" ${responseXml})"
         msgError "$(xslTranslate ${SKNLIB_DIR}/xslt/srw-to-txt.xsl "data:diagnostic-details" ${responseXml})"
      fi
   else
      msgOk "${identifier} ${successMsg}"
   fi
   rm ${responseXml}
}

