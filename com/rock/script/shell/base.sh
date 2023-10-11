#!/bin/sh

a="ddddd"
echo $a
b="ddddd"

#字符串拼接
c="$b,8888,$a"
echo "字符串拼接：$c"

echo "字符串长度：${#c}"

array_name[0]="1111"
array_name[1]="2222"
array_name[2]="3333"

echo "获取单个数组信息：${array_name[1]}"
echo "获取所有数组信息：${array_name[*]}"

e=111
f=111
if [ $e -eq $f ];then
  echo "两个数 ${e} 与 ${f}相等"
else
  echo "两个数${e}与${f}不相等"
fi

share_param="share"
method(){
  echo "first method"
  echo "method 输出共享变量：$share_param"
  echo "input param first: $1"
  echo "input param second: $2"
  share_param="method set"
}

main_method(){
  echo "main_method entry"
  share_param="main set"
  method "aaaa" 2222
  echo "main_method 输出共享变量：$share_param"
  echo "main_method end"
}
#触发调用函数
main_method

