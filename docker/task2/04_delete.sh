#/bin/bash

echo -e "\n\e[1;31m Delete 2tag image...\e[0m \n"
docker rmi localhost:5000/nginx.loc:tag_one
docker rmi localhost:5000/nginx.loc:tag_two
docker rmi nginx
