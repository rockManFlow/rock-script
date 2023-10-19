#!/bin/sh

#todo 验证没问题
#自定义实现一个shell启动脚本：开始、停止、重启、状态检测
PRODUCT_NAME=""
SERVER_PORT=8000

JAVA_HOME="/Users/opayc/Library/Java/JavaVirtualMachines/azul-1.8.0_322/Contents/Home/bin"
JAVA_OPTS="-Xmx256m -Xms256m -XX:MetaspaceSize=128m -XX:MaxMetaspaceSize=256m -XX:+UseConcMarkSweepGC -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=/data/logs"
RUNNING_USER="opayc"
pid=0

checkPid(){
  command_result=`${JAVA_HOME}/jps -l|grep ${PRODUCT_NAME}| awk '{print $1}'`
  echo "pid:$command_result"
  if [ -n "${command_result}" ];then
    pid=${command_result}
  else
    pid=0
  fi
}

start(){
  PRODUCT_NAME=$1
  echo "start run application: ${PRODUCT_NAME}..."
  #获取 pid
  checkPid
  if [ $pid == 0 ];then
    JAVA_OPTS="${JAVA_OPTS} -Dserver.port=${SERVER_PORT}"
    JAVA_CMD="nohup ${JAVA_HOME}/java ${JAVA_OPTS} -jar ${PRODUCT_NAME}  >/dev/null 2>&1 &"
    #JAVA_CMD="nohup ${JAVA_HOME}/java ${JAVA_OPTS} -jar ${PRODUCT_NAME}  >/Users/opayc/products/rock-script/com/rock/script/shell/output.out &"
    #JAVA_CMD="${JAVA_HOME}/java ${JAVA_OPTS} -jar ${PRODUCT_NAME} &"
    #JAVA_CMD="${JAVA_HOME}/java ${JAVA_OPTS} -jar ${PRODUCT_NAME} &"
    echo $JAVA_CMD
    #完整的切换到一个用户环境，并-c 执行命令
    #su - $RUNNING_USER -c "$JAVA_CMD"
    `echo "${JAVA_CMD}"`
    checkPid
    if [ $pid -ne 0 ];then
      echo "application:${PRODUCT_NAME} start finish pid:${pid}."
    else
      echo "application:${PRODUCT_NAME} start fail."
    fi
  else
    echo "application:${PRODUCT_NAME} start fail. reason:application started pid:${pid}."
  fi
}

stop(){
  PRODUCT_NAME=$1
  checkPid
  if [ $pid -ne 0 ];then
    JAVA_CMD="kill -9 ${pid}"
    #su - $RUNNING_USER -c "$JAVA_CMD"
    `echo $JAVA_CMD`
    checkPid
    if [ $pid == 0 ];then
      echo "[OK]"
    else
      echo "[Fail]"
    fi
  else
    echo "warn: $PRODUCT_NAME is not running"
  fi
}

status(){
  PRODUCT_NAME=$1
  checkPid
  echo $pid
  if [ $pid -ne 0 ];then
    echo "$PRODUCT_NAME is running.pid:$pid"
  else
    echo "warn: $PRODUCT_NAME is not running"
  fi
}

restart(){
  PRODUCT_NAME=$1
  stop $PRODUCT_NAME
  start $PRODUCT_NAME
}

case "$1" in
  'start')
    start $2
    ;;
  'stop')
    stop $2
    ;;
  'restart')
    restart $2
    ;;
  'status')
    status $2
    ;;
  *)
    echo "Usage: {start|stop|restart|status applicationName}"
    exit 1
esac

