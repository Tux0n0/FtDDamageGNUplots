set grid nopolar
set grid xtics nomxtics ytics nomytics noztics nomztics nortics nomrtics \
 nox2tics nomx2tics noy2tics nomy2tics nocbtics nomcbtics
set grid layerdefault   lt 0 linecolor 0 linewidth 0.500,  lt 0 linecolor 0 linewidth 0.500
unset parametric
set samples 16, 481
set isosamples 16, 97
set style fill transparent solid 0.5
set xyplane relative 0
set pm3d; set palette
set xlabel "X axis - Module Count" 
set xlabel  offset character -3, -2, 0 font "" textcolor lt -1 norotate
set xrange [ 0 : 15 ] noreverse nowriteback
set x2range [ * : * ] noreverse writeback
set ylabel "Y axis - Gauge Size in mm" 
set ylabel  offset character 3, -2, 0 font "" textcolor lt -1 rotate
set yrange [ 20 : 500 ] noreverse nowriteback
set y2range [ * : * ] noreverse writeback
set zlabel "Z axis" 
set zlabel  offset character -5, 0, 0 font "" textcolor lt -1 norotate
set zrange [ * : * ] noreverse writeback
set cbrange [ * : * ] noreverse writeback
set rrange [ * : * ] noreverse writeback
set colorbox vertical origin screen 0.9, 0.2 size screen 0.05, 0.6 front  noinvert bdefault
set pm3d clip
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
g1(y) = l-(m1*a(y))-(m3*b(y))-(m5*y)

#f1 is the graph for single damage
f1(x,y) = y*x <= g1(y) ? 3000*((y/500)**1.8*x*2640/3000*1)**0.9 : 0
#f2 is the graph for damage per second
f2(x,y) = y*x <= g1(y) ? (3000*((y/500)**1.8*x*2640/3000*1)**0.9)/((y**3/500**3)**0.45 * (2 + x*y / y + 0.25 * 2*x*y / y) * 17.5) : 0

splot f2(x,y)
