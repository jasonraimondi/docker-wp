#!/usr/bin/env bash

cd build/$1
docker build -t jasonraimondi/$1:$2 -t jasonraimondi/$1:latest .
docker push jasonraimondi/$1:$2
docker push jasonraimondi/$1:latest
