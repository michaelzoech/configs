#!/bin/bash
# Copy Minecraft music files into current folder

set -e

VERSION="1.9"
MINSIZE="500000"
ASSETS="${HOME}/Library/Application Support/minecraft/assets"
OBJECTS="${ASSETS}/objects"
INDEX_FILE="${ASSETS}/indexes/${VERSION}.json"

FILENAME=""
HASH=""
SIZE=""

while read -r line ; do
	if [[ "$line" =~ \"([^.]*.ogg)\" ]]; then
		FILENAME=$(basename ${BASH_REMATCH[1]})
	elif [[ "$line" =~ \"hash\":\ \"([^\"]*)\"  ]]; then
		HASH=${BASH_REMATCH[1]}
	elif [[ "$line" =~ \"size\":\ (.*)$ ]]; then
		SIZE=${BASH_REMATCH[1]}
		if [[ ${FILENAME} != "" ]]; then
			if (( $SIZE > $MINSIZE )); then
				SOURCE="${OBJECTS}/${HASH:0:2}/${HASH}"
				DEST="./${FILENAME}"
				cp "${SOURCE}" "${DEST}"
			fi
			FILENAME=""
			HASH=""
			SIZE=""
		fi
	fi
done < "${INDEX_FILE}"

