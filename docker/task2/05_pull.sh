#/bin/bash

echo -e "\n\e[1;32mpush images to loc registry...\e[0m \n"
docker pull localhost:5000/nginx.loc:tag_one 
docker pull localhost:5000/nginx.loc:tag_two
