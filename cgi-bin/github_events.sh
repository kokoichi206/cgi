#!/bin/bash

echo "Content-type: text/html"
echo ""

echo '<html>'
echo '<head>'
echo '<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">'
echo '<title>Foo</title>'

urldecode(){
    echo -e "$(sed 's/+/ /g;s/%\(..\)/\\x\1/g;')"
}

body="REQUEST_METHOD: $REQUEST_METHOD\n"
body+="<p>CONTENT_LENGTH: $CONTENT_LENGTH</p>"
if [ "$REQUEST_METHOD" = "POST" ]; then
    body+="<p>Post Method</p>"
    # 絶対に読む必要がある！
    # --- curl: (52) Empty reply from server ---
    in_raw=`cat`
    split_data=($(echo -n "$in_raw" | tr "=" "\n"))
    # file_name=${split_data[0]}
    file_name_and_github_name=${split_data[0]}
    # '%23' means '#'
    if [[ "$file_name_and_github_name" =~ (.*)%23(.*) ]]; then
        file_name=${BASH_REMATCH[1]}
        github_name=${BASH_REMATCH[2]}
    fi
    file_content=${split_data[1]}

    if [[ "${file_name}" == *.png ]]; then
        if [ "${#file_content}" -gt 10 ]; then
            body+="<p>Writing to ${file_name}</p>"
            mv /var/www/html/imgs/github-events/${github_name}/${file_name} /var/www/html/imgs/github-events/${github_name}/${file_name}.bak
            body+="$file_content" | urldecode | base64 -d > /var/www/html/imgs/github-events/${github_name}/${file_name}
            echo "$file_content" | urldecode | base64 -d > /var/www/html/imgs/github-events/${github_name}/${file_name}

            redirect_url="/github/index-success.html"
            echo "<meta http-equiv=\"refresh\" content=\"0; url=${redirect_url}\"/>"
        fi
    fi
fi

echo '</head>'

echo '<body>'
echo "${body}"
echo '</body>'
echo '</html>'

exit 0
