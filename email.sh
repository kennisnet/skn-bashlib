#****c* skn-bashlib/email
# NAME
#  Email Functions
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

#****f* database/emailSend
# DESCRIPTION
#  Sends a single email containing the given file
#  or stream
#***
function mailSend {
   requiredArgs $# 3 $FUNCNAME
   local subject=${1}
   local mailto=${2}
   local message=${3}
   local attach=$(setOrDefault "${4}" "")

   requiredVar "${subject}" "$FUNCNAME: Provide a subject"
   requiredVar "${mailto}" "$FUNCNAME: Mails need a receiver."
   requiredVar "${message}" "$FUNCNAME: Mails should not be empty. Supply input file or text output"

   if [ -r ${attach} ] && attach="-a ${attach}"

   if [[ ! ${message} =~ ^/|\./(.*) ]]; then
      echo "${message}" | mail -s "${subject}" "${attach}" "${mailto}" 2>&1
   elif [ ! -r ${message} ]; then
      mail -s "$subject" "$mailto" "${attach}" < ${message} 2>&1
   else
      msgError "input file not readable: ${message}" && exit 1
   fi
}
