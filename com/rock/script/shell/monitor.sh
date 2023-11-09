#!/bin/sh

#全局变量
file_url=""

#磁盘占用率报警统计-OK
disk(){
  file_url=$1
  if [ !${file_url} ];then
    #当命令没输入文件打印地址时，使用默认地址文件
    file_url="monitor.log"
  fi
  #通过awk进行Linux命令报文的格式化，并把输出的xx%结果使用sed把%去掉，单输出数值
  used_value=`df -h |awk -F ' ' '/\/dev\/disk3s5/{print $5}'|sed 's/%$//'`
  if [ -n "${used_value}" ];then
    msg="used_value:${used_value}"
    write_file "${msg}"
    if [ ${used_value} -gt 80 ];then
      msg="disk used over 80%. current ${used_value}%"
      write_file "${msg}"
      send_email "${msg}"
    elif [ ${used_value} -gt 50 ]; then
      msg="disk used over 50%. current ${used_value}%"
      write_file "${msg}"
    elif [ ${used_value} -gt 20 ]; then
      msg="disk used over 20%. current $used_value%"
      write_file "${msg}"
    else
      msg="disk used  ${used_value}"
      write_file "${msg}"
    fi
  else
      msg="monitor disk shell run fail!"
      write_file "${msg}"
      send_email "${msg}"
  fi
}

#写信息追加到文件中
write_file(){
  date1=`date +"%Y-%m-%d %H:%M:%S"`
  msg="${date1} $1 "
  echo ${msg} >> ${file_url}
}

#发送邮件
send_email(){
  msg_context=$1
  #使用管道来发送邮件信息
  `echo "Msg:\n ${msg_context}" |mail -s "Mac Monitor Message" qingyuan.cao@opay-inc.com`
}

#触发调用
disk $1


#触发命令：sh monitor.sh monitor.log
#