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

#****f* common/booleanIsTrue
# DESCRIPTION
#  Returns a logical true if the variable is a string "true"
#  in any upper- or lowercase combination.
# EXAMPLE
#  booleanIsTrue "true" && echo "true" || echo "false"  # true
#  booleanIsTrue "yes" && echo "true" || echo "false"   # false
#***
function booleanIsTrue {
   case $1 in
      [Tt][Rr][Uu][Ee]) return 0 ;;
      *) return 1 ;;
   esac
}

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
