#****c* skn-bashlib/common
# NAME
#  Database Functions
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

#****f* common/requiredVar
# DESCRIPTION
#  Shorthand function to check a required variable in a
#  function. Exists with 1 and an error message if the 
#  variable not present.
#***
function requiredVar {
   local var=${1}
   local msg=${2}

   [ -z "${msg}" ] && msg="missing required variable"
   [ -z "${var}" ] && msgError "${msg}" && exit 1
}

#****f* common/requiredWrite
# DESCRIPTION
#  Shorthand function to check if a file is writable.
#  If the file does not exist prior to checking, try
#  to make it first.
#***
function requiredWrite {
   local file=${1}
   local msg=${2}

   [ -z "${msg}" ] && msg="file not writable: ${file}"
   [ ! -f "${file}" ] && touch "${file}"
   [ ! -w "${file}" ] && msgError "${msg}" && exit 1
}

#****f* common/requiredArgs
# DESCRIPTION
#  Shorthand function to check if the number of arguments
#  for a function is at least the number specified.
#***
function requiredArgs {
   local curNr=${1}
   local reqNr=${2}
   local name=${3}

   [ "${curNr}" -lt "${reqNr}" ] && msgError "${name}: requires at least ${reqNr} arguments" && exit 1
}

#****f* common/setOrDefault
# DESCRIPTION
#  Shorthand function to either set the input var if not
#  empty, or set the default value.
#***
function setOrDefault {
   local var=${1}
   local default=${2}

   [ -z "${var}" ] && var="${default}"
   echo "${var}"
}
