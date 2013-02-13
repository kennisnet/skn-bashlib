#****c* skn-bashlib/validation
# NAME
#  Validation Functions
# DESCRIPTION
#  All check functions should operate the same way; return
#  true when the input value is correct, and false if not.
# EXAMPLE
#  checkFoo "value" && echo "true" || echo "false"
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

#****f* validation/checkUuid
# DESCRIPTION
#  Returns true when valid uuid, else false.
#***
function checkUuid {
   local uuid=${1}
   [ ! -z $(echo ${uuid} | grep -i '^[0-9a-f]\{8\}-[0-9a-f]\{4\}-[0-9a-f]\{4\}-[0-9a-f]\{4\}-[0-9a-f]\{12\}$') ] && return 0 || return 1
}
