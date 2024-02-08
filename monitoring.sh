#!/bin/bash
# 
# Script del proyecto Born2beroot
# Autor: Juan Carlos Fidalgo Fernández
# Fecha: lunes, 5 de febrero de 2024
# 


# 1. La arquitectura de tu sistema operativo y su versión de kernel:
architecture=$(uname -a)

# 2. El número de núcleos físicos:
cpu_physical=$(grep "physical id" /proc/cpuinfo | wc -l)

# 3. El número de núcleos virtuales:
	# v_cpu=$(grep "processor" /proc/cpuinfo | tail -n 1 | awk -F' ' '{print $3 + 1}')

# 4. La memoria RAM disponible actualmente en tu servidor y su porcentaje de uso:
	# memory_usage=$(free --mega | grep "Mem:" | awk -F' ' '{printf ("%d/%dMB (%.2f)%% \n", $3, $4,($3 * 100)/$4)}')

# 5. La memoria disponible actualmente en tu servidor y su utilización como un porcentaje:

# 6. El porcentaje actual de uso de tus núcleos:

# 7. La fecha y hora del último reinicio:
last_boot=$(who -b | awk -F' ' '{printf("%s %s\n", $4, $5)}')

# 8. Si LVM está activo o no:
lvm_use=$(if [ $(lsblk | grep "lvm" | wc -l) -gt 0 ]; then echo yes; else echo no; fi)

# 9. El número de conexiones activas:
	# tcp_connections=$(ss -ta | grep ESTAB | wc -l | awk '{printf ("%d (ESTABLISHED)\n", $1)}')

# 10. El número de usuarios del servidor:
# NOTA:
# He descartado el comando "w" porque, en un Mac, me devolvía el mismo usuario
# dos veces, con TTY diferente, y "users" me devolvía sólo uno de ellos,
# mientras que en una RPi 4, el resultado era diferente, devolviendo "users"
# el mismo usuario dos veces (el usuario "pi")
user_log=$(users | wc -w)

# 11. La dirección IPv4 de tu servidor y su MAC (Media Access Control):
	# ip=$(ip address show | grep 'inet' | grep -v 'inet6' | grep -v '127.0.0.1' | awk -F '[ ,/]'+ '{printf ("%s", $3)}')
	# mac=$(ip address show | grep 'link/ether' | awk -F ' ' '{print " (" $2 ")"}')

# 12. El número de comandos ejecutados con sudo:
	# sudo=$(journalctl _COMM=sudo | grep "COMMAND" | wc -l | awk '{print $1 " cmd(s)"}')

wall "
#Architecture   : $architecture
#CPU physical   : $cpu_physical
#Last boot      : $last_boot
#LVM use        : $lvm_use
"
#vCPU           : $v_cpu
#Memory Usage   : $memory_usage
#TCP Connections: $tcp_connections ESTABLISHED
#User log       : $user_log
#Network        : $ip $(mac_address)
#Sudo           : $sudo cmd(s)
