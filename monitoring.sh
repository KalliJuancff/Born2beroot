# La arquitectura de tu sistema operativo y su versión de kernel:
echo -n "#Architecture: "
uname -a

# El número de núcleos físicos:
echo -n "#CPU physical: "
grep "physical id" /proc/cpuinfo | wc -l

# El número de núcleos virtuales:
echo -n "#vCPU        : "
grep "processor" /proc/cpuinfo | tail -n 1 | awk -F' ' '{print $3 + 1}'

