#!/bin/bash

FILE_1="data_C.bin"
FILE_2="data_C_01.bin"

md5_1=$(md5sum $FILE_1)
md5_2=$(md5sum $FILE_2)

echo $md5_1
echo $md5_2

if [[ "$md5_1"=="$md5_2" ]]; then
   echo "Совпало !!!"
else
   echo "Не совпало, работай дальше."
fi
