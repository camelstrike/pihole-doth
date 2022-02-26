#!/bin/sh
ssh-keygen -A
exec /usr/sbin/sshd -e