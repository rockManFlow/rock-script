# rock-script
脚本语言或脚本相关知识


---------
### shell脚本
#### 定时书写
>定时任务在Linux和Mac中使用crontab进行脚本的配置  
>Linux和Mac的用法基本一致  
>常用命令：  
>crontab -l 查看当前定时任务  
>crontab -e 编辑定时任务  
>crontab -r 删除定时任务  
>
>crontab命令格式与cron格式有点区别，从分开始  
>*　　*　　*　　*　　*　　command  
>分  时　 日　 月　 周　    命令  
> 在文件中直接输入 0/1 * * * * ? sh /Users/opayc/products/rock-script/com/rock/script/shell/monitor.sh /Users/opayc/products/rock-script/com/rock/script/shell/monitor.log

---------