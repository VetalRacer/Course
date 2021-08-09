#/bin/bash

echo -e "\n\e[1;31m Delete first nginx image...\e[0m \n"
docker stop nginx8082 && docker rm nginx8082 
docker rmi nginx8082:latest
echo -e "\n\e[1;31m Delete second nginx image...\e[0m \n"
docker stop nginx8083 && docker rm nginx8083
docker rmi nginx8083:latest
