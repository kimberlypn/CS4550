#!/bin/bash

export PORT=5103

cd ~/www/tasks2
./bin/tasks1 stop || true
./bin/tasks1 start

