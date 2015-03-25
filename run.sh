#!/bin/sh

pm2 start -x -i $PROCESSES $SCRIPT --no-daemon

