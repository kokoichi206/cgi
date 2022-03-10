#!/bin/sh

SUM=0
VALUE=$(echo ${QUERY_STRING} | cgi-name | awk '{print $2}') 
for i in ${VALUE}
do
  SUM=$((SUM + i))
done

cat << EOF
Content-type: text/html; charset=UTF-8

<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>加算結果</title>
</head>
<body>
<h3>五つの数値を足すと…</h3>
<p>
${SUM}
</p>
</body>
</html>
EOF