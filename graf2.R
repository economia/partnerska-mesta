tabulka.roky  <- as.data.frame(table(vztahy$V11))

# očisti tabulku od chyb
tabulka.roky  <- tabulka.roky[4:53,]

# kolik zbývá záznamů
sum(tabulka.roky$Freq)

# zformátuj letopočty jako data
tabulka.roky$d1  <- as.Date(tabulka.roky$Var1, "%Y")
tabulka.roky$d2  <- strptime(tabulka.roky$Var1, "%Y")

# nakresli graf
plot(tabulka.roky$Freq~tabulka.roky$d1,
     type="l",
     xlab="Rok",
     ylab="Uzavřená partnerství",
     main="Kolik partnerství uzavřela česká města v jednotlivých letech",
     col="orange",
     lwd=3)

# nejstarší partnerství

pred.1989  <- vztahy[vztahy$V11<1990&vztahy$V11!=0,]
pred.1989[pred.1989$V10=="Francie",]
