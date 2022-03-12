#!/bin/bash

# 動画置き場までのパス
MOVIE_DIR="/var/www/html/movie"
# htmlルートからの動画置き場までのパス
MOVIE_DIR_FROM_HTML_ROOT="movie"

echo "Content-type: application/json"
echo ""
echo -n "{"
echo -n "\"base_dir\": \"${MOVIE_DIR_FROM_HTML_ROOT}\""
echo -n ","
echo -n "\"titles\": "
echo -n "["
for file in $(ls ${MOVIE_DIR}); do
    if [ -f "${MOVIE_DIR}/${file}" ]; then
        titles="${titles}$(echo -n "\"${file}\"",)"
    fi
done
titles=${titles/%?/}
echo -n "${titles}"
echo -n "]"
echo -n "}"
