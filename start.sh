#!/bin/bash

#Runtime Setup

MODE=prod
SERVICE_NAME="springboot-web"
APP_PATH="/app/${SERVICE_NAME}"

test -d /app/logs/${SERVICE_NAME}/ || mkdir -p /app/logs/${SERVICE_NAME}/

#Default Environment Values:

if [ "empty$1" = 'empty' ]; then
  echo "using production configuration"
else
  echo "using $1 configuration"
  MODE=$1
fi

JAVA_OPTS="$JAVA_OPTS -Dfile.encoding=UTF-8 -Dspring.profiles.active=$MODE"
if [ "empty$1" = 'empty' ]; then
  echo "Startup ${APP_PATH} with production mode"
  JAVA_OPTS="${JAVA_OPTS} -Xmx512M -Xms512M -server -XX:+UseG1GC -XX:MaxGCPauseMillis=50 -XX:InitiatingHeapOccupancyPercent=35 -XX:+ExplicitGCInvokesConcurrent"
else
  echo "Startup ${APP_PATH} with $1 mode"
fi


nohup ${JAVA_HOME}/bin/java ${JAVA_OPTS} -jar ${APP_PATH}/${SERVICE_NAME}.jar > /app/logs/${SERVICE_NAME}/${SERVICE_NAME}_startup.log 2>&1 &

for t_s in {1..10} ;do
  sleep 1
  APP_PID=$(ps -ef | grep ${APP_PATH} | grep -Ev "grep" | awk -F " " '{print $2}')
  if [ "null$APP_PID" != "null" ];then
    echo ${APP_PID} > ${pidfile}
    break
  fi
done
