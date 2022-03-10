#!/bin/sh

cat << EOF
Content-type: application/json; charset=UTF-8

{
    "status": "$status"
}
EOF