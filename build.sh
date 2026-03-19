#!/bin/bash

docker pull kalilinux/kali-rolling
docker build --no-cache -t isaudits/kali:base -t isaudits/kali:latest .
docker build --no-cache -t isaudits/kali:msf -f Dockerfile.msf .
docker build --no-cache -t isaudits/kali:xfce -f Dockerfile.xfce .
docker image prune -f