#!/bin/bash

docker pull kalilinux/kali-linux-docker
hooks/build
docker image prune -f