#****c* skn-bashlib/xml
# NAME
#  XML Functions
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

#****f* xml/xslTranslate
# DESCRIPTION
#  Perform an xsl translation based primarily on an xslt.
#  String parameters are optional and provided in the
#  form key1:value1|key2:value2 .
#  When the input xml is not provided, input from stdin is
#  assumed. For an empty output, stdout is assumed.
#***
function xslTranslate {
   requiredArgs $# 1 $FUNCNAME
   local xsl=${1}
   local params=${2}
   local xml=$(setOrDefault "${3}" "-")
   local target=$(setOrDefault "${4}" "/dev/stdout")
   local strParams=""

   # checks
   requiredVar "${xsl}" "$FUNCNAME: provide an xslt file"
   requiredWrite "${target}" "$FUNCNAME: output file not writable: ${target}"

   if [ "${xml}" != "-" ]; then
      [ ! -r ${xml} ] && msgError "$FUNCNAME: source not readable: ${xml}" && exit 1
   fi

   # create the stringparams
   if [ ! -z ${params} ]; then
      # parameters should at least include a :
      if [ ! -z $(echo "${params}" | grep ":") ]; then
         for p in $(echo ${params} | tr "|" "\n"); do
            key=$(echo ${p} | cut -d ':' -f1)
            keylen=$(( ${#key} + 1 ))
            val=${p:keylen}
            strParams="${strParams} --stringparam ${key} ${val}"
         done
      else
         msgError "$FUNCNAME: illegal parameter definition: ${params}"
         exit 1
      fi
   fi

   xsltproc ${strParams} -o "${target}" "${xsl}" "${xml}"
}

#****f* xml/checkValidXml
# DESCRIPTION
#  Checks if provided xml record is a valid xml document.
#***
function checkValidXml {
   requiredArgs $# 1 $FUNCNAME
   local xml=${1}
   xmllint --noout ${xml} &>/dev/null
   return $?      
}
