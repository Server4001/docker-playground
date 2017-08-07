#!/bin/bash

docker build -t jenkins-data -f data.Dockerfile .

#docker build -t jenkins -f jenkins.Dockerfile .
#docker build -t jenkins253 -f jenkins.2.53.Dockerfile .
docker build -t jenkins268 -f jenkins.2.68.Dockerfile .
#docker build -t jenkins2192 -f jenkins.2.19.2.Dockerfile .

docker run --name=jenkins-data jenkins-data

#docker run -p 8080:8080 -p 50000:50000 --name=jenkins-master --volumes-from=jenkins-data -d jenkins
#docker run -p 8080:8080 -p 50000:50000 --name=jenkins-master --volumes-from=jenkins-data -d jenkins253
docker run -p 8080:8080 -p 50000:50000 --name=jenkins-master --volumes-from=jenkins-data -d jenkins268
#docker run -p 8080:8080 -p 50000:50000 --name=jenkins-master --volumes-from=jenkins-data -d jenkins2192

docker exec jenkins-master cat /var/jenkins_home/secrets/initialAdminPassword
