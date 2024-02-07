# La arquitectura de tu sistema operativo y su versión de kernel:
echo -n "#Architecture: "
uname -a

# El número de núcleos físicos:
echo -n "#CPU physical: "
grep "physical id" /proc/cpuinfo | wc -l

# El número de núcleos virtuales:
echo -n "#vCPU        : "
grep "processor" /proc/cpuinfo | tail -n 1 | awk -F' ' '{print $3 + 1}'

# La memoria RAM disponible actualmente en tu servidor y su porcentaje de uso:
echo -n "#Memory Usage: "
free --mega | grep "Mem:" | awk -F' ' '{printf ("%d/%dMB (%.2f)%% \n", $3, $4,($3 * 100)/$4)}'

