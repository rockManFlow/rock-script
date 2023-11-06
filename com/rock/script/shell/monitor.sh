#!/bin/sh
#定时任务在Linux和Mac中使用crontab进行脚本的配置
#
#磁盘占用率报警统计-OK
disk(){
  #通过awk进行Linux命令报文的格式化，并把输出的xx%结果使用sed把%去掉，单输出数值
  used_value=`df -h |awk -F ' ' '/\/dev\/disk3s5/{print $5}'|sed 's/%$//'`
  if [ -n "${used_value}" ];then
    echo "used_value:${used_value}"
    if [ ${used_value} -gt 80 ];then
      echo "disk used over 80%.current ${used_value}%"
    elif [ ${used_value} -gt 50 ]; then
      echo "disk used over 50%.current ${used_value}%"
    elif [ ${used_value} -gt 20 ]; then
         echo "disk used over 20%.current ${used_value}%"
    else
         echo "disk used  ${used_value}"
    fi
  else
      echo "run error"
  fi
}

#触发调用
disk

#0 0/1 * * * ? sh /Users/opayc/products/rock-script/com/rock/script/shell/monitor.sh > /Users/opayc/products/rock-script/com/rock/script/shell/monitor.log