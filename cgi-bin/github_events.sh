#!/bin/bash

echo "Content-type: text/html"
echo ""

echo '<html>'
echo '<head>'
echo '<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">'
echo '<title>Foo</title>'
echo '</head>'
echo '<body>'

echo "<p>Start</p>"

urldecode(){
    echo -e "$(sed 's/+/ /g;s/%\(..\)/\\x\1/g;')"
}

echo "REQUEST_METHOD: $REQUEST_METHOD\n"
echo "<p>CONTENT_LENGTH: $CONTENT_LENGTH</p>"
if [ "$REQUEST_METHOD" = "POST" ]; then
    echo "<p>Post Method</p>"
    # 絶対に読む必要がある！
    # --- curl: (52) Empty reply from server ---
    in_raw=`cat`
    split_data=($(echo -n "$in_raw" | tr "=" "\n"))
    file_name=${split_data[0]}
    file_content=${split_data[1]}
    if [[ "${file_name}" == *.png ]]; then
        if [ "${#file_content}" -gt 10 ]; then
            echo "<p>Write to ${file_name}</p>"
            mv /var/www/html/imgs/github-events/${file_name} /var/www/html/imgs/github-events/${file_name}.bak
            echo "$file_content" | urldecode | base64 -d > /var/www/html/imgs/github-events/${file_name}
        fi
    fi
fi

echo '</body>'
echo '</html>'

exit 0
