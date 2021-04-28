#!/bin/bash
# Delete binary executables as no needed in git
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! Эта команда затирает все служебные файлы в папке .git !!!!!!!!!!!!!!!!!!!!
# Нельзя запускать из asm/

#find . -type f  ! -name "*.*"  -delete

# Чтобы удалять только в текущей директории 
#find . -maxdepth 1 -type f ! -name "*.*"  -delete

# Так можно, но удаляются bash-скрипт... 
find . -type f -executable -delete

# А так работает. Удаляются файлы без расширения только в текущей директории maxdepth ==1 
# find . -maxdepth 1 -type f ! -name "*.*" -delete
