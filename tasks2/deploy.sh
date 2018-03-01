#!/bin/bash

export PORT=5103
export MIX_ENV=prod
export GIT_PATH=/home/tasks2/src/tasks2

PWD=`pwd`
if [ $PWD != $GIT_PATH ]; then
	echo "Error: Must check out git repo to $GIT_PATH"
	echo "  Current directory is $PWD"
	exit 1
fi

if [ $USER != "tasks2" ]; then
	echo "Error: must run as user 'tasks2'"
	echo "  Current user is $USER"
	exit 2
fi

mix deps.get
(cd assets && npm install)
(cd assets && ./node_modules/brunch/bin/brunch b -p)
mix phx.digest
mix release --env=prod

mkdir -p ~/www
mkdir -p ~/old

NOW=`date +%s`
if [ -d ~/www/tasks2 ]; then
	echo mv ~/www/tasks2 ~/old/$NOW
	mv ~/www/tasks2 ~/old/$NOW
fi

mkdir -p ~/www/tasks2
REL_TAR=~/src/tasks2/_build/prod/rel/tasks1/releases/0.0.1/tasks1.tar.gz
(cd ~/www/tasks2 && tar xzvf $REL_TAR)

crontab - <<CRONTAB
@reboot bash /home/tasks2/src/tasks2/start.sh
CRONTAB

#. start.sh
