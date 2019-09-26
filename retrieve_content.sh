#!/bin/bash

AUTH=
BROWSE=false
ID=
KEY=
OUTPUT=
URL=https://gitlab.com
BROWSE_FILE=
DESCRIPTION="Retrieve gitlab project's content as JSON file. \n \
             	The content is either stored in a file or printed on standard output. \n \
             	The JSON content can also be oppened into a web browser.
             	\n \
             	NOTE : 'curl' package has to be installed."
GITLAB_API=api/v4/projects
USAGE="Usage: ${0} [--id PROJECT_ID] [-h|--help] [-a|--auth KEY] [-b|--browse] [-i|--id PROJECT_ID] [-o|--output OUTPUT] [-u|--url URL] \n \
\t\t-h|--help                       : Print help.\n \
\t\t-a|--auth                       : Authentication key \n \
\t\t-b|--browse                     : Open JSON content with default web browser. \n \
\t\t-i|--id                         : Gitlab project id. \n \
\t\t-o|--output                     : Save JSON content into given file. \n \
\t\t-u|--url                        : Gitlab server URL ('${URL}' as default value).\n\n"

fail()
{
	echo "ERROR: $*" >&2
	exit 1
}

step()
{
	len=$(echo "$*" | awk '{print length}')
	echo
	seq -s'#' 0 ${len} | tr -d '[:digit:]'
	echo "$*"
	seq -s'#' 0 ${len} | tr -d '[:digit:]'
}

#######################
### Check arguments ###
#######################
[ ${#} -gt 0 ] || { printf "${USAGE}"; exit 1; }

while [ ${#} -ne 0 ]; do
	case "${1}" in
		-h|--help)                  printf "%b\n%b\n" "${USAGE}" "${DESCRIPTION}"; exit 0;;
		-a|--auth)                  shift; KEY=${1};;
		-b|--browse)                shift; BROWSE=true;;
		-i|--id)                    shift; ID=${1};;
		-o|--output)                shift; OUTPUT=${1}.json;;
		-u|--url)                   shift; URL=${1};;
		*)                          printf "${USAGE}"; exit 1;;
	esac
	shift
done

[ -z "${ID}" ] && fail "You shall specify gitlab project id."
[ -z "${KEY}" ] || AUTH=?private_token=${KEY}

###################################
### Check that URL is reachable ###
###################################
step "### Check that ${URL} is reachable"
ping -c1 -W1 $(sed 's:^.*\://\(.*$\):\1:' <<< ${URL}) > /dev/null 2>&1 && echo "OK" || fail "Error : ${URL} is not reachable"

########################
### Retrieve content ###
########################
step "Retrieve project's issues"
TMP_FILE=$(mktemp /tmp/gitlab-extracter.XXXXXX.json)
HTTP_RETURN_CODE=$(curl -s -w "%{http_code}" -o ${TMP_FILE} ${URL}/${GITLAB_API}/${ID}/issues${AUTH})

grep -E '2[0-9]{2}' >/dev/null <<< ${HTTP_RETURN_CODE} && echo "OK" || echo "Error : Server returned HTTP status code ${HTTP_RETURN_CODE}"

######################
### Save JSON file ###
######################
[ -z "${OUTPUT}" ] || { step "Saving JSON to ${OUTPUT}"; cp ${TMP_FILE} ${OUTPUT} && echo "OK" || echo "Error : Unable to save file to ${OUTPUT}"; }

#####################
### Print content ###
#####################
[ -z "${OUTPUT}" ] && BROWSE_FILE=${TMP_FILE} || BROWSE_FILE=${OUTPUT}
${BROWSE} && { sensible-browser ${BROWSE_FILE} || fail "Error : Unable to open file with default web browser"; } || [ -z "${OUTPUT}" ] && cat ${BROWSE_FILE}
echo

exit 0






