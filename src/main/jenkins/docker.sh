#!/bin/bash

JK_CMD="docker exec loadtest_jenkins java -jar /tmp/jenkins-cli.jar -s http://localhost:8080/"

echo "Starting dockerized Jenkins"
docker run --name loadtest_jenkins -p 8080:8080 jenkins:1.609.1

echo "Loading CLI from Jenkins"
docker exec loadtest_jenkins curl -o /tmp/jenkins-cli.jar http://localhost:8080/jnlpJars/jenkins-cli.jar

echo "Installing Jenkins modules"
$JK_CMD install-plugin credentials
$JK_CMD install-plugin ssh-credentials
$JK_CMD install-plugin envinject
$JK_CMD install-plugin ssh
$JK_CMD install-plugin git
$JK_CMD install-plugin git-client
$JK_CMD/ safe-restart

echo "Copying boot2docker certs to Jenkins"
docker exec -i loadtest_jenkins bash -c 'cat > /tmp/ca.pem' < ~/.boot2docker/certs/boot2docker-vm/ca.pem
docker exec -i loadtest_jenkins bash -c 'cat > /tmp/cert.pem' < ~/.boot2docker/certs/boot2docker-vm/cert.pem
docker exec -i loadtest_jenkins bash -c 'cat > /tmp/key.pem' < ~/.boot2docker/certs/boot2docker-vm/key.pem

read -p "Point your browser to the running Jenkins instance, add an ssh-host and configure maven, then press a key to continue " -n1 -s
read -p "Did you really configure what I told you? If yes, press key ..." -n1 -s

echo "Creating build job"
docker exec -i loadtest_jenkins bash -c 'cat > /tmp/vertx-test.xml' < vertx-test.xml
docker exec loadtest_jenkins bash -c 'cat /tmp/vertx-test.xml | java -jar /tmp/jenkins-cli.jar -s http://localhost:8080/ create-job vertx-test'



