#!/bin/bash

# repo path
REPO_PATH="$HOME/temp/kafka_connector_iceberg" # EDIT HERE

# file name
FILE_NAME=$1
if [ -z "$FILE_NAME" ]; then
    echo "Error: No file name provided."
    echo "Usage: ./encrypt.sh <file_name>"
    exit 1
fi

# remove slash in file/folder name
FILE_NAME="${FILE_NAME%/}"

# zip & encrypt
cd "$REPO_PATH" || exit 1
if [ -d "$FILE_NAME" ]; then
    zip -r "$FILE_NAME.zip" "$FILE_NAME"
    echo "$FILE_NAME"
elif [ -f "$FILE_NAME" ]; then
    zip "$FILE_NAME.zip" "$FILE_NAME"
    echo "$FILE_NAME"
fi
openssl enc -aes-256-cbc -salt -in "$FILE_NAME.zip" -out "$FILE_NAME.enc"
rm -rf "$FILE_NAME.zip"
echo "Encryption complete for $FILE_NAME"