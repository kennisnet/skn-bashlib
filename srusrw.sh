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
   requiredVar "${query}" "$FUNCNAME: provide a query"
   urlRetrieve "${query}" | xslTranslate ${SKNLIB_DIR}/xslt/srw-to-txt.xsl "data:recordcount"
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
