#! /bin/bash

HADOOP_CONF=/opt/hdfs/default/etc/hadoop
# HADOOP_CONF=github/roles/shared/hdfs

while [ $# -gt 0 ] ; do
    if [[ $1 == 172* ]]; then
        nodeArg=`host "$1" | awk '{ print $5 }' | awk 'BEGIN{FS=OFS="."} NF--'`
    else
        nodeArg="$1"
    fi

    exec < ${HADOOP_CONF}/rack_awareness.topology
    result=""
    while read line ; do
        ar=( $line )
        if [ "${ar[0]}" = "$nodeArg" ] ; then
          result="${ar[1]}"
        fi
    done

    shift
    if [ -z "$result" ] ; then
        echo -n "/rack/$nodeArg"
    else
        echo "$result"
    fi
done

exit 0
