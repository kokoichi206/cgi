#!/bin/sh

query="${QUERY_STRING}"
# if [ "$query" = "49b934ca495991b7852b855" ]; then
if [ "$query" = "e3b0c333333" ]; then
    status="success"
else
    status="failure"
fi

current_dir=`pwd`
log_dir=`ls /tmp/log`

cat << EOF
Content-type: application/json; charset=UTF-8

{
    "pwd": "${current_dir}"
    "status": "$status"
}
EOF
exec >&-
exec 2>&-

if [ "$status" = "success" ]; then
    exec sudo -u root /home/ubuntu/work/python/api/batch/night_batch.sh &
fi
#  exec sudo -u root update_blog.sh &
# sleep 14 &