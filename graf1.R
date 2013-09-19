vztahy  <- read.csv("vztahy.csv", sep=";", header=F)


tabulka  <- as.data.frame(table(vztahy$V10))

names(tabulka)  <- c("Stát", "Partnerství")

tabulka  <- tabulka[order(-as.numeric(tabulka$Partnerství)),]
row.names(tabulka)  <- NULL

write.csv(tabulka, "tabulka.csv", row.names=F, quote=F)



y <- as.matrix(tabulka$Partnerství)


x  <- barplot(tabulka$Partnerství,
        names.arg=tabulka$Stát,
        main="Kde leží města, s nimiž česká města navázala partnerství",
        ylab="Počet uzavřených partnerství",
        cex.names=0.80,
        col="orange",
        border="white",
        las=2,
        ylim=c(0,240))

text(x,y+8,labels=as.character(y),cex=0.55)


# vytiskni graf
png("graf1.png",res=600,height=420,width=670)
par(mar=c(4,4,3,1),
    omi=c(0.1,0.1,0.1,0.1),
    mgp=c(3,0.5,0),
    las=1,
    mex=0.5,
    cex.main=0.6,
    cex.lab=0.5,
    cex.axis=0.4)
barplot(tabulka$Partnerství,
        names.arg=tabulka$Stát,
        main="Kde leží města, s nimiž česká města navázala partnerství",
        ylab="Počet uzavřených partnerství",
        cex.names=0.35,
        col="orange",
        border="white",
        las=2,
        ylim=c(0,250))
dev.off()