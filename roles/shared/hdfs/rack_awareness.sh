#! /bin/bash

HADOOP_CONF=/opt/hdfs/default/etc/hadoop

while [ $# -gt 0 ] ; do
  nodeArg=$1
  exec< ${HADOOP_CONF}/rack_awareness.topology
  result=""
  while read line ; do
    ar=( $line )
    if [ "${ar[0]}" = "$nodeArg" ] ; then
      result="${ar[1]}"
    fi
  done
  shift
  if [ -z "$result" ] ; then
    echo "/$1"
#    echo -n "/default/rack"
  else
    echo "$result"
  fi
done

