docker exec loadtest_jenkins curl -o /tmp/jenkins-cli.jar http://localhost:8080/jnlpJars/jenkins-cli.jar
docker exec loadtest_jenkins java -jar /tmp/jenkins-cli.jar -s http://localhost:8080/ install-plugin credentials
docker exec loadtest_jenkins java -jar /tmp/jenkins-cli.jar -s http://localhost:8080/ install-plugin ssh-credentials
docker exec loadtest_jenkins java -jar /tmp/jenkins-cli.jar -s http://localhost:8080/ install-plugin envinject
docker exec loadtest_jenkins java -jar /tmp/jenkins-cli.jar -s http://localhost:8080/ install-plugin ssh
docker exec loadtest_jenkins java -jar /tmp/jenkins-cli.jar -s http://localhost:8080/ install-plugin git
docker exec loadtest_jenkins java -jar /tmp/jenkins-cli.jar -s http://localhost:8080/ install-plugin git-client
docker exec loadtest_jenkins java -jar /tmp/jenkins-cli.jar -s http://localhost:8080/ safe-restart


docker exec -i loadtest_jenkins bash -c 'cat > /tmp/ca.pem' < /Users/jmader/.boot2docker/certs/boot2docker-vm/ca.pem
docker exec -i loadtest_jenkins bash -c 'cat > /tmp/cert.pem' < /Users/jmader/.boot2docker/certs/boot2docker-vm/cert.pem
docker exec -i loadtest_jenkins bash -c 'cat > /tmp/key.pem' < /Users/jmader/.boot2docker/certs/boot2docker-vm/key.pem

read -p "Point your browser to the running Jenkins instance, add an ssh-host and configure maven, then press a key to continue " -n1 -s
read -p "Did you really configure what I told you? If yes, press key ..." -n1 -s

docker exec -i loadtest_jenkins bash -c 'cat > /tmp/vertx-test.xml' < vertx-test.xml
docker exec loadtest_jenkins bash -c 'cat /tmp/vertx-test.xml | java -jar /tmp/jenkins-cli.jar -s http://localhost:8080/ create-job vertx-test'



