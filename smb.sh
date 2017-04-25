#****c* skn-bashlib/smb
# NAME
#  SMB Functions
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

#****f* smb/deleteRecord
# DESCRIPTION
#  Deletes the provided smo identifier
#  from the endpoint.
#***
function smbDeleteRecord {
   requiredArgs $# 2 $FUNCNAME
   local endpoint=${1}
   local identifier=${2}
   local supplierid=$(echo ${identifier} | cut -d '.' -f 1)
   local updateXml=$(mktemp)
   local curlResult=$(mktemp)

   # call to itself, the delete doen't need an input xml
   xslTranslate ${SKNLIB_DIR}/xslt/smb-delete.xsl "supplierid:${supplierid}|smoid:${identifier}" ${SKNLIB_DIR}/xslt/smb-delete.xsl ${updateXml}
   # not using urlRetrieve, doesn't support POST data
   curl --silent -o ${curlResult} --data-binary "@${updateXml}" ${endpoint}
   rm ${updateXml}
   smbUpdateResponseCheck ${curlResult} ${identifier} "deleted"
}

#****f* smb/updateRecord
# DESCRIPTION
#  Updates the provided smo on the provided endpoint.
#***
function smbUpdateRecord {
   requiredArgs $# 2 $FUNCNAME
   local record=${1}
   local endpoint=${2}
   local updateXml=$(mktemp)
   local curlResult=$(mktemp)
   
   xslTranslate ${SKNLIB_DIR}/xslt/smb-update.xsl "" ${record} ${updateXml}
   curl --silent -o ${curlResult} --data-binary "@${updateXml}" ${endpoint}
   rm ${updateXml}
   smbUpdateResponseCheck ${curlResult} $(basename $record) "updated"
}

#****f* smb/responseCheck
# DESCRIPTION
#  Checks the response provided by an SMB Update.
#  if there the status is not ok, it failed, else, it's
#  a succesful update.
#***
function smbUpdateResponseCheck {
   requiredArgs $# 3 $FUNCNAME
   local responseXml=${1}
   local identifier=${2}
   local successMsg=${3}

   if [ -z $(xslTranslate ${SKNLIB_DIR}/xslt/smb-to-txt.xsl "data:status" ${responseXml}) ]; then
      local code=$(xslTranslate ${SKNLIB_DIR}/xslt/smb-to-txt.xsl "data:error-code" ${responseXml})
      local description=$(xslTranslate ${SKNLIB_DIR}/xslt/smb-to-txt.xsl "data:error-description" ${responseXml})
      msgError "${identifier}: ${code} ${description}"
   else
      msgOk "${identifier} ${successMsg}"
   fi
   rm ${responseXml}
}
