#/bin/bash

echo -e "\n\e[1;32mpush images to loc registry...\e[0m \n"
docker push localhost:5000/nginx.loc:tag_one 
docker push localhost:5000/nginx.loc:tag_two
