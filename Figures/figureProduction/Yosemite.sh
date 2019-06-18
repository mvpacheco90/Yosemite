## Set the subsampling from original data set
res=10

## Subsample the data set (only needs to be done once)
#awk 'NR%${res}==1' points.txt > points${res}.txt

## Transform into degree coordinates:
#gmt mapproject points${res}.txt -Ju+11/1:1 -C -I -F > points${res}degrees.txt

## Interpolate into a surface grid. Good resolution is -I0.00005
#gmt surface points${res}degrees.txt -T0.5 -GYosemite${res}.grd -I0.00005 -R-119.695/-119.5105/37.68/37.8

## Calculate the shadow grid
#gmt grdgradient Yosemite${res}.grd -GYos${res}shade.grd -A270 -Nt #-Ne0.6

## Plot it
gmt grdimage -Cgray Yos${res}shade.grd -R-119:40/37:41.3/-119:32/37:46.8r -JOc119:36/37:44/120/67/15c  -K  > Yosemite.ps

## Draw the lon/lat markers
gmt set MAP_ANNOT_OBLIQUE 34
gmt psbasemap -J -R -Bya1m -BnEsW -O -K >> Yosemite.ps
gmt psbasemap -J -R -Bxa3m -BNesw -O -K >> Yosemite.ps


# ## Place the labels
# gmt pstext -R -J -D-1c/-4c -N -O -K >> Yosemite.ps <<EOF
# -119:38 37:44 El Capitan
# EOF

# ## Put lines
# gmt psxy -R -J -A -N -Wthin -O -K >> Yosemite.ps <<EOF
# -119:38 37:44
# -119:37.5 37:41
# EOF


## Plot the length scale
gmt set FONT_LABEL 13p,Helvetica-Bold,white
gmt set FONT_ANNOT_PRIMARY 10p,Helvetica-Bold,white
gmt psbasemap -J -R -Ln0.9/0.12+c-119.5/37.75+w2k+f+u -O -K >> Yosemite.ps

## Plot the directional compass
gmt set MAP_TITLE_OFFSET 0.1c
gmt set FONT_TITLE 13p,Helvetica-Bold,white
gmt psbasemap -J -R -Tdn0.035/0.1+w1c+f+l,,,N -O  >> Yosemite.ps


# Transform into pdf
gmt psconvert -Tf -A0.1c -P Yosemite.ps

# Clean up
rm gmt.conf
rm gmt.history
