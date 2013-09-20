require(maps)
require(geosphere)
require(mapdata)
require(maptools)
require(RColorBrewer)

# našti shapefile s mapou světa
svetSHP  <- readShapePoly("CNTR_2010_03M_SH/Data/CNTR_RG_03M_2010.shp")

#barvy
display.brewer.all()
paleta  <- brewer.pal(8, "Set1")
display.brewer.pal(8, "Set1")

# generuj graf
png("mapa-evropa.png", res=600, height=3600, width=4800)

# zmenši okraje
par(mai=c(0,0,0.5,0))

#výřez z mapy - Evropa
xlim <- c(-6.5, 24)
ylim <- c(40.08, 54.9)


# zobraz mapu z balíčku maps (zastaralé hranice států v Evropě)
map("world", col="#f2f2f2", fill=T, bg="white", lwd=0.1, xlim=xlim, ylim=ylim)

# překresli podrobnější hranice (+ zjednodušení)
plot(thinnedSpatialPoly(svetSHP, tolerance=0.1, minarea=0.001), add=TRUE, xlim=xlim, ylim=ylim, col="#f2f2f2", border=TRUE, lwd=0.5)

# nakresli spojnice mezi partnerskými městy
for (i in 1:nrow(vztahy)) {
  spojnice <- gcIntermediate(c(vztahy[i,3], vztahy[i,2]), c(vztahy[i,8], vztahy[i,7]), n=50, addStartEnd=TRUE)
  if (vztahy[i,10]=="Německo") {
    lines(spojnice, col=paleta[1], lwd=0.25)
  } 
  else if (vztahy[i,10]=="Polsko")
  {lines(spojnice, col=paleta[2], lwd=0.25)
  }
  else if (vztahy[i,10]=="Slovensko")
  {lines(spojnice, col=paleta[4], lwd=0.25)
  }
  else if (vztahy[i,10]=="Itálie")
  {lines(spojnice, col=paleta[5], lwd=0.25)
  }
  else if (vztahy[i,10]=="Rakousko")
  {lines(spojnice, col=paleta[3], lwd=0.25)
  }
  else if (vztahy[i,10]=="Francie")
  {lines(spojnice, col=paleta[7], lwd=0.25)
  }
   else if (vztahy[i,10]=="Švýcarsko")
  {lines(spojnice, col=paleta[6], lwd=0.25)
  }
   else if (vztahy[i,10]=="Nizozemsko")
   {lines(spojnice, col=paleta[8], lwd=0.25)
   }
#  else {
 # lines(spojnice, lwd=0.1)
#  }
}

#legenda a titulek
legend("bottomleft", legend=c("Německo [227]", "Polsko [190]", "Slovensko [188]", "Itálie [59]", "Rakousko [52]", "Francie [48]", "Švýcarsko [30]", "Nizozemsko [28]"), pch=15, col=c(paleta[1], paleta[2], paleta[4], paleta[5], paleta[3], paleta[7], paleta[6], paleta[8]), cex=0.5, pt.cex=1)

title(main="Státy s nejvyšším počtem českých partnerských měst")

dev.off()
