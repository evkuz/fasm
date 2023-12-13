#!/bin/bash

FILE_1="data_C.bin" # Это исходный, самый медленный файл
FILE_2="data_C_next.bin" # Файл после оптимизации
FILE_3="data_C_optimized.bin"
FILE_4="data_C_opt_02.bin"
timestamp="times.txt"


do_mult_next="matrix_mult_param_next"
do_mult="matrix_mult_param_optimized"
do_mult_opt="matrix_mult_param_opt_02"
args="8000000 2000 1000 8000000 2000"


touch $timestamp
cp /dev/null $timestamp

./$do_mult_next $args >> $timestamp
mv $FILE_1 $FILE_2
echo "!!!!!!!! Finished with 1st" >> $timestamp

./$do_mult $args >> $timestamp
mv $FILE_1 $FILE_3
echo "!!!!!!!! Finished with 2nd" >> $timestamp

# Перемножаем
./$do_mult_opt $args >> $timestamp
mv $FILE_1 $FILE_4
echo "!!!!!!!! Finished with 3rd" >> $timestamp

#md5_1=$(md5sum $FILE_1)
md5_2=$(md5sum $FILE_2)
md5_3=$(md5sum $FILE_3)
md5_4=$(md5sum $FILE_4)

#echo $md5_1
echo $md5_2
echo $md5_3
echo $md5_4


md5_2=$(md5sum $FILE_2 | awk '{print $1}')
md5_3=$(md5sum $FILE_3 | awk '{print $1}')
md5_4=$(md5sum $FILE_4 | awk '{print $1}')

echo $md5_2
echo $md5_3
echo $md5_4

# Пробелы очень важны !!! Если убрать будет всегда совпадать :)
if [ "$md5_1" == "$md5_2" ]; then
   echo "Совпало !!!"
else
   echo "Не совпало, работай дальше."
fi
