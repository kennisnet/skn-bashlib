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
   [ "$#" -lt "7" ] && msgError "sqlQuery requires at least 7 arguments" && exit 1
   local type=${1}
   local query=${2}
   local output=${3}
   local host=${4}
   local user=${5}
   local password=${6}
   local name=${7}
   local remove="true"

   # checks
   [ -z ${type} ] && msgError "provide a database type" && exit 1
   [ -z "${query}" ] && msgError "query should not be empty" && exit 1

   local queryfile=$(mktemp)
   echo ${query} > ${queryfile}
   sqlImport "${type}" "${queryfile}" "${output}" "${host}" "${user}" "${password}" "${name}" "${remove}"
}

#****f* database/sqlImport
# DESCRIPTION
#  Executes an sql file.
#***
function sqlImport {
   [ "$#" -lt "7" ] && msgError "sqlImport requires at least 7 arguments" && exit 1
   local type=${1}
   local input=${2}
   local output=${3}
   local host=${4}
   local user=${5}
   local password=${6}
   local name=${7}
   local remove=${8}

   # checks and defaults
   [ -z ${type} ] && msgError "provide a database type" && exit 1
   [ ! -r ${input} ] && msgError "input file not readable: ${input}" && exit 1
   [ -z ${output} ] && msgWarning "no output file defined, using /dev/null" && output="/dev/null"
   [ ! -w ${output} ] && msgError "output file not writeable: ${output}" && exit 1
   [ -z ${host} ] && host="localhost"
   [ -z ${name} ] && msgError "a database name is required" && exit 1
   [ -z ${remove} ] && remove="false"

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
         while read query; do
            sqlite3 ${name} "${query}" > ${output} 2>&1
         done < ${input} ;;
      *)
         msgError "database type not recognized: ${type}" && exit 1
   esac

   booleanIsTrue "${remove}" && rm ${input}
}
