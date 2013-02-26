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
      xslTranslate ${SKNLIB_DIR}/xslt/srw-to-xml.xsl "data:recorddata|identifier:${identifier}" ${result} "${destDir}/${filename}.xml"
	  checkBoolean ${relevancy} && sleep 1
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
