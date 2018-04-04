#!/bin/bash

export PORT=5105

cd ~/www/tasks3
./bin/tasks1 stop || true
./bin/tasks1 start

