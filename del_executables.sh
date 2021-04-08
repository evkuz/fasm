#!/bin/bash
# Delete binary executables as no needed in git
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! Эта команда затирает все служебные файлы в папке .git !!!!!!!!!!!!!!!!!!!!
# Нельзя запускать из asm/

#find . -type f  ! -name "*.*"  -delete

# Чтобы удалять только в текущей директории 
find . -maxdepth 1 type f  ! -name "*.*"  -delete
