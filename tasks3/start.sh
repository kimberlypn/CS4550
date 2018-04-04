#!/bin/bash

export PORT=5105

cd ~/www/tasks3
./bin/tasks3 stop || true
./bin/tasks3 start

