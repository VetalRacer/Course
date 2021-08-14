#/bin/bash

echo -e "\n\e[1;31m Delete first nginx image...\e[0m \n"
docker stop nginx && docker rm nginx 
docker rmi nginx.loc:latest
echo -e "\n\e[1;31m Delete second nginx image...\e[0m \n"
docker stop httpd && docker rm httpd
docker rmi httpd.loc:latest
