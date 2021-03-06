#!/bin/bash

if [ $# != 4 ]; then
  echo -e "ERROR! Wrong number of parameters!"
  echo -e "USE:"
  echo -e "${0} <DSPACEURL> <TOKEN> <REQUEST_DECRIPTOR_FILE> <REQUEST_TYPE [\"json\"/\"xml\"]>"
  exit 1
fi

DSPACEURL=${1}
TOKEN=${2}
REQUEST=${3}
REQUEST_TYPE=${4}

if [ -e ${REQUEST} ]; then
  source $REQUEST
else
  echo "ERROR! Request descriptor file not found!"
  exit 1
fi

curl -k -4 \
  -H "rest-dspace-token: ${TOKEN}" \
  -H "accept: application/${REQUEST_TYPE}" \
	-X ${VERB} "${DSPACEURL}/${ACTION}" \
	-F upload=@"${FILE}"
