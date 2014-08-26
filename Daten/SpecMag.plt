reset
set encoding utf8
unset title
unset key
png_width = 1920
png_height = 1080
set sample 10000
input = "SpecMag.dat"
set terminal pngcairo size png_width,png_height enhanced font 'Verdana,40' dashed linewidth 4

output_png = "../Bilder/SpecMag.png"
set xlabel "SpecMag [a.u.]"
set xrange [100:350]
set ylabel "energy range [eV]"
set yrange [0:*]
f(x) = a*x**b
a = 0
b = -1
fit f(x) input using 1:2 via a,b
set label sprintf("f(x) = %.0f·x^{%.2f}", a, b) at 200,200
set output output_png
plot "" using 1:2 with points pointsize 4, \
f(x) with lines
# Das Label muss entfernt werden, damit es nicht auch im nächsten Diagramm erscheint.
unset label

output_png = "../Bilder/SpecMag_widthZLP.png"
set ylabel "width of the ZLP [px]"
set yrange [0:4096]
f(x) = a*x**b
a = 3
b = 1
fit f(x) input using 1:3:3 via a,b
set label sprintf("f(x) = %.0f·x^{%.2f}", a, b) at 200,2048
set arrow from 315,0 to 315,4096 nohead linecolor rgb "red"
set label "max. SpecMag -> " at 315,3500 right
set output output_png
plot "" using 1:3 with points pointsize 4, \
f(x) with lines

# Zum Abschließen der Datei ist 'unset out' notwendig. Alternativ kann man auch mit 'set out ...' eine andere Datei wählen, oder Gnuplot beenden.
unset out