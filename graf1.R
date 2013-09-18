vztahy  <- read.csv("vztahy.csv", sep="|", header=F)


write.csv(tabulka[order(-tabulka$Freq),], "tabulka.csv", row.names=F, quote=F)


tabulka  <- as.data.frame(table(vztahy$V10))

names(tabulka)  <- c("Stát", "Partnerství")

tabulka  <- tabulka[order(-as.numeric(tabulka$Partnerství)),]
row.names(tabulka)  <- NULL

text(x,y+2,labels=as.character(y))

y <- as.matrix(tabulka$Partnerství)

colors()

par(mai=c(2.5,1.1,2,0))

barplot(tabulka$Partnerství,
        names.arg=tabulka$Stát,
        main="Kde leží města, s nimiž česká města navázala partnerství",
        ylab="Počet uzavřených partnerství",
        cex.names=0.70,
        col="orange",
        border="white",
        las=2,
        ylim=c(0,230))


text(x,y+5,labels=as.character(y),cex=0.55)