#!/bin/bash

docker pull kalilinux/kali-rolling
hooks/build
docker image prune -f