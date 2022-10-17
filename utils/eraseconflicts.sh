#!/bin/bash
find ./tags -name '*(conflicted*' -print0 | while read -d $'\0' file
do
    echo $file
    rm -f "$file"
done
