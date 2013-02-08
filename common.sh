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
booleanIsTrue(){
    case $1 in
       [Tt][Rr][Uu][Ee]) return 0 ;;
       *) return 1 ;;
    esac
}
