#!/usr/bin/env bash
set -eu -o pipefail

dem="$1"

# For pixel resolution and size we are assuming equal x/y values for now
px_res=$(gdalinfo $dem \
    | grep 'Pixel Size' \
    | sed -e 's/.*(//' -e 's/,.*//')
px_size=$(gdalinfo $dem \
    | grep 'Size is' \
    | sed -e 's/.*, //')

y_scale=$(bc -l <<< "9000 / 65535 * 1.4")

# export variables needed in the POV-Ray scene to an include file
echo "#declare HeightFieldScale = <1, $y_scale, 1>;" > dem.inc

gdal_translate \
    -ot UInt16 \
    -scale 0 9000 0 65535 \
    -co profile=baseline \
    -co tfw=yes \
    $dem localized.tif

povray dem.ini
