#! /bin/bash
# chkconfig: 2345 99 01
# description: (describe the process)
# processname: MASTERS

# Please prepare file 'config/unicorn_env', 'config/unicorn_port' and
# 'config/unicorn_user' which has only Rails environment, port No. and
# script-executing user in each of them, respectively.

if [ `uname` = "Darwin" ]
then
  MACOSX=Darwin
fi

if [ "$MACOSX" = "" ]
then
  READLINK_OPTIONS=-f
fi

RAILS_ROOT_DIR=$(dirname $(dirname $(readlink $READLINK_OPTIONS $0 || echo $0)))

PID_FILE=$RAILS_ROOT_DIR/tmp/pids/unicorn.pid
PID=$(head -1 $PID_FILE 2> /dev/null)
PS_RUNNING=$(ps h -p $PID 2> /dev/null)

ENVIRONMENT_FILE=$RAILS_ROOT_DIR/config/unicorn_env
ENVIRONMENT=$(head -1 $ENVIRONMENT_FILE) || exit

PORT_FILE=$RAILS_ROOT_DIR/config/unicorn_port
PORT=$(head -1 $PORT_FILE) || exit

USER_FILE=$RAILS_ROOT_DIR/config/unicorn_user
USER=$(head -1 $USER_FILE) || exit
CURRENT_USER=`whoami`

PS_GREP_PATTERN="$PID.*unicorn_rails"

START_SCRIPT=$RAILS_ROOT_DIR/bin/unicorn.sh
STOP_SCRIPT="kill $PID"

prog="MASTERS"

config_vars="environment=$ENVIRONMENT, port=$PORT, user=$USER"
msg_running="$prog is running (PID=$PID, $config_vars)"
msg_not_running="$prog is out of service ($config_vars)"


if [ "$ENVIRONMENT" = "development" ]
then
  export WEB_CONCURRENCY=1
fi


start() {
  if [ "$PID" != "" -a "$PS_RUNNING" != "" ]
  then
    echo $"$msg_running"
  else
    do_start
  fi
  return $?
}

do_start() {
  echo $"Starting $prog ..."
  if [ "$USER" = "" -o "$USER" = "$CURRENT_USER" ]
  then
    $START_SCRIPT
  else
    su - -c "$START_SCRIPT" $USER
  fi
}

stop() {
  if [ "$PID" = "" -o "$PS_RUNNING" = "" ]
  then
    echo $"$msg_not_running"
  else
    echo $"Stopping $prog ..."
    if [ "$USER" = "" -o "$USER" = "$CURRENT_USER" ]
    then
      $STOP_SCRIPT
    else
      su - -c "$STOP_SCRIPT" $USER
    fi
  fi
  return $?
}

restart(){
  stop && do_start
}

status() {
  if [ "$PID" = "" -o "$PS_RUNNING" = "" ]
  then
    echo $"$msg_not_running"
  else
    echo $"$msg_running"
    echo
    ps_index
    ps_server
  fi
}

ps_index() {
  ps -ef | grep PID | grep -v 'grep'
}

ps_server() {
  ps -ef | grep $PS_GREP_PATTERN | grep -v 'grep'
}


case "$1" in
  start)
    start
    ;;
  stop)
    stop
    ;;
  restart)
    restart
    ;;
  status)
    status
    ;;
  *)
    echo $"Usage: $0 {start|stop|restart|status}"
    RETVAL=1
esac

exit $RETVAL

