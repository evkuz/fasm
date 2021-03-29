#!/bin/bash
# Delete binary executables as no needed in git

find . -type f  ! -name "*.*"  -delete

