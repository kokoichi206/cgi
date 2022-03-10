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

if [ "$REQUEST_METHOD" = "POST" ]; then
    echo "<p>Post Method</p>"
    if [ "$CONTENT_LENGTH" -gt 0 ]; then
    in_raw=`cat`
    boundary=$(echo -n "$in_raw" | head -1 | tr -d '
');
    filename=$(echo -n "$in_raw" | grep --text --max-count=1 -oP "(?<=filename=\")[^\"]*");
    file_content=$(echo -n "$in_raw" | sed '1,/Content-Type:/d' | tail -c +3 | head --lines=-1 | head --bytes=-4  );
    echo "boundary: $boundary"
    echo "filename: $filename"
    # echo "file_content: $file_content"
    # echo "$file_content" > /var/www/html/sakamichi_log/"$filename"
    # This is not working for movies
    # echo -en "$file_content" > /var/www/html/"$filename"
    echo $?
    sudo echo /var/www/html/movie/"$filename"
    fi
fi
echo '</body>'
echo '</html>'

exit 0