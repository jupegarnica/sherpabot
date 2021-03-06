#!/bin/sh

USER_HOME="/home/jupegarnica"
HUBOT_ROOT="$USER_HOME/sherpabot"
HUBOT_HOME="$HUBOT_ROOT"
DAEMON="$HUBOT_HOME/bin/hubot"
PIDFILE=$HUBOT_ROOT/hubot.pid
touch $HUBOT_ROOT/hubot.log
case "$1" in
start)
        echo "Starting"
        . $HUBOT_ROOT/bin/.hubotrc
        /sbin/start-stop-daemon --start --background --pidfile $PIDFILE --make-pidfile -d $HUBOT_ROOT --startas /bin/bash -- -c "exec $DAEMON >> $HUBOT_ROOT/hubot.log 2>&1"
        echo "."
        ;;
debug)
        echo "Debug mode: no backgrounding"
        . $HUBOT_ROOT/bin/.hubotrc
        /sbin/start-stop-daemon --start --pidfile $PIDFILE --make-pidfile -d $HUBOT_ROOT --startas /bin/bash -- -c "exec $DAEMON  >> $HUBOT_ROOT/hubot.log 2>&1"
        echo "."
        ;;        
stop)
        echo "Stopping"
        /sbin/start-stop-daemon --stop --pidfile $PIDFILE
        echo "."
        ;;  
restart)
        echo "Restarting"
        /sbin/start-stop-daemon --stop --pidfile $PIDFILE
        . $HUBOT_ROOT/bin/.hubotrc
        /sbin/start-stop-daemon --start --pidfile $PIDFILE --make-pidfile --background -d $HUBOT_ROOT --startas /bin/bash -- -c "exec $DAEMON >> $HUBOT_ROOT/hubot.log 2>&1"
        echo "."
        ;;


    *)
        echo "Usage: $0 {start|stop|restart|debug}" >&2
        exit 1
        ;;  
    esac
    exit
