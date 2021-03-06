require(maps)
require(geosphere)
require(mapdata)
require(maptools)
require(RColorBrewer)

#tabulka měst podle počtu uzavřených partnerství
pocetPartnerstvi  <- as.data.frame(table(vztahy[,4]))
pocetPartnerstvi  <- pocetPartnerstvi[order(-pocetPartnerstvi$Freq),]
row.names(pocetPartnerstvi)  <- NULL
write.csv(pocetPartnerstvi, "pocetpartnerstvi.csv")

# našti shapefile s mapou světa
svetSHP  <- readShapePoly("CNTR_2010_03M_SH/Data/CNTR_RG_03M_2010.shp")

#barvy
display.brewer.all()
paleta  <- brewer.pal(8, "Set1")


#seřaď vztahy podle počtu partnerství
pp  <- as.numeric(vector())
for (i in 1:nrow(vztahy)) {
  pp  <- c(pp, pocetPartnerstvi[pocetPartnerstvi$Var1==vztahy[i, 4], 2])
}
vztahy$pp  <- pp
vztahy  <- vztahy[order(vztahy$pp),]


# generuj graf
png("mapa-svet.png", res=1920, height=11520, width=15360)

# zmenši okraje
par(mai=c(0,0,0.5,0))

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
    lines(spojnice, col=paleta[1], lwd=0.2)
   } 
  else if (vztahy[i,4]=="Praha")
  {lines(spojnice, col=paleta[2], lwd=0.2)
  }
  else if (vztahy[i,4]=="Ostrava")
  {lines(spojnice, col=paleta[3], lwd=0.2)
  }
  else if (vztahy[i,4]=="Žamberk")
  {lines(spojnice, col=paleta[4], lwd=0.2)
  }
  else if (vztahy[i,4]=="Znojmo")
  {lines(spojnice, col=paleta[5], lwd=0.2)
  }
  else if (vztahy[i,4]=="Kutná Hora")
  {lines(spojnice, col=paleta[6], lwd=0.2)
  }
  else if (vztahy[i,4]=="Hradec Králové")
  {lines(spojnice, col=paleta[7], lwd=0.2)
  }
  else if (vztahy[i,4]=="Bystré")
  {lines(spojnice, col=paleta[8], lwd=0.2)
  }
  
  else {
  lines(spojnice, lwd=0.05, col="grey65")
  }
}

#legenda a titulek
legend("bottomleft", legend=c("Brno [14]", "Praha [14]", "Ostrava [10]", "Žamberk [9]", "Znojmo [9]", "Kutná Hora [9]", "Hradec Králové [9]", "Bystré [9]", "Ostatní[883]"), pch=15, col=c(paleta[1], paleta[2], paleta[3], paleta[4], paleta[5], paleta[6], paleta[7], paleta[8], "grey65"), cex=0.5, pt.cex=1)

title(main="Česká města s nejvyšším počtem partnerství", cex=0.5)

dev.off()