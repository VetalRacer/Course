#/bin/bash

echo -e "\n\e[1;32mBuild first nginx image...\e[0m \n"
docker build -f Dockerfile_nginx -t nginx.loc .
echo -e "\n\e[1;32mBuild second nginx image...\e[0m \n"
docker build -f Dockerfile_httpd -t httpd.loc .
