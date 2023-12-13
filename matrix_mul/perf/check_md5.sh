#!/bin/bash

FILE_1="data_C_00.bin" # Это эталонный файл
FILE_2="data_C.bin" # Файл после оптимизации

do_mult="gemm_lods_02_4x5x3"
do_mult_opt="gemm_lods_03_4x5x3"


#./$do_mult
#mv $FILE_1 $FILE_2

# Перемножаем
# ./$do_mult_opt
#mv $FILE_1 $FILE_2

md5_1=$(md5sum $FILE_1)
md5_2=$(md5sum $FILE_2)

echo $md5_1
echo $md5_2

md5_1=$(md5sum $FILE_1 | awk '{print $1}')
md5_2=$(md5sum $FILE_2 | awk '{print $1}')

echo $md5_1
echo $md5_2

# Пробелы очень важны !!! Если убрать будет всегда совпадать :)
if [ "$md5_1" == "$md5_2" ]; then
   echo "Совпало !!!"
else
   echo "Не совпало, работай дальше."
fi
