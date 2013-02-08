#****c* skn-bashlib/message
# NAME
#  Message Functions
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

GOOD='\033[32;01m'
WARN='\033[33;01m'
BAD='\033[31;01m'
NORMAL='\033[0m'

#****f* message/msgOk
# DESCRIPTION
#  Shows the message prefixed with a green asterisk.
#***
function msgOk {
   local msg=${1}
   echo -e " ${GOOD}*${NORMAL} ${msg}"
}

#****f* message/msgError
# DESCRIPTION
#  Shows the message prefixed with a red asterisk.
#***
function msgError {
   local msg=${1}
   echo -e " ${BAD}*${NORMAL} ${msg}"
}

#****f* message/msgWarning
# DESCRIPTION
#  Shows the message prefixed with a yellow asterisk.
#***
function msgWarning {
   local msg=${1}
   echo -e " ${WARN}*${NORMAL} ${msg}"
}
