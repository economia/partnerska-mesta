#načti seznam měst
mesta  <- read.csv("mesta.csv")

library(RJSONIO)
library(XML)

#vyber česká města
ceskamesta  <- mesta[grepl("S-\\d{1,}", mesta$i), ]

#načti vztahy mezi městy
nactiVztahy <- function () {
  soubor  <- file("vztahy.csv", "w")
  for(i in 1:nrow(ceskamesta)) {
    id  <-  as.character(ceskamesta[i, ]$i)
    if ((sapply(xpathSApply(htmlParse(paste("http://www.partnerskamesta.cz/mapa/Default.aspx?action=relations&cityID=", id, sep="")),"//p"), xmlValue)) !=0) {
    vysledek  <- fromJSON(paste("http://www.partnerskamesta.cz/mapa/Default.aspx?action=relations&cityID=", id, sep=""))
    Sys.sleep(1)
    for(j in 1:length(vysledek)) {
      radek  <- paste(ceskamesta[i,]$i, ceskamesta[i,]$l, ceskamesta[i,]$g, ceskamesta[i,]$c, ceskamesta[i,]$o, vysledek[[j]][1], mesta[mesta$i==vysledek[[j]][1], 2], mesta[mesta$i==vysledek[[j]][1], 3], mesta[mesta$i==vysledek[[j]][1], 4], mesta[mesta$i==vysledek[[j]][1], 5], vysledek[[j]][2], sep="|")
      print(radek)
      writeLines(radek, con=soubor)
    }
    }
  }
  close(soubor)
}

