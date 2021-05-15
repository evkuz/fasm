#!/bin/bash
# Скрипт заменяет путь в директиве include для fasm


# export FASM_DIR

ORIGINAL="\/home\/localstudent\/asm"
NEW="%FASM_DIR%"
FNAME="randomizer_param.fasm"

cd matrix_mul/perf/

#sed -i 's/\/home\/localstudent\/asm/%FASM_DIR%/' $FNAME

# Специально ставим 2-ные кавычки, чтобы использовать переменные bash
sed -i "s/$ORIGINAL/$NEW/" $FNAME

# А вообще, надо получить список файлов с расширением *.fasm и скормить этот список sed-у

