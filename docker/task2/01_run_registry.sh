#/bin/bash

echo -e "\n\e[1;32m Run registry...\e[0m \n"
docker run -d -p 5000:5000 --name registry.loc registry:2
