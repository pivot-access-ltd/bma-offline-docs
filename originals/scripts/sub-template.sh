#!/bin/bash -x
NAME=$1
sed -i "s/zork/$NAME/g" ./template.html
