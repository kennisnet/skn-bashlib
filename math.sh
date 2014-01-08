#****c* skn-bashlib/math
# NAME
#  Math Functions
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

#****f* math/round
# DESCRIPTION
#  Rounds a value to a certain number
# SEE ALSO
#  http://stempell.com/2009/08/rechnen-in-bash/
#***
round() {
   local value=${1}
   local precision=${2}
   echo $(printf %.${precision}f $(echo "scale=$precision;(((10^$precision)*$value)+0.5)/(10^$precision)" | bc))
}
