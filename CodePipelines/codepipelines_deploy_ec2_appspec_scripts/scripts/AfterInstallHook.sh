#!/bin/bash
interpreter="node"

cd /home/ec2-user/$application_name

case $interpreter in

    "node")
        nohup npm start > /tmp/app.log 2>&1 &
    ;;

esac