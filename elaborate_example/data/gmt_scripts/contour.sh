#!/bin/sh

gmt begin contour_light
	gmt set PS_CHAR_ENCODING = ISOLatin1+
	gmt set FONT_ANNOT_PRIMARY=10
	gmt set FONT_LABEL=10            
	gmt set MAP_ANNOT_ORTHO=SW
	gmt set PS_PAGE_ORIENTATION=PORTRAIT
	gmt set FORMAT_FLOAT_OUT=%.12lg

	gmt basemap -R0/40.5/0/73.5 -JX6.75/12.25 -B"x5+lHorizontal coordinate x (km)" -B"y5+lHorizontal coordinate y (km)" -BwESn -X4 -Y15
	awk '{print $1, $2, $3}' ../gravity_anomaly.dat | gmt blockmean -I0.5/0.5 -R0/40.5/0/73.5  -V  > tmp.mybmean
	gmt surface tmp.mybmean   -Gxyz.grd -I0.5/0.5 -R0/40.5/0/73.5 -T0.1 -V
	gmt grdcontour xyz.grd -C5 -A10+f8p,Helvetica-Bold -Wthin,blue, -JX 
	echo "34 51 N" | gmt pstext -JX -F+f24p+jLM 
	echo "33.5 52 \255" | gmt pstext -JX -F+f36p,Symbol+jLM 
gmt end

gmt begin contour_dark
	gmt set PS_CHAR_ENCODING = ISOLatin1+
	gmt set FONT_ANNOT_PRIMARY=10
	gmt set FONT_LABEL=10            
	gmt set MAP_ANNOT_ORTHO=SW
	gmt set PS_PAGE_ORIENTATION=PORTRAIT
	gmt set FORMAT_FLOAT_OUT=%.12lg

	gmt basemap -R0/40.5/0/73.5 -JX6.75/12.25 -B"x5+lHorizontal coordinate x (km)" -B"y5+lHorizontal coordinate y (km)" -BwESn+gblack -X4 -Y15 --MAP_FRAME_PEN=white --MAP_TICK_PEN=white \
      --FONT_LABEL=white --FONT_ANNOT=white
	awk '{print $1, $2, $3}' ../gravity_anomaly.dat | gmt blockmean -I0.5/0.5 -R0/40.5/0/73.5  -V  > tmp.mybmean
	gmt surface tmp.mybmean   -Gxyz.grd -I0.5/0.5 -R0/40.5/0/73.5 -T0.1 -V
	gmt grdcontour xyz.grd -C5 -A10+f8p,Helvetica-Bold -Wthin,white, -JX 
	echo "34 51 N" | gmt pstext -JX -F+f24p,white+jLM 
	echo "33.5 52 \255" | gmt pstext -JX -F+f36p,Symbol,white+jLM 
gmt end

pdf2svg contour_light.pdf contour_light.svg
pdf2svg contour_dark.pdf contour_dark.svg

rm -rf *.grd  
rm -rf *.mybmean
