require(maps)
require(geosphere)
require(mapdata)
require(maptools)
require(RColorBrewer)

#tabulka měst podle počtu uzavřených partnerství
pocetPartnerstvi  <- as.data.frame(table(vztahy[,4]))
pocetPartnerstvi[order(pocetPartnerstvi$Freq),]


# našti shapefile s mapou světa
svetSHP  <- readShapePoly("CNTR_2010_03M_SH/Data/CNTR_RG_03M_2010.shp")

#barvy
display.brewer.all()
paleta  <- brewer.pal(7, "Set1")

#výřez z mapy - svět
xlim <- c(-170, 175)
ylim <- c(-55, 80)


# zobraz mapu z balíčku maps (zastaralé hranice států v Evropě)
map("world", col="#f2f2f2", fill=T, bg="white", lwd=0.1, xlim=xlim, ylim=ylim)

# překresli podrobnější hranice (+ zjednodušení)
plot(thinnedSpatialPoly(svetSHP, tolerance=0.1, minarea=0.001), add=TRUE, xlim=xlim, ylim=ylim, col="#f2f2f2", border=TRUE, lwd=0.35)


# nakresli spojnice mezi partnerskými městy
for (i in 1:nrow(vztahy)) {
  spojnice <- gcIntermediate(c(vztahy[i,3], vztahy[i,2]), c(vztahy[i,8], vztahy[i,7]), n=50, addStartEnd=TRUE)
  if (vztahy[i,4]=="Brno") {
    lines(spojnice, col=paleta[1], lwd=0.75)
  } 
  else if (vztahy[i,4]=="Ostrava")
  {lines(spojnice, col=paleta[2], lwd=0.75)
  }
  else if (vztahy[i,4]=="Žamberk")
  {lines(spojnice, col=paleta[3], lwd=0.75)
  }
  else if (vztahy[i,4]=="Znojmo")
  {lines(spojnice, col=paleta[4], lwd=0.75)
  }
  else if (vztahy[i,4]=="Kutná Hora")
  {lines(spojnice, col=paleta[5], lwd=0.75)
  }
  else if (vztahy[i,4]=="Hradec Králové")
  {lines(spojnice, col=paleta[6], lwd=0.75)
  }
  else if (vztahy[i,4]=="Bystré")
  {lines(spojnice, col=paleta[7], lwd=0.75)
  }
  else {
  lines(spojnice, lwd=0.2)
  }
}

#legenda a titulek
legend("bottomleft", legend=c("Brno [14]", "Ostrava [10]", "Žamberk [9]", "Znojmo [9]", "Kutná Hora [9]", "Hradec Králové [9]", "Bystré [9]"), pch=15, col=c(paleta[1], paleta[2], paleta[3], paleta[4], paleta[5], paleta[6], paleta[7]), cex=0.8, pt.cex=1.3)

title(main="Česká města s nejvyšším počtem partnerství")
