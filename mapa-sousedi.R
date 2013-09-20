require(maps)
require(geosphere)
require(mapdata)
require(maptools)
require(RColorBrewer)

# našti shapefile s mapou světa
svetSHP  <- readShapePoly("CNTR_2010_03M_SH/Data/CNTR_RG_03M_2010.shp")

#barvy
display.brewer.all()
paleta  <- brewer.pal(4, "Set1")

#výřez z mapy - Evropa
#xlim <- c(-9.9, 40.4)
#ylim <- c(30.08, 65.9)

#výřez z mapy - sousední státy
xlim <- c(4.39, 25.2)
ylim <- c(45.3, 55.1)

# generuj graf
png("mapa-sousedi.png", res=300, height=1800, width=2400)

# zmenši okraje
par(mai=c(0,0,0.5,0))

# zobraz mapu z balíčku maps (zastaralé hranice států v Evropě)
map("world", col="#f2f2f2", fill=T, bg="white", lwd=0.1, xlim=xlim, ylim=ylim)

# překresli podrobnější hranice (+ zjednodušení)
plot(thinnedSpatialPoly(svetSHP, tolerance=0.1, minarea=0.001), add=TRUE, xlim=xlim, ylim=ylim, col="#f2f2f2", border=TRUE, lwd=0.5)

# nakresli spojnice mezi partnerskými městy
for (i in 1:nrow(vztahy)) {
spojnice <- gcIntermediate(c(vztahy[i,3], vztahy[i,2]), c(vztahy[i,8], vztahy[i,7]), n=50, addStartEnd=TRUE)
if (vztahy[i,10]=="Německo") {
lines(spojnice, col=paleta[1], lwd=0.3)
} 
else if (vztahy[i,10]=="Polsko")
{lines(spojnice, col=paleta[2], lwd=0.3)
}
else if (vztahy[i,10]=="Slovensko")
{lines(spojnice, col=paleta[4], lwd=0.3)
}
else if (vztahy[i,10]=="Rakousko")
{lines(spojnice, col=paleta[3], lwd=0.3)
}
#else {
#lines(spojnice, lwd=0.1)
#}
}

#legenda a titulek
legend("bottom", legend=c("Německo [227]", "Polsko [190]", "Slovensko [188]", "Rakousko [52]"), horiz=TRUE, pch=15, col=c(paleta[1], paleta[2], paleta[4], paleta[3]), cex=0.6, pt.cex=1.2)

title(main="Partnerství českých obcí s obcemi v sousedních zemích")

dev.off()