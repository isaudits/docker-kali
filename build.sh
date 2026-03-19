#!/bin/bash

docker pull kalilinux/kali-rolling
docker build -t isaudits/kali:base -t isaudits/kali:latest .
docker build -t isaudits/kali:msf -f Dockerfile.msf .
docker build -t isaudits/kali:xfce -f Dockerfile.xfce .
docker image prune -f