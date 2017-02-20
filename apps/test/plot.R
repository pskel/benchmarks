###################### PLOT BAR GRAPHS #################################################
#read speedup data
apps = read.csv('app_predicted.csv')
apps$app = as.character(apps$app)

par(xpd=TRUE,cex.lab=1.5)

#PLOT % VARIATION
# for(j in c("cloudsim","convolution","fast",'gol','jacobi')){
#   for(i in c(8192)){
#     x1 <- apps[which(apps$input == i & apps$app == j & apps$ite==60),c("speedup_cpu")]
#     x2 <- apps[which(apps$input == i & apps$app == j & apps$ite==60),c("speedup_50")]
#     x3 <- apps[which(apps$input == i & apps$app == j & apps$ite==60),c("speedup_55")]
#     x4 <- apps[which(apps$input == i & apps$app == j & apps$ite==60),c("speedup_60")]
#     x5 <- apps[which(apps$input == i & apps$app == j & apps$ite==60),c("speedup_65")]
#     x6 <- apps[which(apps$input == i & apps$app == j & apps$ite==60),c("speedup_70")]
#     x7 <- apps[which(apps$input == i & apps$app == j & apps$ite==60),c("speedup_75")]
#     x8 <- apps[which(apps$input == i & apps$app == j & apps$ite==60),c("speedup_80")]
#     x9 <- apps[which(apps$input == i & apps$app == j & apps$ite==60),c("speedup_85")]
#     x10 <- apps[which(apps$input == i & apps$app == j & apps$ite==60),c("speedup_gpu")]
#     
#     height <- c(x1,x2,x3,x4,x5,x6,x7,x8,x9,x10)
#     setEPS()
#     postscript(paste(c(j,"_",i,"_partition_nolabel.eps"),collapse=""))
#     ##names.arg = c(0.0,0.5,0.55,0.6,0.65,0.7,0.75,0.8,0.85,1.0)
#     
#     xx <- barplot(height,ylim = c(0,30),cex.axis=2.2,cex.names=1.5,cex.lab=1.8,mgp=c(2.8,0.5,0),names.arg=FALSE)
#     text(x = xx+0.5 , y=-1, label=c("0%","50%","55%","60%","65%","70%","75%","80%","85%","100%"), pos=2,cex=2.2,srt=45,xpd=TRUE)
#     dev.off()
#   }
# }

#-------------------------------------------------------------------------------------------#
#PLOT Exec_time FOR ALL ITERATIONS WITH SIZE 24000

par(xpd=TRUE,cex.lab=1.5)
for(j in c('cloudsim','convolution','fast','gol','jacobi')){
  #for(i in c(24000)){
    x <- apps[which(apps$app == j & apps$ite >= 1),c("speedup_cpu")]
    x <- c(x,exp(mean(log(x[-1])))) #geometric mean
    y <- apps[which(apps$app ==j  & apps$ite >= 1),c("speedup_gpu")]
    y <- c(y,exp(mean(log(y[-1])))) #geometric mean
    t <- apps[which(apps$app ==j  & apps$ite >= 1),c("speedup_naive")]
    t <- c(t,exp(mean(log(t[-1])))) #geometric mean
    w <- apps[which(apps$app ==j  & apps$ite >= 1),c("speedup_awt")]
    w <- c(w,exp(mean(log(w[-1])))) #geometric mean
    z <- apps[which(apps$app ==j  & apps$ite >= 1),c("speedup_oracle")]
    z <- c(z,exp(mean(log(z[-1])))) #geometric mean
    
    # create a two row matrix with x and y
    height <- rbind(x,y,t,w,z)
    setEPS()
    postscript(paste(c(j,"_new.eps"),collapse=""))
    
    xx <- barplot(height, beside = TRUE, names.arg = c(1,10,20,30,40,50,60,"gmean"),ylim=c(0,max(x,y,w,z,t)), main = j)
    ##xlab = "# of iterations", ylab = "Speedup over single core",legend = c("CPU only","GPU only","Naive","AWP","Oracle"), args.legend = list(x="top",horiz=FALSE,inset=c(0,-0.1),ncol=2,cex=1.5),cex.axis=1.3,cex.names=1.2,cex.lab=1.5,mgp=c(2.8,1,0)
    
    #text(x = xx, y=height[x][], label=round(height[x],1), pos=3, col="black", font=2, cex=1.1)
    dev.off()
  #}
}

#-----------------------------------------------------------------------------------------#
#PLOT SPEEDUP GEOMEAN for all iterations of all aplications
i=8192
apps.geomean = apps[which(apps$input==8192),]
#get indexes of 1 iteration
fast.index = which(apps.geomean$app == "fast" & apps.geomean$ite == 1)
conv.index = which(apps.geomean$app == "convolution" & apps.geomean$ite == 1)
cloudsim.index = which(apps.geomean$app == "cloudsim" & apps.geomean$ite == 1)
gol.index = which(apps.geomean$app == "gol" & apps.geomean$ite == 1)
jacobi.index = which(apps.geomean$app == "jacobi" & apps.geomean$ite == 1)

apps.geomean = apps.geomean[-c(fast.index,conv.index,cloudsim.index,gol.index,jacobi.index),]

x1 <- apps.geomean[,c("speedup_cpu")]
x2 <- apps.geomean[,c("speedup_50")]
x3 <- apps.geomean[,c("speedup_55")]
x4 <- apps.geomean[,c("speedup_60")]
x5 <- apps.geomean[,c("speedup_65")]
x6 <- apps.geomean[,c("speedup_70")]
x7 <- apps.geomean[,c("speedup_75")]
x8 <- apps.geomean[,c("speedup_80")]
x9 <- apps.geomean[,c("speedup_85")]
x10<- apps.geomean[,c("speedup_gpu")]
x11<- apps.geomean[,c("speedup_predicted")]
x12<- apps.geomean[,c("speedup_oracle")]

height <- c(exp(mean(log(x1))),exp(mean(log(x2))),exp(mean(log(x3))),exp(mean(log(x4))),exp(mean(log(x5))),exp(mean(log(x6))),exp(mean(log(x7))),exp(mean(log(x8))),exp(mean(log(x9))),exp(mean(log(x10))),exp(mean(log(x11))),exp(mean(log(x12))))

setEPS()
postscript("geomean_speedup.eps")
xx <- barplot(height,xlab = "",ylab = "",ylim = c(0,20),names.arg = FALSE,cex.names=1.5,cex.lab=1.8,cex.axis=2.2,mgp=c(3,1,.1))
text(x = xx, y=height, label=round(height,1), pos=3, col="black", font=2, cex=1.4)
text(x = xx+0.5 , y=-0.7, label=c("0%","50%","55%","60%","65%","70%","75%","80%","85%","100%","AWP","Oracle"), pos=2,cex=2.1,srt=45,xpd=TRUE)
dev.off()

#----------------------------------------------------------------------------------------------#
#PLOT Execution time for different input sizes
for(j in c("cloudsim","convolution","fast","gol","jacobi")){
  for(i in c(60)){
    x <- apps[which(apps$ite == i & apps$app ==j & apps$input >= 256),c("Exec_time_cpu")]
    #x <- c(x,exp(mean(log(x[-1])))) #geometric mean
    y <- apps[which(apps$ite == i & apps$app ==j & apps$input >= 256),c("Exec_time_gpu")]
    #y <- c(y,exp(mean(log(y[-1])))) #geometric mean
    w <- apps[which(apps$ite == i & apps$app ==j & apps$input >= 256),c("Exec_time_predicted")]
    #w <- c(w,exp(mean(log(w[-1])))) #geometric mean
    z <- apps[which(apps$ite == i & apps$app ==j & apps$input >= 256),c("Exec_time")]
    #z <- c(z,exp(mean(log(z[-1])))) #geometric mean
    
    # create a two row matrix with x and y
    height <- rbind(x,y,w,z)
    # Use height and set 'beside = TRUE' to get pairs
    # save the bar midpoints in 'mp'
    # Set the bar pair labels to A:D
    #png(paste(c(j,"_",i,".png"),collapse=""))
    setEPS()
    postscript(paste(c(j,"_",i,".eps"),collapse=""))
    barplot(height, beside = TRUE, ylim=c(0.01,max(x,y,w,z)),names.arg = c("256","512","1024","2048","4096","8192"),xlab = "Problem size",ylab = "Execution time (s)",log="y")
    #legend = c("CPU only","GPU only","Predictive model","Oracle"), args.legend = list(x="top",horiz=FALSE,inset=c(0,-0.1),ncol=2,cex=1.5),cex.axis=1.3,cex.names=1.2,cex.lab=1.5,mgp=c(2.8,1,0)
    #text(x = xx, y=height[x][], label=round(height[x],1), pos=3, col="black", font=2, cex=1.1)
    dev.off()
  }
}