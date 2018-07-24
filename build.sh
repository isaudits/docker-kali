#!/bin/bash

docker pull kalilinux/kali-linux-docker
docker build --no-cache -t kali .
docker image prune -f