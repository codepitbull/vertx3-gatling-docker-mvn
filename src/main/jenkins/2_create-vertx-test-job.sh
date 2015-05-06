#!/bin/bash
JK_CMD="java -jar jenkins-cli.jar -s http://localhost:8080/"
cat vertx-test.xml | $JK_CMD create-job vertx-test2
