
#!/bin/sh

echo "Mihomo 运行状态: $(pgrep -x mihomo > /dev/null && echo 运行中 || echo 未运行)"
echo "网络连接状态: $(ping -c 1 8.8.8.8 >/dev/null 2>&1 && echo 正常 || echo 异常)"
echo "内存占用:"
free -m | grep Mem
echo "CPU 占用率:"
top -bn1 | grep -i 'cpu' | head -n 1
