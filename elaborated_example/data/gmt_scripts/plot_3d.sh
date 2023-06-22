#!/bin/sh

cat << EOF >| annots.txt
0 a 0
-1 a 1
-2 a 2
-3 a 3
-4 a 4
EOF

gmt begin true_light
	gmt set PS_CHAR_ENCODING = ISOLatin1+
	gmt set FONT_ANNOT_PRIMARY=10    
	gmt set FONT_LABEL=10
	gmt set COLOR_NAN=200/215/137
	gmt set PS_PAGE_ORIENTATION=PORTRAIT
	gmt set FORMAT_FLOAT_OUT=%.12lg
	gmt set MAP_ANNOT_ORTHO=NE

	gmt basemap -R0/40.5/0/73.5 -JX6.75/12.25 -Bxa10f5 -Bya10f5 -Bwesn -p145/45 -X4 -Y15
	awk '{print $1, $2, $3=$3*-1}' ../synthetic_xyz.dat | gmt blockmean -I0.1/0.1 -R0/40.5/0/73.5  -V  > tmp.mybmean
	#gmt surface tmp.mybmean   -Gxyz.grd -I0.1/0.1 -R0/40.5/0/73.5 -T0.1 -V
	gmt triangulate tmp.mybmean  -Gxyz.grd  -I0.05/0.05 -R0/40.5/0/73.5 -V
	gmt grdfilter  xyz.grd  -Gfiltered.nc -D0 -Fc1
	gmt grdgradient filtered.nc  -Ne0.35 -A225 -Gfiltered_i.nc 
	gmt grdimage xyz.grd -Cmola.cpt -JX -E60/30 -R0/40.5/0/73.5 -p145/45
	gmt grdcontour filtered.nc -C0.25  -Wthinnest,black, -JX -p145/45
	echo "34 51 N" | gmt pstext -JX -p145/45 -F+f24p+jLM
	echo "33.5 52 \255" | gmt pstext -JX -p145/45 -F+f36p,Symbol+jLM 
	gmt grdview filtered.nc -JX6.75/12.25 -JZ3 -Cmola.cpt -Ifiltered_i.nc -p145/45 -R0/40.5/0/73.5/-5/0 -N-5+gwhite -Qi200 -Y-11 -Wthin -V -B"xa10f5+lHorizontal coordinate x (km)" -B"ya10f5+lHorizontal coordinate y (km)" -B"zf0.5+lDepth (km)" -Bpzcannots.txt -BnESwZ
	gmt colorbar -Cmola.cpt -p -DJBC -Bxf0.5 -By+lkm -Bpxcannots.txt
gmt end

gmt begin true_dark
	gmt set PS_CHAR_ENCODING = ISOLatin1+
	gmt set FONT_ANNOT_PRIMARY=10    
	gmt set FONT_LABEL=10
	gmt set COLOR_NAN=200/215/137
	gmt set PS_PAGE_ORIENTATION=PORTRAIT
	gmt set FORMAT_FLOAT_OUT=%.12lg
	gmt set MAP_ANNOT_ORTHO=NE

	gmt basemap -R0/40.5/0/73.5 -JX6.75/12.25 -Bxa10f5 -Bya10f5 -Bwesn -p145/45 -X4 -Y15 --MAP_FRAME_PEN=white --MAP_TICK_PEN=white
	awk '{print $1, $2, $3=$3*-1}' ../synthetic_xyz.dat | gmt blockmean -I0.1/0.1 -R0/40.5/0/73.5  -V  > tmp.mybmean
	#gmt surface tmp.mybmean   -Gxyz.grd -I0.1/0.1 -R0/40.5/0/73.5 -T0.1 -V
	gmt triangulate tmp.mybmean  -Gxyz.grd  -I0.05/0.05 -R0/40.5/0/73.5 -V
	gmt grdfilter  xyz.grd  -Gfiltered.nc -D0 -Fc1
	gmt grdgradient filtered.nc  -Ne0.35 -A225 -Gfiltered_i.nc 
	gmt grdimage xyz.grd -Cmola.cpt -JX -E60/30 -R0/40.5/0/73.5 -p145/45
	gmt grdcontour filtered.nc -C0.25  -Wthinnest,black, -JX -p145/45
	echo "34 51 N" | gmt pstext -JX -p145/45 -F+f24p+jLM
	echo "33.5 52 \255" | gmt pstext -JX -p145/45 -F+f36p,Symbol+jLM
	gmt grdview filtered.nc -JX6.75/12.25 -JZ3 -Cmola.cpt -Ifiltered_i.nc -p145/45 -R0/40.5/0/73.5/-5/0 -N-5+gblack -Qi200 -Y-11 -Wwhite -V -B"xa10f5+lHorizontal coordinate x (km)" -B"ya10f5+lHorizontal coordinate y (km)" -B"zf0.5+lDepth (km)" -Bpzcannots.txt -BnESwZ --MAP_FRAME_PEN=white --MAP_TICK_PEN=white \
      --FONT_LABEL=white --FONT_ANNOT=white
	gmt colorbar -Cmola.cpt -p -DJBC -Bxf0.5 -By+lkm -Bpxcannots.txt --MAP_FRAME_PEN=white --MAP_TICK_PEN=white \
      --FONT_LABEL=white --FONT_ANNOT=white
gmt end

pdf2svg true_light.pdf true_light.svg
pdf2svg true_dark.pdf true_dark.svg

rm -rf *.grd  
rm -rf *.mybmean 
rm -rf *.nc 
