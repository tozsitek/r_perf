# XFiles model GCaP class and book p. 256.
# Created by NJG on Thu May 10 07:00:46 2012
#
# Original model: R / 9.41 = log10(4781) / log10(110)

FServer   <- c("Xfs1","Xfs2","NFS1","NFS2")
nFonts    <- c(8371, 7113, 4781, 109)
RTdata    <- c(18.57, 16.72, 17.01, 9.41)
df.files  <- data.frame(FServer, nFonts, RTdata)
print(df.files)

# Regression fit: k coefficient = 10 / log10(100) = 10/2 = 5
fit <- nls(RTdata ~ k * log10(nFonts), data=df.files, start=list(k=5.0))
# 4.570728  cd. 9.41 / log10(100) =  4.705 in my original model
print(summary(fit))
print(coef(fit)) 
logmodel <- function(fonts) { coef(fit)[1] * log10(fonts) }


# Linear x-scale plot
plot(df.files$nFonts, df.files$RTdata, type="p", 
  xlim=c(1,1e4), ylim=c(0,20), 
	xlab="Number of fonts (N)", 
  ylab="Avg launch time (R) in secs.",
	main="Log Model")
curve(logmodel(x), from=1, to=1e4, col="blue", lwd=2, add=TRUE)
text(5000,10,"© 2017 Performance Dynamics",col="gray",cex=0.75)
legend("bottomright", legend=c("Data", "Model"),  
       lty=c(NA,1), lwd=c(NA,2), 
       col=c("black","blue"),
       pch=c(1,NA), cex=0.75, inset=0.05) 

# log x-scale plot
plot(df.files$nFonts, df.files$RTdata, type="p", 
     xlim=c(1,1e4), ylim=c(1,20), log="x", 
     xlab="Log fonts (log N)", 
     ylab="Avg launch time (R) in secs.",
     main="Log-Linear Plot")
abline(a=0, b=coef(fit), lty="solid", lwd=2, col="blue")
text(500,5,"© 2017 Performance Dynamics",col="gray",cex=0.75)
legend("topleft", legend=c("Data", "LSQ fit"),  
       lty=c(NA,1), lwd=c(NA,2),
       col=c("black","blue"),
       pch=c(1,NA), cex=0.75, inset=0.05) 



# Calculate errors
RTmodel <- sapply(nFonts, FUN=logmodel)
RTerrpc <- 100 * (RTdata - RTmodel) / RTdata
df.rt   <- data.frame(FServer, RTdata, RTmodel, RTerrpc)
print(df.rt)



