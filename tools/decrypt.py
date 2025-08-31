#!/bin/bash

# repo path
REPO_PATH="$HOME/temp/kafka_connector_iceberg" # EDIT HERE

# file name
ENC_FILE=$1
if [ -z "$ENC_FILE" ]; then
    echo "Error: No .enc file provided."
    echo "Usage: ./decrypt.sh <file_name>.enc"
    exit 1
fi

# Extract the base file name without the .enc extension
BASE_NAME=$(basename "$ENC_FILE" .enc)

# Construct the full paths
ENC_PATH="$REPO_PATH/$ENC_FILE"
ZIP_PATH="$REPO_PATH/$BASE_NAME.zip"

# decrypt
openssl enc -d -aes-256-cbc -in "$ENC_PATH" -out "$ZIP_PATH"
unzip "$ZIP_PATH"
rm -rf "$ZIP_PATH"
echo "Decryption complete for $BASE_NAME"