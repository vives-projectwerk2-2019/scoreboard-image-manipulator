#!/bin/sh
if [ -f fonts.c ]; then
    rm fonts.c
fi

for i in {A..Z}; do
    convert -resize 7x13\! -font DejaVu-Sans-Mono -pointsize 10 label:$i $i.xbm
    cat $i.xbm >> fonts.c
    rm $i.xbm
done
