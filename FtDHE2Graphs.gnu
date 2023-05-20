set grid nopolar
set grid xtics nomxtics ytics nomytics noztics nomztics nortics nomrtics \
 nox2tics nomx2tics noy2tics nomy2tics nocbtics nomcbtics
set grid layerdefault   lt 0 linecolor 0 linewidth 0.500,  lt 0 linecolor 0 linewidth 0.500
set style line 100  linecolor rgb "#f0e442"  linewidth 0.500 dashtype solid pointtype 5 pointsize default
set parametric
set samples 16, 481
set isosamples 16, 97
set xyplane relative 0
set title "3D surface from a function" 
set pm3d implicit at s
#set pm3d depthorder 
set pm3d interpolate 1,1 flush begin noftriangles border linecolor rgb "black"  linewidth 1.000 dashtype solid corners2color mean
set xlabel "X axis - Module Count" 
set xlabel  offset character -3, -2, 0 font "" textcolor lt -1 norotate
set xrange [ 0 : 15 ] noreverse nowriteback
set ylabel "Y axis - Gauge Size in mm" 
set ylabel  offset character 3, -2, 0 font "" textcolor lt -1 rotate
set yrange [ 0 : 500 ] noreverse nowriteback
set zlabel "Z axis" 
set zlabel  offset character -5, 0, 0 font "" textcolor lt -1 norotate
set zrange [ 0 : 100 ] noreverse writeback
set rrange [ * : * ] noreverse writeback
set urange [ 0 : 15]
set vrange [ 0 : 500]
set colorbox vertical origin screen 0.9, 0.2 size screen 0.05, 0.6 front  noinvert bdefault
NO_ANIMATION = 1

# l is projectile length in mm
l = 1750
# m1 is unrelated modules with 100 length (e.g. tracers)
m1 = 2
# m3 is unrelated modules with 300 length (e.g. fins)
m3 = 1
# m5 is unrelated modules which don't have a length limit
m5 = 0

# capping values for shells with limited length
a(v) = v <= 100 ? v : 100
b(v) = v <= 300 ? v : 300

# g1 is responsible for calculating the available length for modules, aka the limit line
g1(v) = l-(m1*a(v))-(m3*b(v))-(m5*v)

#f1 is the graph for single damage
f1(u,v) = 3000*((v/500)**1.8*u*2640/3000*1)**0.9
#f2 is the graph for damage per second
f2(u,v) = (3000*((v/500)**1.8*u*2640/3000*1)**0.9)/((v**3/500**3)**0.45 * (2 + u*v / v + 0.25 * 2*u*v / v) * 17.5)

splot u,v,f2(u,v) , \
	u,g1(u)/u,v+f2(u,g1(u)/u) with pm3d fc "grey"
	#f2(u,g1(u)/u)
