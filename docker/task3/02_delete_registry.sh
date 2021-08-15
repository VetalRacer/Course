#/bin/bash

echo -e "\n\e[1;31m Delete registry...\e[0m \n"
docker stop registry.loc && docker rm registry.loc
docker rmi registry:2 localhost:5000/nginx.loc:latest localhost:5000/httpd.loc:latest
