#!/bin/bash
#/home/evkuz/asm
result="/home/evkuz/asm/mid_val.txt"

date >> $result

if [ $? -eq 0 ]
  then
   echo "It's OK"
else
   echo "Error !"
fi
