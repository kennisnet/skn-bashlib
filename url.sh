#****c* skn-bashlib/url
# NAME
#  URL Functions
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

#****f* url/urlRetrieve
# DESCRIPTION
#  Retrieves the contents of a url to the specified
#  output. When output not defined, retrieves to stdout.
#***
function urlRetrieve {
   local url=${1}
   local output=${2}

   # checks
   requiredVar "${url}" "function requires a url"
   [ -z ${output} ] && output="/dev/stdout"

   curl -s -o "${output}" "${url}"
}
