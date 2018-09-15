#!/bin/bash

docker pull kalilinux/kali-linux-docker
docker build -t kali .
#docker build --no-cache -t kali .
docker image prune -f