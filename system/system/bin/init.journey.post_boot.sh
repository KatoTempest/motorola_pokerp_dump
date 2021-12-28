#! /system/bin/sh


function configure_memory_parameters()
{
    arch_type=`uname -m`
    MemTotalStr=`cat /proc/meminfo | grep MemTotal`
    MemTotal=${MemTotalStr:16:8}
    if [ "$arch_type" == "aarch64" ] && [ $MemTotal -gt 4194304 ]; then
         echo "27648,34560,48384,32256,131072,196608" > /sys/module/lowmemorykiller/parameters/minfree
    elif [ "$arch_type" == "aarch64" ] && [ $MemTotal -gt 3145728 ]; then
        echo "27648,34560,48384,32256,98304,131072" > /sys/module/lowmemorykiller/parameters/minfree
    elif [ "$arch_type" == "aarch64" ] && [ $MemTotal -gt 2097152 ]; then
        echo "18432,23040,27648,32256,55296,80640" > /sys/module/lowmemorykiller/parameters/minfree
    elif [ "$arch_type" == "aarch64" ] && [ $MemTotal -gt 1048576 ]; then
        echo "18432,23040,27648,32256,45000,65000" > /sys/module/lowmemorykiller/parameters/minfree
    elif [ "$arch_type" == "armv7l" ] && [ $MemTotal -gt 4194304 ]; then
         echo "27648,34560,48384,32256,131072,196608" > /sys/module/lowmemorykiller/parameters/minfree
    elif [ "$arch_type" == "armv7l" ] && [ $MemTotal -gt 3145728 ]; then
        echo "27648,34560,48384,32256,98304,131072" > /sys/module/lowmemorykiller/parameters/minfree
    elif [ "$arch_type" == "armv7l" ] && [ $MemTotal -gt 2097152 ]; then #dong.wang add LOW_MEMORY_OPTIMIZE
        echo "18432,23040,27648,32256,55296,80640" > /sys/module/lowmemorykiller/parameters/minfree
    elif [ "$arch_type" == "armv7l" ] && [ $MemTotal -gt 1048576 ]; then
        echo "0,58,117,176,529,1000" > /sys/module/lowmemorykiller/parameters/adj
        echo "18432,23040,27648,32256,55296,102400" > /sys/module/lowmemorykiller/parameters/minfree
    else
         echo "TODO"
    fi
}

log -t journey_post -p w "start configure_memory_parameters"
# adj lowmemorykill minfree size
configure_memory_parameters
