#!/bin/bash
# 
# Script del proyecto 'Born2beroot'
# Autor: Juan Carlos Fidalgo Fernández
# Fecha: lunes, 5 de febrero de 2024
# 


# 1. La arquitectura de tu sistema operativo y su versión de kernel:
architecture=$(uname -a)

# 2. El número de núcleos físicos:
cpu_physical=$(grep "physical id" /proc/cpuinfo | wc -l)

# 3. El número de núcleos virtuales:
v_cpu=$(grep "processor" /proc/cpuinfo | tail -n 1 | awk '{print $3 + 1}')

# 4. La memoria RAM disponible actualmente en tu servidor y su porcentaje de uso:
total_memory=$(free --mega | grep "Mem:" | awk '{print $2}')
used_memory=$(free --mega | grep "Mem:" | awk '{print $3}')
percentage_memory=$(((used_memory * 100) / total_memory))
percentage_memory=$(echo $percentage_memory | awk '{printf "%.2f", $1}')

# 5. La memoria disponible actualmente en tu servidor y su utilización como un porcentaje:
total_disk=$(df -m | grep "/dev/" | grep -v "/boot" | awk '{total += $2} END {print total}')
used_disk=$(df -m | grep "/dev/" | grep -v "/boot" | awk '{used += $3} END {print used}')
percentage_disk=$(((used_disk * 100) / total_disk))
total_disk=$(echo $total_disk | awk '{printf "%.2f", ($1 / 1024)}')
percentage_disk=$(echo $percentage_disk | awk '{printf "%.2f", $1}')

# 6. El porcentaje actual de uso de tus núcleos:
cpu_load=$(vmstat | tail -1 | awk '{print $15}')
cpu_load=$(echo $cpu_load | awk '{printf "%.2f", (100 - $1)}')

# 7. La fecha y hora del último reinicio:
last_boot=$(who -b | awk '{printf "%s %s\n", $3, $4}')

# 8. Si LVM está activo o no:
lvm_use=$(if [ $(lsblk | grep "lvm" | wc -l) -gt 0 ]; then echo yes; else echo no; fi)

# 9. El número de conexiones activas:
tcp_connections=$(ss -ta | grep "ESTAB" | wc -l | awk '{print $1}')

# 10. El número de usuarios del servidor:
# NOTA:
# He descartado el comando "w" porque, en un Mac, me devolvía el mismo usuario
# dos veces, con TTY diferente, y "users" me devolvía sólo uno de ellos,
# mientras que en una RPi 4, el resultado era diferente, devolviendo "users"
# el mismo usuario dos veces (el usuario "pi")
user_log=$(users | wc -w)

# 11. La dirección IPv4 de tu servidor y su MAC (Media Access Control):
ip_address=$(ip address show | grep 'inet' | grep -v 'inet6' | grep -v '127.0.0.1' | awk -F '[ ,/]'+ '{print $3}')
mac_address=$(ip address show | grep 'link/ether' | awk '{print $2}')

# 12. El número de comandos ejecutados con sudo:
sudo=$(journalctl _COMM=sudo | grep "COMMAND" | wc -l | awk '{print $1}')

wall "
**********************
RESUMEN INFO. SISTEMA:
**********************

#Architecture   : $architecture
#CPU physical   : $cpu_physical
#vCPU           : $v_cpu
#Memory Usage   : $used_memory/$total_memory"MB" ($percentage_memory%)
#Disk Usage     : $used_disk/$total_disk"Gb" ($percentage_disk%)
#CPU Load       : $cpu_load%
#Last boot      : $last_boot
#LVM use        : $lvm_use
#TCP Connections: $tcp_connections (ESTABLISHED)
#User log       : $user_log
#Network        : $ip_address ($mac_address)
#Sudo           : $sudo cmd(s)
"
