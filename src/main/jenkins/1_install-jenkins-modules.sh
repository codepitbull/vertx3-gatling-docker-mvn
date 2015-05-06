#!/bin/bash
JK_CMD="java -jar jenkins-cli.jar -s http://localhost:8080/"

$JK_CMD install-plugin credentials
$JK_CMD install-plugin envinject
$JK_CMD install-plugin ssh
