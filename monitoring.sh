# La arquitectura de tu sistema operativo y su versión de kernel:
uname -a

# El número de núcleos físicos:
grep "processor" /proc/cpuinfo | tail -n 1 | awk -F' ' '{print $3 + 1}'

