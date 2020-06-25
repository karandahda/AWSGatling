FROM maven:3.6.0-jdk-8-alpine

ARG PROJECT_NAME

ENV testName basic.SetUpUserLoadOpenSystem

RUN apt-get update \        
     apt-get install -y git
	 
WORKDIR /build

git clone https://github.com/karandahda/AWSGatling.git

COPY ${PROJECT_NAME}/pom.xml .

RUN mvn org.apache.maven.plugins:maven-dependency-plugin:3.1.1:go-offline

COPY ${PROJECT_NAME}/ /build/${PROJECT_NAME}

RUN mvn install --offline

WORKDIR /build/${PROJECT_NAME}/

CMD mvn gatling:test -Dgatling.simulationClass=$testName