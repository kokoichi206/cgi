#!/bin/sh

method="$REQUEST_METHOD"
### post data is expected to be passed as text/plane ###
POST_STRING=$(cat)
post="$POST_STRING"

if [ "${method}" = "POST" ]; then
    # /tmp/log/ だと上手くいかなかった（なんで？）
    LOG_DIR="/var/www/html/sakamichi_log/"
    FILE_NAME="issues.txt"
    FILE_PATH="${LOG_DIR}${FILE_NAME}"

    DATA_TYPE="issue"
    if [ -n "$post" ]; then
        echo ["$(date)"] ${DATA_TYPE} "${post}" >> "${FILE_PATH}"
    fi
    # status=$?
cat << EOF
Content-Type: application/json; charset=UTF-8

{
    "status": "check"
}
EOF
elif [ "${method}" = "GET" ]; then
cat << EOF
Content-Type: application/json; charset=UTF-8

{
    "me": "$(whoami)",
    "home_dir": "$(ls ~/)",
    "files_in /tmp/log/": "${FILES_IN_LOG}",
    "pwd": "$(pwd)",
    "path": "${FILE_PATH}",
    "method": "${method}",
    "post body": "${post}",
    "success": "false"
}
EOF
fi