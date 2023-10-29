#!/bin/bash

docker pull kalilinux/kali-rolling
#hooks/build
docker buildx build -t isaudits/kali:base -t isaudits/kali:latest .
docker buildx build -t isaudits/kali:msf -f Dockerfile.msf .
docker buildx build -t isaudits/kali:xfce -f Dockerfile.xfce .
docker image prune -f