# 1. La arquitectura de tu sistema operativo y su versión de kernel:
echo -n "#Architecture   : "
uname -a

# 2. El número de núcleos físicos:
echo -n "#CPU physical   : "
grep "physical id" /proc/cpuinfo | wc -l

# 3. El número de núcleos virtuales:
echo -n "#vCPU           : "
grep "processor" /proc/cpuinfo | tail -n 1 | awk -F' ' '{print $3 + 1}'

# 4. La memoria RAM disponible actualmente en tu servidor y su porcentaje de uso:
echo -n "#Memory Usage   : "
free --mega | grep "Mem:" | awk -F' ' '{printf ("%d/%dMB (%.2f)%% \n", $3, $4,($3 * 100)/$4)}'

# 5. La memoria disponible actualmente en tu servidor y su utilización como un porcentaje:

# 6. El porcentaje actual de uso de tus núcleos:

# 7. La fecha y hora del último reinicio:
echo -n "#Last boot      : "
who -b | awk -F' ' '{printf("%s %s\n", $4, $5)}'

# 8. Si LVM está activo o no:
echo -n "#LVM use        : "
[ $(lsblk | grep "lvm" | wc -l) -gt 0 ] && echo "yes" || echo "no"

# 9. El número de conexiones activas:
echo -n "#TCP Connections: "
ss -ta | grep ESTAB | wc -l | awk '{printf ("%d (ESTABLISHED)\n", $1)}'

# 10. El número de usuarios del servidor:
# NOTA:
# He descartado el comando "w" porque, en un Mac, me devolvía el mismo usuario
# dos veces, con TTY diferente, y "users" me devolvía sólo uno de ellos,
# mientras que en una RPi 4, el resultado era diferente, devolviendo "users"
# el mismo usuario dos veces (el usuario "pi")
echo -n "#User log       : "
users | wc -w

# 11. La dirección IPv4 de tu servidor y su MAC (Media Access Control):
echo -n "#Network        : "
ip address show | grep 'inet' | grep -v 'inet6' | grep -v '127.0.0.1' | awk -F '[ ,/]'+ '{printf ("%s", $3)}'
ip address show | grep 'link/ether' | awk -F ' ' '{print " (" $2 ")"}'

# 12. El número de comandos ejecutados con sudo:


