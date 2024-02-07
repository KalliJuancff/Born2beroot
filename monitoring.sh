# 1. La arquitectura de tu sistema operativo y su versión de kernel:
echo -n "#Architecture: "
uname -a

# 2. El número de núcleos físicos:
echo -n "#CPU physical: "
grep "physical id" /proc/cpuinfo | wc -l

# 3. El número de núcleos virtuales:
echo -n "#vCPU        : "
grep "processor" /proc/cpuinfo | tail -n 1 | awk -F' ' '{print $3 + 1}'

# 4. La memoria RAM disponible actualmente en tu servidor y su porcentaje de uso:
echo -n "#Memory Usage: "
free --mega | grep "Mem:" | awk -F' ' '{printf ("%d/%dMB (%.2f)%% \n", $3, $4,($3 * 100)/$4)}'

# 5. La memoria disponible actualmente en tu servidor y su utilización como un porcentaje:

# 6. El porcentaje actual de uso de tus núcleos:

# 7. La fecha y hora del último reinicio:

# 8. Si LVM está activo o no:

# 9. El número de conexiones activas:

# 10. El número de usuarios del servidor:

# 11. La dirección IPv4 de tu servidor y su MAC (Media Access Control):

# 12. El número de comandos ejecutados con sudo:

