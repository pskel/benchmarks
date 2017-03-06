###################### PLOT BAR GRAPHS #################################################
#read speedup data
apps = read.csv('app_predicted.csv')
#apps = read.csv('apps_quadro.csv')
apps$app = as.character(apps$app)

par(xpd=TRUE,cex.lab=1.5)

######################## PLOT % VARIATION


########### convolution ################
    seq_conv = 144.61
    x1 <- 6.17 #cpu-only 
    x2 <- 6.31 #0.05
    x3 <- 6.18 #0.1
    x4 <- 5.96 #0.15
    x5 <- 5.72 #0.2
    x6 <- 5.56 #0.25
    x7 <- 5.4 #0.3
    x8 <- 5.25 #0.35
    x9 <- 5.04 #0.4
    x10 <- 4.97  #0.45
    x11 <- 4.74 #0.5
    x12 <- 4.51 #0.55
    x13 <- 4.47 #0.6
    x14 <- 4.39 #0.65
    x15 <- 4.74 #0.7
    x16 <- 5.02 #0.75
    x17 <- 5.3 #0.8
    x18 <- 5.67  #0.85
    x19 <- 5.92 #0.9
    x20 <- 6.24 #0.95
    x21 <- 6.4 #gpu-only

    height <- seq_conv/c(x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,x13,x14,x15,x16,x17,x18,x19,x20,x21)
    setEPS()
    postscript("convolution_partition_nolabel.eps")
    ##names.arg = c(0.0,0.5,0.55,0.6,0.65,0.7,0.75,0.8,0.85,1.0)

    xx <- barplot(height,ylim = c(0,35),cex.axis=1.5,cex.names=1.5,cex.lab=1.8,mgp=c(2.8,0.5,0),names.arg=FALSE)
    text(x = xx+0.2 , y=-0.5, label=c("0%","5%","10%","15%","20%","25%","30%","35%","40%","45%","50%","55%","60%","65%","70%","75%","80%","85%","90%","95%","100%"), pos=2,cex=1.5,srt=90,xpd=TRUE)
    dev.off()
##################################################################################################################
    
########### FAST ################
    seq_fast = 54.76
    x1 <- 6.92 #cpu-only 
    x2 <- 6.78 #0.05
    x3 <- 6.63 #0.1
    x4 <- 6.50 #0.15
    x5 <- 6.43 #0.2
    x6 <- 6.2 #0.25
    x7 <- 5.93 #0.3
    x8 <- 5.75 #0.35
    x9 <- 5.64 #0.4
    x10 <- 5.56  #0.45
    x11 <- 5.42 #0.5
    x12 <- 5.33 #0.55
    x13 <- 5.81 #0.6
    x14 <- 5.88 #0.65
    x15 <- 6.26 #0.7
    x16 <- 6.66 #0.75
    x17 <- 7.10 #0.8
    x18 <- 7.54  #0.85
    x19 <- 7.97 #0.9
    x20 <- 8.39 #0.95
    x21 <- 8.53 #gpu-only
    
    height <- seq_fast/c(x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,x13,x14,x15,x16,x17,x18,x19,x20,x21)
    setEPS()
    postscript("fast_partition_nolabel.eps")
    ##names.arg = c(0.0,0.5,0.55,0.6,0.65,0.7,0.75,0.8,0.85,1.0)
    
    xx <- barplot(height,ylim = c(0,12), xlim = c(0,100), cex.axis=2.2,cex.names=1.5,cex.lab=1.8,mgp=c(2.8,0.5,0),names.arg=FALSE)
    text(x = xx+0.5 , y=-0.5, label=c("0%","5%","10%","15%","20%","25%","30%","35%","40%","45%","50%","55%","60%","65%","70%","75%","80%","85%","90%","95%","100%"), pos=2,cex=1.5,srt=60,xpd=TRUE)
    dev.off()
##################################################################################################################
 
########### CLOUDSIM ################
    seq_cloudsim = 58.28
    x1 <- 7.45 #cpu-only 
    x2 <- 7.40 #0.05
    x3 <- 7.03 #0.1
    x4 <- 6.62 #0.15
    x5 <- 6.31 #0.2
    x6 <- 6.00 #0.25
    x7 <- 5.64 #0.3
    x8 <- 5.25 #0.35
    x9 <- 4.96 #0.4
    x10 <- 4.61  #0.45
    x11 <- 4.33 #0.5
    x12 <- 4.02 #0.55
    x13 <- 3.84 #0.6
    x14 <- 3.4 #0.65
    x15 <- 3.15 #0.7
    x16 <- 2.92 #0.75
    x17 <- 2.67 #0.8
    x18 <- 2.57  #0.85
    x19 <- 2.70 #0.9
    x20 <- 2.82 #0.95
    x21 <- 3.13 #gpu-only
    
    height <- seq_cloudsim/c(x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,x13,x14,x15,x16,x17,x18,x19,x20,x21)
    setEPS()
    postscript("cloudsim_partition_nolabel.eps")
    ##names.arg = c(0.0,0.5,0.55,0.6,0.65,0.7,0.75,0.8,0.85,1.0)
    
    xx <- barplot(height,ylim = c(0,25),cex.axis=2.2,cex.names=1.5,cex.lab=1.8,mgp=c(2.8,0.5,0),names.arg=FALSE)
    text(x = xx+0.5 , y=-0.5, label=c("0%","5%","10%","15%","20%","25%","30%","35%","40%","45%","50%","55%","60%","65%","70%","75%","80%","85%","90%","95%","100%"), pos=2,cex=1.5,srt=90,xpd=TRUE)
    dev.off()
##################################################################################################################
    
    
########### JACOBI ################
    seq_jacobi = 39.8
    x1 <- 6.09 #cpu-only 
    x2 <- 5.96 #0.05
    x3 <- 5.71 #0.1
    x4 <- 5.40 #0.15
    x5 <- 5.14 #0.2
    x6 <- 4.88 #0.25
    x7 <- 4.64 #0.3
    x8 <- 4.38 #0.35
    x9 <- 4.08 #0.4
    x10 <- 3.83  #0.45
    x11 <- 3.63 #0.5
    x12 <- 3.28 #0.55
    x13 <- 3.04 #0.6
    x14 <- 2.83 #0.65
    x15 <- 2.61 #0.7
    x16 <- 2.36 #0.75
    x17 <- 2.23 #0.8
    x18 <- 2.17  #0.85
    x19 <- 2.16 #0.9
    x20 <- 2.15 #0.95
    x21 <- 2.15 #gpu-only
    
    height <- seq_jacobi/c(x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,x13,x14,x15,x16,x17,x18,x19,x20,x21)
    setEPS()
    postscript("jacobi_partition_nolabel.eps")
    ##names.arg = c(0.0,0.5,0.55,0.6,0.65,0.7,0.75,0.8,0.85,1.0)
    
    xx <- barplot(height,ylim = c(0,20),cex.axis=2.2,cex.names=1.5,cex.lab=1.8,mgp=c(2.8,0.5,0),names.arg=FALSE)
    text(x = xx+0.5 , y=-0.5, label=c("0%","5%","10%","15%","20%","25%","30%","35%","40%","45%","50%","55%","60%","65%","70%","75%","80%","85%","90%","95%","100%"), pos=2,cex=1.5,srt=90,xpd=TRUE)
    dev.off()
##################################################################################################################
    
########### GOL ################
    seq_gol = 55.92
    x1 <- 1.90 #cpu-only 
    x2 <- 3.48 #0.05
    x3 <- 3.46 #0.1
    x4 <- 3.36 #0.15
    x5 <- 3.19 #0.2
    x6 <- 3.05 #0.25
    x7 <- 3.08 #0.3
    x8 <- 2.92 #0.35
    x9 <- 2.76 #0.4
    x10 <- 2.7  #0.45
    x11 <- 2.52 #0.5
    x12 <- 1.77 #0.55
    x13 <- 1.72 #0.6
    x14 <- 1.73 #0.65
    x15 <- 1.84 #0.7
    x16 <- 1.92 #0.75
    x17 <- 1.86 #0.8
    x18 <- 1.97  #0.85
    x19 <- 2.07 #0.9
    x20 <- 2.18 #0.95
    x21 <- 2.14 #gpu-only
    
    height <- seq_gol/c(x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,x13,x14,x15,x16,x17,x18,x19,x20,x21)
    setEPS()
    postscript("gol_partition_nolabel.eps")
    ##names.arg = c(0.0,0.5,0.55,0.6,0.65,0.7,0.75,0.8,0.85,1.0)
    
    xx <- barplot(height,ylim = c(0,35),cex.axis=2.2,cex.names=1.5,cex.lab=1.8,mgp=c(2.8,0.5,0),names.arg=FALSE)
    text(x = xx+0.5 , y=-0.5, label=c("0%","5%","10%","15%","20%","25%","30%","35%","40%","45%","50%","55%","60%","65%","70%","75%","80%","85%","90%","95%","100%"), pos=2,cex=1.5,srt=90,xpd=TRUE)
    dev.off()
##################################################################################################################
    
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
    postscript(paste(c(j,"_tesla.eps"),collapse=""))
    
    xx <- barplot(height, beside = TRUE, names.arg = c(1,10,20,30,40,50,60,"gmean"),ylim=c(0,50))
    ##xlab = "# of iterations", ylab = "Speedup over single core",legend = c("CPU only","GPU only","Naive","AWP","Oracle"), args.legend = list(x="top",horiz=FALSE,inset=c(0,-0.1),ncol=2,cex=1.5),cex.axis=1.3,cex.names=1.2,cex.lab=1.5,mgp=c(2.8,1,0)
   #text(x = xx, y=height[x][], label=round(height[x],1), pos=3, col="black", font=2, cex=1.1)
    dev.off()
  #}
}

#-----------------------------------------------------------------------------------------#
#PLOT SPEEDUP GEOMEAN for all iterations of all aplications
# i=8192
# apps.geomean = apps[which(apps$input==8192),]
# #get indexes of 1 iteration
# fast.index = which(apps.geomean$app == "fast" & apps.geomean$ite == 1)
# conv.index = which(apps.geomean$app == "convolution" & apps.geomean$ite == 1)
# cloudsim.index = which(apps.geomean$app == "cloudsim" & apps.geomean$ite == 1)
# gol.index = which(apps.geomean$app == "gol" & apps.geomean$ite == 1)
# jacobi.index = which(apps.geomean$app == "jacobi" & apps.geomean$ite == 1)
# 
# apps.geomean = apps.geomean[-c(fast.index,conv.index,cloudsim.index,gol.index,jacobi.index),]

# x1 <- apps.geomean[,c("speedup_cpu")]
# x2 <- apps.geomean[,c("speedup_50")]
# x3 <- apps.geomean[,c("speedup_55")]
# x4 <- apps.geomean[,c("speedup_60")]
# x5 <- apps.geomean[,c("speedup_65")]
# x6 <- apps.geomean[,c("speedup_70")]
# x7 <- apps.geomean[,c("speedup_75")]
# x8 <- apps.geomean[,c("speedup_80")]
# x9 <- apps.geomean[,c("speedup_85")]
# x10<- apps.geomean[,c("speedup_gpu")]
# x11<- apps.geomean[,c("speedup_predicted")]
# x12<- apps.geomean[,c("speedup_oracle")]

    
######### QUADRO ######################
x1 <- 11.55 #cpu-only 
x2 <- 10.5 #0.05
x3 <- 11.25 #0.1
x4 <- 11.64 #0.15
x5 <- 12.09 #0.2
x6 <- 12.55 #0.25
x7 <- 12.7 #0.3
x8 <- 13.65 #0.35
x9 <- 14.28 #0.4
x10 <- 14.81  #0.45
x11 <- 14.95 #0.5
x12 <- 16.25 #0.55
x13 <- 16.63 #0.6
x14 <- 16.85 #0.65
x15 <- 17.06 #0.7
x16 <- 17.04 #0.75
x17 <- 17.16 #0.8
x18 <- 16.64  #0.85
x19 <- 15.99 #0.9
x20 <- 15.38  #0.95
x21 <- 15.47 #gpu-only
x22 <- 15.74 #naive
x23 <- 18.81 #awp
x24 <- 20.40 #oracle

height <- c(x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,x13,x14,x15,x16,x17,x18,x19,x20,x21,x22,x23,x24)

#height <- c(exp(mean(log(x1))),exp(mean(log(x2))),exp(mean(log(x3))),exp(mean(log(x4))),exp(mean(log(x5))),exp(mean(log(x6))),exp(mean(log(x7))),exp(mean(log(x8))),exp(mean(log(x9))),exp(mean(log(x10))),exp(mean(log(x11))),exp(mean(log(x12))))

setEPS()
postscript("geomean_speedup_quadro.eps")
xx <- barplot(height,xlab = "",ylab = "",ylim = c(0,25),names.arg = FALSE,cex.names=1.0,cex.lab=1.0,cex.axis=1.0,mgp=c(3,1,.1))
text(x = xx, y=height, label=round(height,1), pos=3, col="black", font=2, cex=0.75)
text(x = xx+0.5 , y=-0.7, label=c("0%","5%","10%","15%","20%","25%","30%","35%","40%","45%","50%","55%","60%","65%","70%","75%","80%","85%","90%","95%","100%","Naive","AWP","Oracle"), pos=2,cex=1,srt=45,xpd=TRUE)
dev.off()
###############################################################################################


########## TESLA ###############
x1 <- 11.55 #cpu-only
x2 <- 10.5 #0.05
x3 <- 11.25 #0.1
x4 <- 11.64 #0.15
x5 <- 12.09 #0.2
x6 <- 12.55 #0.25
x7 <- 12.7 #0.3
x8 <- 13.65 #0.35
x9 <- 14.28 #0.4
x10 <- 14.81  #0.45
x11 <- 14.95 #0.5
x12 <- 16.25 #0.55
x13 <- 16.63 #0.6
x14 <- 16.85 #0.65
x15 <- 17.06 #0.7
x16 <- 17.04 #0.75
x17 <- 17.16 #0.8
x18 <- 16.64  #0.85
x19 <- 15.99 #0.9
x20 <- 15.38  #0.95
x21 <- 15.47 #gpu-only
x22 <- 15.74 #naive
x23 <- 18.81 #awp
x24 <- 20.40 #oracle




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
