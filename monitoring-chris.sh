#!/bin/bash

#Arch
architecture=$(uname -a)

#CPU Physical
cpuPhys=$(grep "physical id" /proc/cpuinfo | wc -l)

#vCPU
vCPU=$(grep "processor" /proc/cpuinfo | wc -l)

#Memory usage
memUsed=$(free --mega | awk 'FNR == 2 {print $3}')
memTotal=$(free --mega | awk 'FNR == 2 {print $2}')
memPerc=$(free --mega | awk 'FNR == 2 {printf("%.2f"), $3*100/$2}')

#Disk Usage
diskUsed=$(df -m | grep "/dev/" | grep -v "/boot" | awk '{disk_us += $3} END {print disk_us}')
diskTotal=$(df -m | grep "/dev/" | grep -v "/boot" | awk '{disk_tot += $2} END {printf("%.1fGb"), disk_tot/1024}')
diskPerc=$(df -m | grep "/dev/" | grep -v "/boot" | awk '{disk_us += $3} {disk_tot += $2} END {printf("%d"), disk_us*100/disk_tot}')

#CPU load
cpuLoad=$(vmstat 1 2 | tail -1 | awk '{print $15}')
cpuParsed=$(printf "%.1f" $(expr 100 - $cpuLoad))

#Last boot
lastBoot=$(who -b | awk 'FNR == 1 {print $3 " " $4}')

#LVM use
lvmUse=$(if [ $(lsblk | grep "lvm" | wc -l) -gt 0 ]; then echo yes; else echo no; fi)

#TCP Connections
tcpConn=$(ss -ta | grep "ESTAB" | wc -l)

#User log
userLog=$(users | wc -w)

#Network
ip=$(hostname -I)
mac=$(ip a | grep "link/ether" | awk '{print $2}')

#Sudo
sudo=$(journalctl _COMM=sudo | grep COMMAND | wc -l)

wall " Architecture: $architecture
CPU Physical: $cpuPhys
vCPU: $vCPU
Memory Usage: $memUsed/${memTotal}MB ($memPerc%)
Disk Usage: $diskUsed/${diskTotal} ($diskPerc%)
CPU Load: $cpuParsed%
Last boot: $lastBoot
LVM use: $lvmUse
TCP Connections: $tcpConn Established
User log: $userLog
Network: IP $ip ($mac)
Sudo: $sudo cmd"
