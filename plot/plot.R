rm( list = ls() )
setwd( "/home/songli/Song/MyProjects/class3/")

### simulated data set.###################################
# single sample analysis
classRecall=read.table( "./sim/class_recall.out")
classPrecision=read.table( "./sim/class_precision.out")
classesRecall=read.table( "./sim/classes_recall.out")
classesPrecision=read.table( "./sim/classes_precision.out")
classStarRecall=read.table( "./sim/class_star_recall.out" ) 
classStarPrecision=read.table( "./sim/class_star_precision.out" )
classesStarRecall=read.table( "./sim/classes_star_recall.out" )
classesStarPrecision=read.table( "./sim/classes_star_precision.out") ;
stringtieRecall=read.table( "./sim/stringtie_recall.out")
stringtiePrecision=read.table( "./sim/stringtie_precision.out")
stringtieStarRecall=read.table( "./sim/stringtie_star_recall.out" )
stringtieStarPrecision=read.table( "./sim/stringtie_star_precision.out" )
scallopRecall=read.table( "./sim/scallop_recall.out" )
scallopPrecision=read.table( "./sim/scallop_precision.out" ) 
scallopStarRecall=read.table( "./sim/scallop_star_recall.out" )
scallopStarPrecision=read.table( "./sim/scallop_star_precision.out" ) 
cufflinksRecall=read.table( "./sim/cufflinks_recall.out" )
cufflinksPrecision=read.table( "./sim/cufflinks_precision.out" )
cufflinksStarRecall=read.table( "./sim/cufflinks_star_recall.out" )
cufflinksStarPrecision=read.table( "./sim/cufflinks_star_precision.out" )

plot( x=classRecall[,2], y=classPrecision[,2], xlim=c(0.4, 0.5), ylim=c(0.55, 0.8), pch=0, col="red", xlab="Recall", ylab="Precision")
points( x=classStarRecall[,2], y=classStarPrecision[,2], pch=0,col="blue")
points( x=stringtieRecall[,2], y=stringtiePrecision[,2], pch=1, col="red" )
points( x=stringtieStarRecall[,2], y=stringtieStarPrecision[,2], pch=1, col="blue" )
points( x=scallopRecall[,2], y=scallopPrecision[,2], pch=2, col="red" )
points( x=scallopStarRecall[,2], y=scallopStarPrecision[,2], pch=2, col="blue")
points( x=cufflinksRecall[,2], y=cufflinksPrecision[,2], pch=3, col="red" )
points( x=cufflinksStarRecall[,2], y=cufflinksStarPrecision[,2], pch=3, col="blue")

width=0.0175
x=0.485
legend( x=c(x, x+width), y=c(0.8, 0.732), c( "PsiCLASS", "StringTie", "Scallop", "Cufflinks"), pch=c(0,1,2,3), col=c( rep("black",4)) )
legend( x=c(x, x+width), y=c(0.73, 0.685), c( "HISAT2  ", "STAR" ), pch=c(18,18), col=c("red", "blue" ) )

# the effect of the cov threshold
covcutoff=read.table( "./sim/cov_summary.out")
p<-plot( x=covcutoff[ which( covcutoff$V1=='class'), 3], 
         y=covcutoff[ which( covcutoff$V1=='class'), 4], xlab="Recall", ylab="Precision", type="o", col="red", pch=0, 
         xlim=c(0,1), ylim=c(0,1)) ;
lines( x=covcutoff[ which( covcutoff$V1=='stringtie'), 3], 
       y=covcutoff[ which( covcutoff$V1=='stringtie'), 4], xlab="Recall", ylab="Precision", type="o", col="green", pch=1 ) ;
lines( x=covcutoff[ which( covcutoff$V1=='scallop'), 3], 
       y=covcutoff[ which( covcutoff$V1=='scallop'), 4], xlab="Recall", ylab="Precision", type="o", col="purple", pch=2 ) ;
#x=0.54
#width=0.2
legend( x=c(0.75,1), y=c(0.78,1.0), c( "CLASS3", "StringTie", "Scallop"), col=c( "red", "green", "purple" ), pch=c(0,1,2) ) 

# the effect of the ffraction(fratio) threshold
fratio=read.table( "./sim/fratio_summary.out" )
p<-plot( x=fratio[ which( fratio$V1=='class'), 3], 
         y=fratio[ which( fratio$V1=='class'), 4], xlab="Recall", ylab="Precision", type="o", col="red", pch=0, 
         xlim=c(0,1), ylim=c(0,1)) ;
lines( x=fratio[ which( fratio$V1=='stringtie'), 3], 
       y=fratio[ which( fratio$V1=='stringtie'), 4], xlab="Recall", ylab="Precision", type="o", col="green", pch=1 ) ;
#lines( x=fratio[ which( fratio$V1=='cufflinks'), 3], 
#       y=fratio[ which( fratio$V1=='cufflinks'), 4], xlab="cufflinks", ylab="cufflinks", type="o", col="orange", pch=3 ) ;
legend( x=c(0.75,1), y=c(0.83,1.0), c( "CLASS3", "StringTie" ), col=c( "red", "green", "orange" ), pch=c(0,1,3) ) 


# multiple samples
taco=read.table( "./sim/taco_summary.out")
taco=taco[ seq( 1, length( taco[,1] ), 2 ), ]
taco[1,]=taco[5,]
taco=taco[-5,]

stmerge=read.table( "./sim/stmerge_summary.out")
stmerge=stmerge[ seq( 1, length( stmerge[,1] ), 2 ), ]
stmerge[1,]=stmerge[5,]
stmerge=stmerge[-5,]

isp=c(0.499610, 0.424503)
classVote=c(0.512860, 0.720701)

f<-plot( x=c(classVote[1], isp[1], taco[,2], stmerge[,2]), y=c(classVote[2], isp[2], taco[,3], stmerge[,3]), 
      xlab="Recall", ylab="Precision",
      pch=c(0,4,0,1,2,3,0,1,2,3), 
      col=c("red", "red", rep( "blue", length( stmerge[,2] ) ), rep( "goldenrod3", length( taco[,2] )) ), xlim=c(0.18, 0.6), ylim=c(0.38, 0.8) ) 

x=0.535
width=0.075
legend( x=c(x, x+width), y=c(0.8, 0.67), c( "CLASS3", "StringTie", "Scallop", "Cufflinks", "ISP" ), pch=c(0, 1, 2, 3, 4), cex=0.9 )
legend( x=c(x, x+width), y=c(0.66, 0.57), c( "Integrated", "ST-merge", "TACO" ), pch=rep(18, 4), col=c("red", "blue", "goldenrod3"), cex=0.9 )

# Multiple sample with information of each sample performance with box plot 
sampleCnt = length(classesRecall[,1]) 
par( mfrow=c(1,2))
recallTable=data.frame( c( classesRecall[,2], stringtieRecall[,2], scallopRecall[,2] ) )
colnames( recallTable )<-c("Recall")
recallTable$Software<-c( rep( "PsiCLASS", sampleCnt ), rep( "StringTie", sampleCnt ), rep( "Scallop", sampleCnt ) )
recallTable$Software<-factor( recallTable$Software, levels=c( "PsiCLASS", "StringTie", "Scallop" ) )
boxplot( Recall~Software, data=recallTable, main="Recall", ylab="Recall", ylim=c(0.35,0.55) )
points( x=c(1, 2, 3), y = c(classVote[1], stmerge[2,2], taco[3,2] ) , col=c("red", "blue", "goldenrod3"), pch=c(15, 16, 17), cex=1.5 )

precisionTable=data.frame( c( classesPrecision[,2], stringtiePrecision[,2], scallopPrecision[,2] ) )
colnames( precisionTable )<-c("Precision")
precisionTable$Software<-recallTable$Software
boxplot( Precision~Software, data=precisionTable, main="Precision", ylab="Precision", ylim=c(0.5, 0.8) )
points( x=c(1, 2, 3), y = c(classVote[2], stmerge[2,3], taco[3,3] ) , col=c("red", "blue", "goldenrod3"), pch=c(15, 16, 17), cex=1.5 )
legend( x=2.2, y=0.8, c( "PsiCLASS", "ST-merge", "TACO" ), col=c("red", "blue", "goldenrod3"), pch=18, cex=0.8 )
par( mfrow=c(1,1) )

# class3 improvement over single sample
plot( x=classesRecall[,2]-classRecall[,2], y=classesPrecision[,2]-classPrecision[,2], xlim=c(-0.06, 0.06), ylim=c(-0.06,0.06),
        xlab=expression( paste( Delta,"Recall") ), ylab=expression(paste( Delta, "Precision") ), col="red", pch=c(0) )
lines( x=c(-1,1), y=c(0,0), col="blue", lwd=0.5)
lines( x=c(0,0), y=c(-1,1), col="blue", lwd=0.5)

# the effect of expression level
lowmedhigh=read.table( "./sim/lowmedhigh_summary.out" )
lowmedhigh=lowmedhigh[ which( lowmedhigh$V1=='classes' | lowmedhigh$V1=='stmerge' | lowmedhigh$V1 == 'taco') ,]
low=lowmedhigh[ which(lowmedhigh$V2=='low' ), 3 ]
#recall<-table( low, c("CLASS3", "StringTie", "Scallop", "Cufflinks"))
label<-c("PsiCLASS", "StringTie", "Scallop+TACO")
par( mfrow=c(1,3) )
barplot( low, width=0.1, space=0, col=c("red", "blue", "goldenrod3"), ylim=c(0,1), ylab="Recall", main="Low") 
med=lowmedhigh[ which(lowmedhigh$V2=='med'), 3 ]
barplot( med, width=0.1, space=0, col=c("red", "blue", "goldenrod3"), ylim=c(0,1), ylab="Recall", main="Medimum") 
high=lowmedhigh[ which(lowmedhigh$V2=='high'), 3 ]
barplot( high, width=0.1, space=0, col=c("red", "blue", "goldenrod3"), ylim=c(0,1), ylab="Recall", legend=label, main="High") 
par( mfrow=c(1,1) )

# the effect of change of sample support threshold in vote
voten=read.table( "./sim/voten_summary.out" ) 
f<-plot( x=c(classVote[1], isp[1], stmerge[,2], taco[,2]), y=c(classVote[2], isp[2], stmerge[,3], taco[,3]), 
         xlab="Recall", ylab="Precision",
         pch=c(0,4,0,1,2,3,0,1,2,3), 
         col=c("red", "red", rep( "blue", length( stmerge[,2] ) ), rep( "goldenrod3", length( taco[,2] )) ), xlim=c(0, 1), ylim=c(0, 1) ) 
lines( x=voten[,2], y=voten[,3], col="red", lty=2) ;

x=0.8
width=0.22
legend( x=c(x, x+width), y=c(1, 0.68), c( "PsiCLASS", "StringTie", "Scallop", "Cufflinks", "ISP" ), pch=c(0, 1, 2, 3, 4) )
legend( x=c(x, x+width), y=c(0.66,0.43), c( "Integrated", "ST-merge", "TACO" ), pch=rep(18, 4), col=c("red", "blue", "goldenrod3") )

### Hippocampi #################################################################################
rm( list = ls() )
# single sample
class=read.table( "./Hippocampi/class_summary.out")
stringtie=read.table( "./Hippocampi/stringtie_summary.out" ) 
scallop=read.table( "./Hippocampi/scallop_summary.out" ) 
classes=read.table( "Hippocampi/classes_summary.out")

sampleCnt = length(class[,1]) 
par( mfrow=c(1,2))
recallTable=data.frame( c( class[,2], stringtie[,2], scallop[,2] ) )
colnames( recallTable )<-c("Recall")
recallTable$Software<-c( rep( "CLASS3", sampleCnt ), rep( "StringTie", sampleCnt ), rep( "Scallop", sampleCnt ) )
recallTable$Software<-factor( recallTable$Software, levels=c( "CLASS3", "StringTie", "Scallop" ) )
boxplot( Recall~Software, data=recallTable, main="Recall", ylab="Recall", ylim=c(0,0.2) )
?boxplot

precisionTable=data.frame( c( class[,3], stringtie[,3], scallop[,3] ) )
colnames( precisionTable )<-c("Precision")
precisionTable$Software<-recallTable$Software
boxplot( Precision~Software, data=precisionTable, main="Precision", ylim=c(0.35, 0.8) )
par( mfrow=c(1,1) )

# multiple samples
stmerge<-read.table( "./Hippocampi/stmerge_summary.out" ) 
stmerge<-stmerge[which(stmerge$V1 != "class"),]
taco<-read.table( "./Hippocampi/taco_summary.out" )
taco<-taco[ which( taco$V1!="class"),]
classVote<-c(0.180786,0.687435)
voten=read.table( "./Hippocampi/voten_summary.out" ) 

# box plot
sampleCnt = length(class[,1]) 
par( mfrow=c(1,2))
recallTable=data.frame( c( classes[,2], stringtie[,2], scallop[,2] ) )
colnames( recallTable )<-c("Recall")
recallTable$Software<-c( rep( "PsiCLASS", sampleCnt ), rep( "StringTie", sampleCnt ), rep( "Scallop", sampleCnt ) )
recallTable$Software<-factor( recallTable$Software, levels=c( "PsiCLASS", "StringTie", "Scallop" ) )
boxplot( Recall~Software, data=recallTable, main="Recall", ylab="Recall", ylim=c(0,0.2) )
points( x=c(1, 2, 3), y = c(classVote[1], stmerge[2,2], taco[3,2] ) , col=c("red", "blue", "goldenrod3"), pch=c(15, 16, 17), cex=1.5 )
#lines( x=c(1,1), y=c(voten[1,2], voten[sampleCnt,2]), col="red", lty=3, lwd=0.75) 
#points( x=c(1), y=c(voten[15,2]), col="red", pch=c(7))

precisionTable=data.frame( c( classes[,3], stringtie[,3], scallop[,3] ) )
colnames( precisionTable )<-c("Precision")
precisionTable$Software<-recallTable$Software
boxplot( Precision~Software, data=precisionTable, ylab="Precision", main="Precision", ylim=c(0, 1) )
points( x=c(1, 2, 3), y = c(classVote[2], stmerge[2,3], taco[3,3] ) , col=c("red", "blue", "goldenrod3"), pch=c(15, 16, 17), cex=1.5 )
legend( x=2.2, y=1, c( "PsiCLASS", "ST-merge", "TACO" ), col=c("red", "blue", "goldenrod3"), pch=18, cex=0.8 )
#lines( x=c(1,1), y=c(voten[1,3], voten[sampleCnt,3]), col="red", lty=3, lwd=0.75) 
#points( x=c(1), y=c(voten[15,3]), col="red", pch=c(7))
par( mfrow=c(1,1) )


# variation of combinations
f<-plot( x=c(classVote[1], stmerge[,2], taco[,2] ), y=c(classVote[2], stmerge[,3], taco[,3] ), 
         xlab="Recall", ylab="Precision",
         pch=c(0,0,1,2,0,1,2), 
         col=c("red", rep( "blue", length( stmerge[,2] ) ), rep( "goldenrod3", length( taco[,2] )) ),
         xlim=c(0,0.5), ylim=c(0, 1)) 
lines( x=voten[,2], y=voten[,3], col="red", lty=2) ;
x=0.4
width=0.11
legend( x=c(x, x+width), y=c(1.0, 0.77), c( "PsiCLASS", "StringTie", "Scallop"), pch=c(0, 1, 2) )
legend( x=c(x, x+width), y=c(0.75, 0.51), c( "Integrated", "ST-merge", "TACO" ), pch=rep(18, 4), col=c("red", "blue", "goldenrod3") )

# improvements from class to classes on samples
plot( x=classes[,2]-class[,2], y=classes[,3]-class[,3], xlim=c(-0.05, 0.05), ylim=c(-0.05,0.05),
      xlab=expression( paste( Delta,"Recall") ), ylab=expression(paste( Delta, "Precision") ), col="red" )
lines( x=c(-1,1), y=c(0,0), col="blue", lwd=0.5)
lines( x=c(0,0), y=c(-1,1), col="blue", lwd=0.5)

### Geuvadis #################################################################################
rm(list=ls())
# the effect of sample size
samplesize<-read.table( "Geuvadis/samplesize_summary.out")
samplesize<-samplesize[which( samplesize$V2>1),]
samplesize
# plot in two figures
par( mfrow=c(1,2))
# recall
plot( x=samplesize[ which( samplesize$V1=="classes"), 2 ], y=samplesize[ which( samplesize$V1=="classes"), 3 ], type="o", 
      xlim=c(1,700),xlab="Sample Size", ylim=c(0,0.1), ylab = "Recall", log="x",
      pch=0, col="red")
lines(x=samplesize[ which( samplesize$V1=="stringtie_stmerge"), 2 ], y=samplesize[ which( samplesize$V1=="stringtie_stmerge"), 3 ], pch=1, type="o", col="blue" )
lines(x=samplesize[ which( samplesize$V1=="scallop_taco"), 2 ], y=samplesize[ which( samplesize$V1=="scallop_taco"), 3 ], pch=2, type="o", col="goldenrod3" )
x=1
width=10
legend( x=x, y=0.02, c( "CLASS3", "StringTie", "Scallop+TACO"), pch=c(0, 1, 2 ), col=c("red", "blue", "goldenrod3") )

# precision
plot( x=samplesize[ which( samplesize$V1=="classes"), 2 ], y=samplesize[ which( samplesize$V1=="classes"), 4 ], type="o", 
      xlim=c(1,700),xlab="Sample Size", ylim=c(0,1), ylab = "Precision", log="x",
      pch=0, col="red")
lines(x=samplesize[ which( samplesize$V1=="stringtie_stmerge"), 2 ], y=samplesize[ which( samplesize$V1=="stringtie_stmerge"), 4 ], pch=1, type="o", col="blue" )
lines(x=samplesize[ which( samplesize$V1=="scallop_taco"), 2 ], y=samplesize[ which( samplesize$V1=="scallop_taco"), 4 ], pch=2, type="o", col="goldenrod3" )
par( mfrow=c(1,1 ))

#plot in one figure
# precision
par(mar = c(4.5,4.5,2,4.5))
plot( x=samplesize[ which( samplesize$V1=="classes"), 2 ], y=samplesize[ which( samplesize$V1=="classes"), 4 ], type="o", 
      xlim=c(2,700),xlab="Sample Size", ylim=c(0,1), ylab = "Precision", log="x",
      pch=0, col="red", cex=0.75)
lines(x=samplesize[ which( samplesize$V1=="stringtie_stmerge"), 2 ], y=samplesize[ which( samplesize$V1=="stringtie_stmerge"), 4 ], 
      pch=1, type="o", col="blue", cex=0.75 )
lines(x=samplesize[ which( samplesize$V1=="scallop_taco"), 2 ], y=samplesize[ which( samplesize$V1=="scallop_taco"), 4 ], 
      pch=2, type="o", col="goldenrod3", cex=0.75 )

# recall
par( new=TRUE )
plot( x=samplesize[ which( samplesize$V1=="classes"), 2 ], y=samplesize[ which( samplesize$V1=="classes"), 3 ], type="o", 
      xlim=c(2,700),ylim=c(0,0.2), log="x", xlab="", ylab="", axes=F,
      pch=0, col="red", lty=2, xaxt="n", yaxt="n", cex=0.75)
mtext( "Recall", side=4, line=3 )
axis(side=4)

lines(x=samplesize[ which( samplesize$V1=="stringtie_stmerge"), 2 ], y=samplesize[ which( samplesize$V1=="stringtie_stmerge"), 3 ], 
      pch=1, type="o", col="blue", lty=2, cex=0.75 )
lines(x=samplesize[ which( samplesize$V1=="scallop_taco"), 2 ], y=samplesize[ which( samplesize$V1=="scallop_taco"), 3 ], 
      pch=2, type="o", col="goldenrod3", lty=2, cex=0.75 )
x=1
width=10
legend( x=10, y=0.2, c( "PsiCLASS", "StringTie", "Scallop+TACO"), pch=c(0, 1, 2 ), col=c( "red", "blue", "goldenrod3" ))
legend( x=100, y=0.2, c( "Precision", "Recall"), lty=c(1,2))
par(new=FALSE)
dev.off()
dev.new()

### 25 Geuvadis samples #################################################################################
rm( list = ls() )
classes<-read.table( "Geuvadis25/classes_summary.out")
stringtie<-read.table( "Geuvadis25/stringtie_summary.out" ) 
scallop<-read.table( "Geuvadis25/scallop_summary.out") 
classVote<-c(0.077141, 0.594982)
stmerge<-read.table( "Geuvadis25/stmerge_summary.out" ) 
taco<-read.table( "Geuvadis25/taco_summary.out" ) 

voten<-read.table( "./Geuvadis25/voten_summary.out" )

sampleCnt = length(classes[,1]) 
par( mfrow=c(1,2))
recallTable=data.frame( c( classes[,2], stringtie[,2], scallop[,2] ) )
colnames( recallTable )<-c("Recall")
recallTable$Software<-c( rep( "PsiCLASS", sampleCnt ), rep( "StringTie", sampleCnt ), rep( "Scallop", sampleCnt ) )
recallTable$Software<-factor( recallTable$Software, levels=c( "PsiCLASS", "StringTie", "Scallop" ) )
boxplot( Recall~Software, data=recallTable, main="Recall", ylab="Recall", ylim=c(0,0.1) )
points( x=c(1, 2, 3), y = c(classVote[1], stmerge[2,2], taco[3,2] ) , col=c("red", "blue", "goldenrod3"), pch=c(15, 16, 17), cex=1.5 )
lines( x=c(1,1), y=c(voten[1,2], voten[sampleCnt,2]), col="red", lty=3, lwd=0.75) 
points( x=1, y=voten[3,2], col="red", pch=12 ) 


precisionTable=data.frame( c( classes[,3], stringtie[,3], scallop[,3] ) )
colnames( precisionTable )<-c("Precision")
precisionTable$Software<-recallTable$Software
boxplot( Precision~Software, data=precisionTable, ylab="Precision", main="Precision", ylim=c(0, 1) )
points( x=c(1, 2, 3), y = c(classVote[2], stmerge[2,3], taco[3,3] ) , col=c("red", "blue", "goldenrod3"), pch=c(15, 16, 17), cex=1.5 )
legend( x=2.2, y=1, c( "PsiCLASS", "ST-merge", "TACO" ), col=c("red", "blue", "goldenrod3"), pch=18, cex=0.8 )
lines( x=c(1,1), y=c(voten[1,3], voten[sampleCnt,3]), col="red", lty=3, lwd=0.75) 
points( x=1, y=voten[3,3], col="red", pch=12 ) 
par( mfrow=c(1,1) )

# variations of combinations 
f<-plot( x=c(classVote[1], stmerge[,2], taco[,2] ), y=c(classVote[2], stmerge[,3], taco[,3] ), 
         xlab="Recall", ylab="Precision",
         pch=c(0,0,1,2,0,1,2), 
         col=c("red", rep( "blue", length( stmerge[,2] ) ), rep( "goldenrod3", length( taco[,2] )) ),
         xlim=c(0,0.15), ylim=c(0, 1)) 
lines( x=voten[,2], y=voten[,3], col="red", lty=2) ;
x=0.115
width=0.035
legend( x=c(x, x+width), y=c(1.0, 0.77), c( "PsiCLASS", "StringTie", "Scallop"), pch=c(0, 1, 2) )
legend( x=c(x, x+width), y=c(0.75, 0.51), c( "Integrated", "ST-merge", "TACO" ), pch=rep(18, 4), col=c("red", "blue", "goldenrod3") )

### Stanley Liver ############################################################################
rm( list = ls() )
# single sample with multisample sample
classes<-read.table( "Liver/classes_summary.out")
stringtie<-read.table( "Liver/stringtie_summary.out" ) 
scallop<-read.table( "Liver/scallop_summary.out") 
classVote<-c(0.064861, 0.575031)
stmerge<-c(0.080509, 0.161266)
taco<-c(0.101322, 0.133526)
voten=read.table( "./Liver/voten_summary.out" ) 

sampleCnt = length(classes[,1]) 
par( mfrow=c(1,2))
recallTable=data.frame( c( classes[,2], stringtie[,2], scallop[,2] ) )
colnames( recallTable )<-c("Recall")
recallTable$Software<-c( rep( "PsiCLASS", sampleCnt ), rep( "StringTie", sampleCnt ), rep( "Scallop", sampleCnt ) )
recallTable$Software<-factor( recallTable$Software, levels=c( "PsiCLASS", "StringTie", "Scallop" ) )
boxplot( Recall~Software, data=recallTable, main="Recall", ylab="Recall", ylim=c(0,0.15) )
points( x=c(1, 2, 3), y = c(classVote[1], stmerge[1], taco[1] ) , col=c("red", "blue", "goldenrod3"), pch=c(15, 16, 17), cex=1.5 )
lines( x=c(1,1), y=c(voten[1,2], voten[sampleCnt,2]), col="red", lty=3, lwd=0.75) 
points( x=c(1,1), y=c(voten[6,2],voten[1,2]), col="red", pch=c(7, 12)) 


precisionTable=data.frame( c( classes[,3], stringtie[,3], scallop[,3] ) )
colnames( precisionTable )<-c("Precision")
precisionTable$Software<-recallTable$Software
boxplot( Precision~Software, data=precisionTable, ylab="Precision", main="Precision", ylim=c(0, 1) )
points( x=c(1, 2, 3), y = c(classVote[2], stmerge[2], taco[2] ) , col=c("red", "blue", "goldenrod3"), pch=c(15, 16, 17), cex=1.5 )
legend( x=2.2, y=1, c( "PsiCLASS", "ST-merge", "TACO" ), col=c("red", "blue", "goldenrod3"), pch=18, cex=0.8 )
lines( x=c(1,1), y=c(voten[1,3], voten[sampleCnt,3]), col="red", lty=3, lwd=0.75) 
points( x=c(1,1), y=c(voten[6,3],voten[1,3]), col="red", pch=c(7, 12)) 
par( mfrow=c(1,1) )

# variation of combinationas with voten
stmerge<-read.table( "Liver/stmerge_summary.out" ) 
taco<-read.table( "Liver/taco_summary.out" ) 
#length(voten[,1])/4
f<-plot( x=c(classVote[1], stmerge[,2], taco[,2] ), y=c(classVote[2], stmerge[,3], taco[,3] ), 
         xlab="Recall", ylab="Precision",
         pch=c(0,0,1,2,0,1,2), 
         col=c("red", rep( "blue", length( stmerge[,2] ) ), rep( "goldenrod3", length( taco[,2] )) ),
         xlim=c(0,0.15), ylim=c(0, 1)) 

lines( x=voten[,2], y=voten[,3], col="red", lty=2) ;
x=0.12
width=0.033
legend( x=c(x, x+width), y=c(1.0, 0.77), c( "PsiCLASS", "StringTie", "Scallop"), pch=c(0, 1, 2) )
legend( x=c(x, x+width), y=c(0.75, 0.51), c( "Integrated", "ST-merge", "TACO" ), pch=rep(18, 4), col=c("red", "blue", "goldenrod3") )

# Change the threshold of isoform fraction for stmerge and taco
stmergeFcutoff<-read.table( "Liver/stmergeFcutoff_summary.out")
tacoFcutoff<-read.table( "Liver/tacoFcutoff_summary.out" )

plot( x=voten[,2], y=voten[,3], col="red", type="l", xlab="Recall", ylab="Precision", xlim=c(0,0.15), ylim=c(0,1))
lines( x=stmergeFcutoff[,2], y=stmergeFcutoff[,3], col="blue" )
lines( x=tacoFcutoff[,2], y=tacoFcutoff[,3], col="goldenrod3")
points( x=classVote[1], y=classVote[2], col="red", pch=0 )
points( x=stmerge[2,2], y=stmerge[2,3], col="blue", pch=1) 
points( x=taco[3,2], y=taco[3,3], col="goldenrod3", pch=2) 
legend( x=0.1, y=1, c( "CLASS3", "StringTie", "Scallop+TACO" ), col=c("red", "blue", "goldenrod3"), pch=c(0,1,2), lty=c(1,1,1)  )


# HSCs
install.packages("vioplot")
library(vioplot)
classes<-read.table( "HSCs/classes_summary.out")
stringtie<-read.table( "HSCs/stringtie_summary.out" ) 
scallop<-read.table( "HSCs/scallop_summary.out") 

sampleCnt = length(classes[,1]) 
par( mfrow=c(1,2))
recallTable=data.frame( c( classes[,2], stringtie[,2], scallop[,2] ) )
colnames( recallTable )<-c("Recall")
recallTable$Software<-c( rep( "CLASS3", sampleCnt ), rep( "StringTie", sampleCnt ), rep( "Scallop", sampleCnt ) )
recallTable$Software<-factor( recallTable$Software, levels=c( "CLASS3", "StringTie", "Scallop" ) )
vioplot( Recall~Software, data=recallTable, main="Recall", ylab="Recall", ylim=c(0,0.06) )

precisionTable=data.frame( c( classes[,3], stringtie[,3], scallop[,3] ) )
colnames( precisionTable )<-c("Precision")
precisionTable$Software<-recallTable$Software
boxplot( Precision~Software, data=precisionTable, ylab="Precision", main="Precision", ylim=c(0, 1) )
par( mfrow=c(1,1) )
