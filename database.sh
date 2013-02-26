#****c* skn-bashlib/database
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

#****f* database/sqlQuery
# DESCRIPTION
#  Executes a single sql query. It sets a file containing
#  the query and executes it with sqlImport.
#***
function sqlQuery {
   requiredArgs $# 7 $FUNCNAME
   local type=${1}
   local query=${2}
   local output=${3}
   local host=${4}
   local user=${5}
   local password=${6}
   local name=${7}
   local remove="true"

   # checks
   requiredVar "${type}" "$FUNCNAME: provide a database type"
   requiredVar "${query}" "$FUNCNAME: query should not be empty"

   local queryfile=$(mktemp)
   echo ${query} > ${queryfile}
   sqlImport "${type}" "${queryfile}" "${output}" "${host}" "${user}" "${password}" "${name}" "${remove}"
}

#****f* database/sqlImport
# DESCRIPTION
#  Executes an sql file.
#***
function sqlImport {
   requiredArgs $# 7 $FUNCNAME
   local type=${1}
   local input=${2}
   local output=${3}
   local host=$(setOrDefault "${4}" "localhost")
   local user=${5}
   local password=${6}
   local name=${7}
   local remove=$(setOrDefault "${8}" "false")

   # checks and defaults
   requiredVar "${type}" "$FUNCNAME: provide a database type"
   [ ! -r ${input} ] && msgError "input file not readable: ${input}" && exit 1
   [ -z ${output} ] && msgWarning "no output file defined, using /dev/null" && output="/dev/null"
   requiredWrite "${output}" "$FUNCNAME: output file not writable: ${output}"
   requiredVar "${name}" "$FUNCNAME: a database name is required"

   case ${type} in
      "mysql")
         [ ! -z ${user} ] && user="-u ${user}"
         [ ! -z ${password} ] && password="-p${password}"
         mysql -h ${host} ${user} ${password} ${name} < ${input} > ${output} 2>&1 ;;
      "postgresql")
         # no password yet, test with .pgpass file
         [ ! -z ${user} ] && user="-U ${user}"
         psql -h ${host} ${user} -d ${name} < ${input} > ${output} 2>&1 ;;
      "sqlite")
         cat ${input} | sqlite3 ${name} > ${output} 2>&1 ;;
      *)
         msgError "database type not recognized: ${type}" && exit 1
   esac

   checkTrue "${remove}" && rm ${input}
}

#****f* database/sqlDump
# DESCRIPTION
#  Dumps an entire database into an SQL file
#***
function sqlDump {
   requiredArgs $# 6 $FUNCNAME
   local type=${1}
   local output=${2}
   local host=$(setOrDefault "${3}" "localhost")
   local user=${4}
   local password=${5}
   local name=${6}
   local zip=$(setOrDefault "${7}" "")
   local ext=""

   requiredVar "${type}" "$FUNCNAME: provide a database type"
   requiredVar "${name}" "$FUNCNAME: a database name is required"
   requiredVar "${output}" "$FUNCNAME: dumping requires an output file"
   requiredWrite "${output}" "$FUNCNAME: output file not writable: ${output}"

   case ${zip} in
      "gz")
         local zip="| gzip "
         local ext=".gz";;
      "bz")
         local zip="| bzip2 "
         local ext=".bz";;
      "xz")
         local zip="| xz "
         local ext=".xz";;
   esac

   case ${type} in
      "mysql")
         [ ! -z ${user} ] && user="-u${user}"
         [ ! -z ${password} ] && password="-p{password}"
         mysqldump -h${host} ${user} ${password} ${name} ${zip}> ${output}${ext} 2>&1 ;;
      "postgresql")
         [ ! -z ${user} ] && user="-U ${user}"
         [ ! -z ${password} ] && password="-W{password}"
         pg_dump -h ${host} ${user} ${password} ${name} ${zip}> ${output}${ext} 2>&1 ;;
      "sqlite")
         sqlite3 ${name} .dump ${zip}> ${output}${ext} 2>&1 ;;
      *)
         msgError "database type not recognized: ${type}" && exit 1
   esac
}
