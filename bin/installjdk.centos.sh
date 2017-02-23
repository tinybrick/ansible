#! /bin/bash

WORK_DIR=/tmp/work
DOWNLOADED_FILE_NAME=jdk.rpm

if [ ! -f "$WORK_DIR/$DOWNLOADED_FILE_NAME" ]; then
    if [ ! -d "$WORK_DIR" ]; then
        mkdir -p "$WORK_DIR"
    fi;

    curl -v -j -k -L -H "Cookie: oraclelicense=accept-securebackup-cookie" $1 > "$WORK_DIR/$DOWNLOADED_FILE_NAME"
fi;

rpm -Uvh "$WORK_DIR/$DOWNLOADED_FILE_NAME"

rm -f "$WORK_DIR/$DOWNLOADED_FILE_NAME"
