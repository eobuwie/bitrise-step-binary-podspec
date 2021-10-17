#!/bin/bash
set -ex

FILE="binary_podspec/${name}.podspec.json"

mkdir -p binary_podspec && cp ${podspec} ${FILE}

jq "(.name = \"${name}\")" $FILE | sponge $FILE
jq "(.version = \"${version}\")" $FILE | sponge $FILE
jq "del(.source, .source_files)" $FILE | sponge $FILE
jq "(.source.http = \"${artifact_url}\")" $FILE | sponge $FILE
jq "(.vendored_frameworks = \"${name}.${extension}\")" $FILE | sponge $FILE

cat $FILE

envman add --key BINARY_PODSPEC_PATH --value "$FILE"
