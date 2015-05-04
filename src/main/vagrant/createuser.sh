#!/usr/bin/expect
# see https://www.vultr.com/docs/setup-your-own-docker-registry-on-coreos
set command "/usr/bin/docker login 127.0.0.1:5000"
spawn {*}$command
expect "Username: " { send "test\r" }
expect "Password: " { send "test\r" }
expect "Email: " { send "test@test.de\r" }
interact