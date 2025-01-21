#!/bin/bash

##################################################################################################

#Arquitecture
archi=$(uname -a)

##################################################################################################

#CPUs
ph_cpu=$(cat /proc/cpuinfo | grep "physical id" | sort -u | wc -l)

v_cpu=$(cat /proc/cpuinfo | grep "processor" | sort -u | wc -l)

##################################################################################################

#RAM output
used_RAM=$(free --mega | grep "Mem" | awk '{print $3}' | tr -d ' ')

total_RAM=$(free --mega | grep "Mem" | awk '{print $2}' | tr -d ' ')

percentaje_RAM=$(free --mega | grep "Mem" | awk '{printf("%.2f"), $3/$2*100}')

##################################################################################################

#Available storage
used_disk=$(df -m | grep "/dev/" | grep -v -e "/boot" -e "devtmpfs" -e "tmpfs" | awk '{used += $3} END {print used}')

total_disk=$(df -m | grep "/dev/" | grep -v -e "/boot" -e "devtmpfs" -e "tmpfs" | awk '{total += $2} END {printf("%.0f"), total/1024}')

percentage_disk=$(df -m | grep "/dev/" | grep -v -e "/boot" -e "devtmpfs" -e "tmpfs" | awk '{total += $2} {used += $3} END {printf("%d"), used/total*100}')

##################################################################################################

#CPU Load
cpu_left=$(echo "scale=1; 100 - $(vmstat 1 2| tail -1 | awk '{printf("%.1f", $15)}')" | bc)

##################################################################################################

#Last reboot
last_boot=$(who -b | awk '$1 == "system" {print $3 " " $4}')

##################################################################################################

#LVM Usage
lvm_bool=$(if [ $(lsblk | grep "lvm" | wc -l) -ge 1 ]; then echo yes; else echo no; fi)

##################################################################################################

#TCP connections
tcp_connections=$(ss -ta | grep ESTAB | wc -l)

##################################################################################################

#Users in server
user_count=$(users | wc -w)

##################################################################################################

#IP and MAC
ip_var=$(ip a | grep "inet" | tail -2| head -1| awk '{print $2}')

mac_var=$(ip a | grep "link/ether" | awk '{print $2}')

##################################################################################################

sudo_count=$(journalctl -q _COMM=sudo | grep "COMMAND" | wc -l)

echo "#Architecture: ${archi}
#CPU physical : ${ph_cpu}
#vCPU : ${ph_cpu}
#Memory Usage: ${used_RAM}/${total_RAM}MB (${percentaje_RAM}%)
#Disk Usage: ${used_disk}/${total_disk}Gb (${percentage_disk}%)
#CPU Load: ${cpu_left}%
#Last boot: ${last_boot}
#LVM use: ${lvm_bool}
#Connections TCP : ${tcp_connections} ESTABLISHED
#User log: ${user_count}
#Network: IP ${ip_var} (${mac_var})
#Sudo : ${sudo_count}"
