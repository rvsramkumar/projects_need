#! /bin/bash -v

cat <<EOM > /usr/share/nginx/html/index.html
<html>
<head>
<title>Welcome to nginx</title>
<style>
    body {
        width: 35em;
        margin: 0 auto;
        font-family: Tahoma, Verdana, Arial, sans-serif;
    }
</style>
</head>
<body>
<h1>Welcome to Home Page</h1>
</body>
</html>
EOM
cat <<EOM > /etc/nginx/conf.d/gogoui.conf
server {
    listen 80;

    server_name dev.lynxadmin.com;

    location / {
        proxy_pass http://localhost:8000;
    }

    access_log /var/log/nginx/ui-access.log;

    error_log  /var/log/nginx/ui-error.log error;

}
EOM
