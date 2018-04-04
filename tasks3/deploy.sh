#!/bin/bash

export PORT=5105
export MIX_ENV=prod
export GIT_PATH=/home/tasks3/src/tasks3

PWD=`pwd`
if [ $PWD != $GIT_PATH ]; then
	echo "Error: Must check out git repo to $GIT_PATH"
	echo "  Current directory is $PWD"
	exit 1
fi

if [ $USER != "tasks3" ]; then
	echo "Error: must run as user 'tasks3'"
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
if [ -d ~/www/tasks3 ]; then
	echo mv ~/www/tasks3 ~/old/$NOW
	mv ~/www/tasks3 ~/old/$NOW
fi

mkdir -p ~/www/tasks3
REL_TAR=~/src/tasks3/_build/prod/rel/tasks3/releases/0.0.1/tasks3.tar.gz
(cd ~/www/tasks3 && tar xzvf $REL_TAR)

crontab - <<CRONTAB
@reboot bash /home/tasks3/src/tasks3/start.sh
CRONTAB

#. start.sh
