library(sperrorest)

options(digits = 2, width = 100)
#df=read.csv("apps_profile.csv")
df=read.csv("synthetic4b.csv")

#transform values
df$app = as.character(df$app)
df$pct_gpu = factor(df$pct_gpu)

#checking summary of the dataset
summary(df)

colnames = colnames(df)
for(i in 12:length(df)){
  print(colnames[i])
  cat("min:",min(df[,i]),"max:",max(df[,i]),"mean:",mean(df[,i]),"median:",median(df[,i]))
  print("\n")
}

#histogram of the data
colors = c("red", "yellow", "green", "violet", "orange","blue", "pink", "cyan", "brown", "gray") 
for(i in 12:length(df)){
  if(!is.na(df[1,i])){
    hist(df[,i],
         right=FALSE,
         main=colnames[i],
         col=colors,
         xlab="instance value",
         labels=TRUE,
         ylab="# of instance"
    )
  }
}

#frequency distribution
for(i in 12:ncol(df)){
  if(!is.na(df[,i])){
    print(colnames[i])
    data = df[,i]
    data.freq = table(data)
    data.relfreq = data.freq / nrow(df)
    print(data.freq)
    print(data.relfreq)
    barplot(data.freq,
            col=colors,
            main=colnames[i]
    )
  }
}

#correlation checking
cor(df[,c(12:37)])

#kmeans using LD_INS and L3_TCM columns with 4 clusters
result = kmeans(df[,c(33,30)],
                2,
                iter.max=1000,
                nstart=1,
                algorithm="Hartigan-Wong",
                trace=FALSE
)
plot(df[c(33,30)],col=result$cluster,xlab='LD_INS', ylab="L3_TCM")
points(result$centers, col=1:2,pch=8,cex=20)
print(result$centers)
table(df$pct_gpu, result$cluster)

##############################################################
#Decision Tree with rpart

# grow tree
# stall_exec_dependency
# stall_other
# stall_not_selected
# active_warps
# stall_inst_fetch
# stall_constant_memory_dependency
#  stall_sync
# stall_memory_throttle
fit <- rpart(pct_gpu ~ ite + FP_INS + FDV_INS + VEC_SP + BR_MSP + BR_CN + BR_TKN + BR_PRC + BR_MSP + LD_INS + SR_INS + L1_DCH + L1_REUSE + L2_DCH + L2_REUSE + L2_DCM + L2_TCM + L2_STM + L2_LDM + L2_DCR + L2_DCW + L2_TCR + L2_TCW + L3_REUSE + L3_TCM + L3_DCR + L3_DCW + L3_TCR + L3_TCW + INS_CYC + STL_ICY + REF_CYC + sm_efficiency + l2_l1_read_hit_rate +  + gst_efficiency + active_cycles + inst_fp_64 + gst_throughput + inst_issued2 + gst_inst_64bit + shared_store_transactions +  branch_efficiency + l1_shared_utilization + warp_nonpred_execution_efficiency + gld_inst_8bit + sysmem_read_throughput + gld_inst_64bit + issue_slot_utilization + shared_efficiency + shared_load_transactions + l2_l1_read_throughput + tex_cache_hit_rate + shared_store_throughput + tex_cache_throughput + gld_request + achieved_occupancy +  + shared_store + gld_inst_128bit + elapsed_cycles_sm + X__l1_global_load_transactions +  + inst_fp_32 + dram_read_transactions + l1_cache_local_hit_rate + dram_write_transactions + inst_bit_convert + + gld_transactions_per_request + l2_texture_read_hit_rate + gst_requested_throughput + gst_request + rocache_gld_inst_32bit + inst_integer + inst_issued + ecc_transactions + cf_fu_utilization + rocache_subp3_gld_thread_count_128b + ipc_instance + gld_inst_16bit + global_store_transaction + inst_per_warp + rocache_subp2_gld_warp_count_32b + rocache_subp0_gld_warp_count_128b + issued_ipc + gld_transactions + shared_load_throughput + sm_cta_launched + rocache_subp1_gld_warp_count_64b + inst_control + rocache_gld_inst_64bit + dram_utilization + rocache_subp0_gld_warp_count_64b  + gst_inst_128bit + shared_load_transactions_per_request + rocache_subp2_gld_warp_count_128b + l1_cache_global_hit_rate + dram_read_throughput + flop_count_sp_mul + not_predicated_off_thread_inst_executed + flop_count_sp_add + gld_inst_32bit + eligible_warps_per_cycle + ipc + l2_l1_write_transactions + gst_inst_32bit + issue_slots + cf_executed + ldst_fu_utilization + uncached_global_load_transaction + inst_misc + gld_requested_throughput + L3_DCH + flop_count_sp_special + sysmem_read_transactions + rocache_subp1_gld_warp_count_32b + l2_tex_read_transactions + rocache_subp1_gld_thread_count_64b + gst_inst_8bit + rocache_subp3_gld_thread_count_64b + sysmem_write_throughput + l2_atomic_transactions + l2_l1_write_throughput + alu_fu_utilization + l2_texture_read_throughput + ldst_executed + gst_transactions_per_request + rocache_subp2_gld_warp_count_64b + nc_l2_read_transactions + tex_cache_transactions + tex_utilization + l2_read_throughput + gst_transactions + rocache_gld_inst_8bit + rocache_subp1_gld_warp_count_128b + gld_throughput + rocache_gld_inst_16bit + rocache_subp3_gld_warp_count_128b +  + rocache_gld_inst_128bit + stall_texture +  + stall_memory_dependency + X__l1_global_store_transactions + sysmem_utilization + gst_inst_16bit + l1_shared_load_transactions + l2_write_transactions + threads_launched + nc_gld_efficiency + l2_read_transactions + rocache_subp3_gld_warp_count_64b + thread_inst_executed + l1_shared_store_transactions + cf_issued + warps_launched + ecc_throughput + l2_atomic_throughput + flop_dp_efficiency + shared_load + flop_sp_efficiency + sysmem_write_transactions + stall_pipe_busy + inst_compute_ld_st + dram_write_throughput + nc_cache_global_hit_rate + flop_count_sp + rocache_subp0_gld_warp_count_32b + sm_efficiency_instance + l2_utilization + rocache_subp1_gld_thread_count_128b + inst_executed + rocache_subp0_gld_thread_count_32b + warp_execution_efficiency + stall_data_request + tex_fu_utilization + l2_write_throughput + rocache_subp0_gld_thread_count_64b + ldst_issued + tex2_cache_sector_misses + inst_issued1 + gld_efficiency + l2_l1_read_transactions + rocache_subp2_gld_thread_count_32b + shared_store_transactions_per_request + flop_count_sp_fma, method="class", data=df,control=rpart.control(minsplit=1),minbucket=1)
prp(fit,type=0,extra=102,digits=4,under=FALSE,faclen=0,varlen=0,split.border.col=0,fallen.leaves = TRUE,leaf.round=1,ycompress = TRUE,compress=TRUE,xcompact=TRUE,xcompact.ratio=0.5,ycompact=FALSE,nn=FALSE,split.font=1,branch=1,tweak=0.95,cex=0.65,branch.tweak=1.1,split.cex=1,xflip=TRUE,left=TRUE,nn.cex=0.7)

rpart.plot(fit,main=paste("rpart CPU-GPU minsplit",collapse=" "),cex = 0.6)

fit <- rpart(pct_gpu ~ ite + L2_DCM +  L3_TCM + l1_cache_global_hit_rate  sm_efficiency + ipc + gld_transactions_per_request + gst_transactions_per_request + stall_inst_fetch + stall_exec_dependency + stall_data_request + stall_memory_dependency + stall_sync + stall_other + warp_execution_efficiency + gld_efficiency + gst_efficiency + l2_l1_read_hit_rate + issued_ipc + flop_sp_efficiency + stall_pipe_busy + stall_memory_throttle,method="class", data=df,control=rpart.control(minsplit=20),minbucket=8)

prp(fit,type=0,extra=102,digits=4,under=FALSE,faclen=0,varlen=0,split.border.col=0,fallen.leaves = TRUE,leaf.round=1,ycompress = TRUE,compress=TRUE,xcompact=TRUE,xcompact.ratio=0.5,ycompact=FALSE,nn=FALSE,split.font=1,branch=1,tweak=0.95,cex=0.65,branch.tweak=1.1,split.cex=1,xflip=TRUE,left=TRUE,nn.cex=0.7)

rpart.plot(fit,main=paste("rpart CPU-GPU minsplit",collapse=" "),cex = 0.6)
summary(fit)
print(fit)

printcp(fit) # display the results 
plotcp(fit) # visualize cross-validation results 
summary(fit) # detailed summary of splits

# plot tree 
plot(fit, uniform=TRUE, main="CPU GPU Classification") 
text(fit, use.n=TRUE, all=TRUE, cex=.8)

# create attractive postscript plot of tree 
#post(fit, file = "./tree.ps", title = "CPU GPU Classification")

# prune the tree 
pfit<- prune(fit, cp=fit$cptable[which.min(fit$cptable[,"xerror"]),"CP"])

# plot the pruned tree 
#plot(pfit, uniform=TRUE,main="Pruned Classification Tree")
#text(pfit, use.n=TRUE, all=TRUE, cex=.8)
#post(pfit, file = "./ptree.ps",title = "Pruned Classification Tree")

rpart.plot(pfit,main="rpart CPU-GPU pruned",cex = 0.6)

#accuracy check using test-set cross validation
set.seed(100)
options(digits = 3)
test.indices = sample.int(nrow(df), size = round(nrow(df)*0.3))
df.train = df[-test.indices,]
df.test = df[test.indices,]

for(i in c(5,10,20,30,40)){
  decision.tree <- rpart(pct_gpu ~ ite + BR_INS	+ BR_MSP + 	BR_TKN + 	FDV_INS + 	FPO_CYC + 	FP_INS + 	INS_CYC + 	L2_DCM + 	L2_DCR + 	L2_DCW + 	L2_LDM + 	L2_STM + 	L2_TCM + 	L2_TCR + 	L2_TCW + 	L3_DCR + 	L3_DCW + 	L3_TCM + 	L3_TCR + 	L3_TCW + 	LD_INS + 	REF_CYC + 	SR_INS + 	STL_ICY	 + VEC_SP + achieved_occupancy + sysmem_utilization + ldst_fu_utilization + alu_fu_utilization + cf_fu_utilization + issue_slot_utilization + l1_shared_utilization + l2_utilization + dram_utilization + l1_cache_global_hit_rate + branch_efficiency + l1_cache_local_hit_rate + sm_efficiency + ipc + gld_transactions_per_request + gst_transactions_per_request + stall_inst_fetch + stall_exec_dependency + stall_data_request + stall_memory_dependency + stall_sync + stall_other + warp_execution_efficiency + gld_efficiency + gst_efficiency + l2_l1_read_hit_rate + issued_ipc + flop_sp_efficiency + stall_pipe_busy + stall_memory_throttle,method="class", data=df,control=rpart.control(minsplit=5))
  
  predictions = predict(decision.tree,df.test,type="class")
  accuracy = sum(predictions==df.test$pct_gpu)/nrow(df.test)
  print(accuracy)
  
  print(table(predictions,df.test$pct_gpu))
  #confusionMatrix(predictions,df.test,dnn=c("Prediction","Reference"))
  
  rpart.plot(decision.tree,main=paste(c("rpart CPU-GPU minsplit",i," Accuracy ",sprintf("%.2f",accuracy)),collapse=" "),cex = 0.6)
}

#with min-split = 5 => 0.90341
# predictions   0 0.6 0.65 0.7 0.75 0.8   1
# 0           108   0    0   0    0   0   3
# 0.6           0   2    1   0    0   2   0
# 0.65          0   2    6   0    0   0   0
# 0.7           0   0    0   6    1   1   0
# 0.75          0   0    0   0    3   1   0
# 0.8           0   0    0   0    0   5   0
# 1             3   0    0   0    0   0  32


# Now using stratified test set cross-validation
# This command partitions into 13 training and 13 testing data sets
set.seed(100) # This is very important because we want a consistent answer each time
# This actually partitions the data into three test/training sets
df$pct_gpu = factor(df$pct_gpu)
parti = partition.cv(df,nfold = nrow(df))
accuracy.rpart.cpugpu = c()

# Now we are going to loop through each training set and evaluate the accuracy on the corresponding test set
for (i in 1:length(parti[[1]])) {
  # Grab the indices for the training and testing sets
  train.idx = parti[[1]][[i]]$train
  test.idx = parti[[1]][[i]]$test
  # Now we will actually create separate dataframes for training and testing
  train.data = df[train.idx,]
  test.data = df[test.idx,]
  # Now actually create the random forest classifier
  #rf = randomForest(Survived ~ Pclass + Age.imputed + SibSp.imputed + Parch.imputed + Fare.imputed + Embarked.imputed,data=train.data,ntree=5,type='classification')
  
  #rf = randomForest(pct_gpu ~ input + ite + FP_INS + VEC_SP + LD_INS + SR_INS + BR_INS + BR_CN + BR_TKN + BR_MSP + L2_DCM + L2_DCR + L3_TCM + L3_DCR + INS_CYC + STL_ICY + L2_LDM + L2_STM,data=train.data,ntree=100,type='classification',proximity=TRUE)
  #predictions.rf = predict(rf,test.data,type='class')
  #accuracy.rf[i] = sum(test.data$pct_gpu == predictions.rf)/length(predictions.rf)
  
  #decision.tree = rpart(Survived ~ Pclass + Age.imputed + SibSp.imputed + Parch.imputed + Fare.imputed + Embarked.imputed, data=train.data, method='class')
  
  # Now make the predictions and then calculate the accuracy
  #predictions = predict(rf,test.data,type='class')
  
  #cpu.decision.tree = rpart(pct_gpu ~ input + ite + FP_INS + VEC_SP + LD_INS + SR_INS + BR_INS + BR_CN + BR_TKN + BR_MSP + L2_DCM + L2_DCR + L3_TCM + L3_DCR + INS_CYC + STL_ICY + L2_LDM + L2_STM,data=train.data, method='class')
  #predictions.rpart = predict(cpu.decision.tree,test.data,type='class')
  #accuracy.rpart[i] = sum(test.data$pct_gpu == predictions.rpart)/length(predictions.rpart)
  
  #cpu.gpu.decision.tree = rpart(pct_gpu ~ ite + BR_INS	+ BR_MSP + 	BR_TKN + 	FDV_INS + 	FPO_CYC + 	FP_INS + 	INS_CYC + 	L2_DCM + 	L2_DCR + 	L2_DCW + 	L2_LDM + 	L2_STM + 	L2_TCM + 	L2_TCR + 	L2_TCW + 	L3_DCR + 	L3_DCW + 	L3_TCM + 	L3_TCR + 	L3_TCW + 	LD_INS + 	REF_CYC + 	SR_INS + 	STL_ICY	 + VEC_SP + achieved_occupancy + sysmem_utilization + ldst_fu_utilization + alu_fu_utilization + cf_fu_utilization + issue_slot_utilization + l1_shared_utilization + l2_utilization + dram_utilization + l1_cache_global_hit_rate + branch_efficiency + l1_cache_local_hit_rate + sm_efficiency + ipc + gld_transactions_per_request + gst_transactions_per_request + stall_inst_fetch + stall_exec_dependency + stall_data_request + stall_memory_dependency + stall_sync + stall_other + warp_execution_efficiency + gld_efficiency + gst_efficiency + l2_l1_read_hit_rate + issued_ipc + flop_sp_efficiency + stall_pipe_busy + stall_memory_throttle,data=prof, method='class',control=rpart.control(minsplit=10))
  
  predictions.rpart.cpugpu = predict(fit,test.data,type='class')
  accuracy.rpart.cpugpu[i] = sum(test.data$pct_gpu == predictions.rpart.cpugpu)/length(predictions.rpart.cpugpu)
  #print(table(predictions.rpart.cpugpu,test.data$pct_gpu))
  
  #gpu.decision.tree = rpart(pct_gpu ~ input + ite + achieved_occupancy + sysmem_utilization + ldst_fu_utilization + alu_fu_utilization + cf_fu_utilization + issue_slot_utilization + l1_shared_utilization + l2_utilization + dram_utilization + l1_cache_global_hit_rate + branch_efficiency + l1_cache_local_hit_rate + sm_efficiency + ipc + gld_transactions_per_request + gst_transactions_per_request + stall_inst_fetch + stall_exec_dependency + stall_data_request + stall_memory_dependency + stall_sync + stall_other + warp_execution_efficiency + gld_efficiency + gst_efficiency + l2_l1_read_hit_rate + issued_ipc + flop_sp_efficiency + stall_pipe_busy + stall_memory_throttle,data=prof, method='class')
  
  #predictions.rpart.gpu = predict(gpu.decision.tree,test.data,type='class')
  #accuracy.rpart.gpu[i] = sum(test.data$pct_gpu == predictions.rpart.gpu)/length(predictions.rpart.gpu)
  
}

print(mean(accuracy.rpart.cpugpu))

#with min-split = 5
# [1] 0.883 0.888 0.928
# mean = 0.9Ll2

#print(mean(accuracy.rpart))
#print(mean(accuracy.rpart.gpu))
#print(mean(accuracy.rf))

set.seed(100)
rf<-randomForest(y=factor(df$pct_gpu),x=df[,c("ite","BR_INS","BR_MSP","BR_TKN","FPO_CYC","FP_INS","INS_CYC","L2_DCM","L2_DCR","L2_LDM","L2_STM","L3_DCR","L3_TCM","LD_INS","REF_CYC","SR_INS","STL_ICY","PAPI_TOT_INS_ELEMENT","PAPI_SR_INS_ELEMENT","PAPI_LD_INS_ELEMENT","PAPI_BR_INS_ELEMENT","PAPI_FP_INS_ELEMENT","achieved_occupancy","alu_fu_utilization","branch_efficiency","cf_fu_utilization","dram_utilization","gld_efficiency","gld_transactions_per_request","gst_efficiency","gst_transactions_per_request","inst_per_warp","ipc","issue_slot_utilization","issued_ipc","l1_cache_global_hit_rate","l1_cache_local_hit_rate","l1_shared_utilization","l2_l1_read_hit_rate","l2_utilization","ldst_fu_utilization","sm_efficiency","stall_data_request","stall_exec_dependency","stall_inst_fetch","stall_sync","stall_other","warp_execution_efficiency","GPU_LDST_EXECUTED_ELEMENT","GPU_L2_WRITE_TRANSACTIONS_ELEMENT","GPU_L2_READ_TRANSACTIONS_ELEMENT","GPU_INST_EXECUTED_ELEMENT","GPU_DRAM_WRITE_TRANSACTIONS_ELEMENT","GPU_DRAM_READ_TRANSACTIONS_ELEMENT","GPU_CF_EXECUTED_ELEMENT","GPU_CF_ISSUED_ELEMENT","GPU_FLOPS_SP_ADD_ELEMENT","GPU_FLOPS_SP_SPECIAL_ELEMENT","GPU_FLOPS_SP_MUL_ELEMENT","GPU_FLOPS_SP_ELEMENT")],data=df,ntree=100,type="classification")


predictions.rf = predict(rf,apps.float[,c("ite","BR_INS","BR_MSP","BR_TKN","FPO_CYC","FP_INS","INS_CYC","L2_DCM","L2_DCR","L2_LDM","L2_STM","L3_DCR","L3_TCM","LD_INS","REF_CYC","SR_INS","STL_ICY","PAPI_TOT_INS_ELEMENT","PAPI_SR_INS_ELEMENT","PAPI_LD_INS_ELEMENT","PAPI_BR_INS_ELEMENT","PAPI_FP_INS_ELEMENT","achieved_occupancy","alu_fu_utilization","branch_efficiency","cf_fu_utilization","dram_utilization","gld_efficiency","gld_transactions_per_request","gst_efficiency","gst_transactions_per_request","inst_per_warp","ipc","issue_slot_utilization","issued_ipc","l1_cache_global_hit_rate","l1_cache_local_hit_rate","l1_shared_utilization","l2_l1_read_hit_rate","l2_utilization","ldst_fu_utilization","sm_efficiency","stall_data_request","stall_exec_dependency","stall_inst_fetch","stall_sync","stall_other","warp_execution_efficiency","GPU_LDST_EXECUTED_ELEMENT","GPU_L2_WRITE_TRANSACTIONS_ELEMENT","GPU_L2_READ_TRANSACTIONS_ELEMENT","GPU_INST_EXECUTED_ELEMENT","GPU_DRAM_WRITE_TRANSACTIONS_ELEMENT","GPU_DRAM_READ_TRANSACTIONS_ELEMENT","GPU_CF_EXECUTED_ELEMENT","GPU_CF_ISSUED_ELEMENT","GPU_FLOPS_SP_ADD_ELEMENT","GPU_FLOPS_SP_SPECIAL_ELEMENT","GPU_FLOPS_SP_MUL_ELEMENT","GPU_FLOPS_SP_ELEMENT")],type="class")
accuracy.global.rf = sum(predictions.rf == apps.float$pct_gpu)/nrow(apps.float)
print(accuracy.global.rf)
#0.52

###########################################################################################
# Plot GPU Caches relation

plot(df$l1_cache_global_hit_rate,df$l2_l1_read_hit_rate, main="GPU Caches", 
     ylab="L2_L1_READ_HIT_RATE ", xlab="L1_CACHE_GLOBAL_HIT_RATE", xlim=c(50,100),ylim=c(40,100),col=ifelse(df$input==8192,"blue",ifelse(df$input==4096,"red",ifelse(df$input==2048,"yellow",ifelse(df$input==1024,"green",ifelse(df$input==512,"orange",ifelse(df$input==256,"brown","pink")))))))
legend("topleft", pch=c(1:7), col=c("blue", "red","yellow","green","orange","brown","pink"), legend=c(8192,4096,2048,1024,512,256,128), bty="o", cex=.8, box.col="darkgreen")
reg<-lm(df$l2_l1_read_hit_rate~df$l1_cache_global_hit_rate, data=df)
abline(reg)

plot(df$l1_cache_global_hit_rate,df$l2_l1_read_hit_rate, main="GPU Caches", 
     ylab="L2_L1_READ_HIT_RATE ", xlab="L1_CACHE_GLOBAL_HIT_RATE", xlim=c(50,100),ylim=c(40,100),col=ifelse(df$pct_gpu==1,"blue",ifelse(df$pct_gpu==0.8,"red",ifelse(df$pct_gpu==0.75,"yellow",ifelse(df$pct_gpu==0.7,"green",ifelse(df$pct_gpu==0.65,"orange",ifelse(df$pct_gpu==0.6,"brown","pink")))))))
legend("topleft", pch=c(1:7), col=c("blue", "red","yellow","green","orange","brown","pink"), legend=c(1,0.8,0.75,0.7,0.65,0.6,0), bty="o", cex=.8, box.col="darkgreen")
rega<-lm(df$l2_l1_read_hit_rate~df$l1_cache_global_hit_rate, data=df)
abline(rega)



# Plot CPU Caches relation

#input
plot(df$L2_LDM,df$L2_STM, main="CPU L2 Caches", pch=c(1:1),
     xlab="L2_LDM", ylab="L2_STM ", xlim=c(50,80),ylim=c(25,50),col=ifelse(df$input==8192,"blue",ifelse(df$input==4096,"red",ifelse(df$input==2048,"yellow",ifelse(df$input==1024,"green",ifelse(df$input==512,"orange",ifelse(df$input==256,"brown","pink")))))))
legend("topright", pch=c(1:1), col=c("blue", "red","yellow","green","orange","brown","pink"), legend=c(8192,4096,2048,1024,512,256,128), bty="o", cex=.8, box.col="darkgreen")
reg1<-lm(df$L2_STM~df$L2_LDM, data=df)
abline(reg1)

#class
plot(df$L2_LDM,df$L2_STM, main="CPU L2 Caches", pch=c(1:1),
     xlab="L2_LDM", ylab="L2_STM ", xlim=c(50,80),ylim=c(25,50),col=ifelse(df$input==1,"blue",ifelse(df$pct_gpu==0.8,"red",ifelse(df$pct_gpu==0.75,"yellow",ifelse(df$pct_gpu==0.7,"green",ifelse(df$pct_gpu==0.65,"orange",ifelse(df$pct_gpu==0.6,"brown","pink")))))))
legend("topright", pch=c(1:1), col=c("blue", "red","yellow","green","orange","brown","pink"), legend=c(1,0.8,0.75,0.7,0.65,0.6,0), bty="o", cex=.8, box.col="darkgreen")
reg1a<-lm(df$L2_STM~df$L2_LDM, data=df)
abline(reg1a)

#input
plot(df$L2_LDM,df$L2_DCM, main="CPU L2 Caches", pch=c(1:1),
     xlab="L2_LDM", ylab="L2_DCM ", xlim=c(50,80),ylim=c(0,100),col=ifelse(df$input==8192,"blue",ifelse(df$input==4096,"red",ifelse(df$input==2048,"yellow",ifelse(df$input==1024,"green",ifelse(df$input==512,"orange",ifelse(df$input==256,"brown","pink")))))))
legend("topright", pch=c(1:1), col=c("blue", "red","yellow","green","orange","brown","pink"), legend=c(8192,4096,2048,1024,512,256,128), bty="o", cex=.8, box.col="darkgreen")
reg2<-lm(df$L2_DCM~df$L2_LDM, data=df)
abline(reg2)

#class
plot(df$L2_LDM,df$L2_DCM, main="CPU L2 Caches", pch=c(1:1),
     xlab="L2_LDM", ylab="L2_DCM ", xlim=c(50,80),ylim=c(0,100),col=ifelse(df$input==1,"blue",ifelse(df$pct_gpu==0.8,"red",ifelse(df$pct_gpu==0.75,"yellow",ifelse(df$pct_gpu==0.7,"green",ifelse(df$pct_gpu==0.65,"orange",ifelse(df$pct_gpu==0.6,"brown","pink")))))))
legend("topright", pch=c(1:1), col=c("blue", "red","yellow","green","orange","brown","pink"), legend=c(1,0.8,0.75,0.7,0.65,0.6,0), bty="o", cex=.8, box.col="darkgreen")
reg2a<-lm(df$L2_DCM~df$L2_LDM, data=df)
abline(reg2a)

#input
plot(df$L2_STM,df$L2_DCM, main="CPU L2 Caches", pch=c(1:1),
     xlab="L2_STM", ylab="L2_DCM ", xlim=c(25,55),ylim=c(0,90),col=ifelse(df$input==8192,"blue",ifelse(df$input==4096,"red",ifelse(df$input==2048,"yellow",ifelse(df$input==1024,"green",ifelse(df$input==512,"orange",ifelse(df$input==256,"brown","pink")))))))
legend("topright", pch=c(1:1), col=c("blue", "red","yellow","green","orange","brown","pink"), legend=c(8192,4096,2048,1024,512,256,128), bty="o", cex=.8, box.col="darkgreen")
reg3<-lm(df$L2_DCM~df$L2_STM, data=df)
abline(reg3)

#class
plot(df$L2_STM,df$L2_DCM, main="CPU L2 Caches", pch=c(1:1),
     xlab="L2_STM", ylab="L2_DCM ", xlim=c(25,55),ylim=c(0,90),col=ifelse(df$input==1,"blue",ifelse(df$pct_gpu==0.8,"red",ifelse(df$pct_gpu==0.75,"yellow",ifelse(df$pct_gpu==0.7,"green",ifelse(df$pct_gpu==0.65,"orange",ifelse(df$pct_gpu==0.6,"brown","pink")))))))
legend("topright", pch=c(1:1), col=c("blue", "red","yellow","green","orange","brown","pink"), legend=c(1,0.8,0.75,0.7,0.65,0.6,0), bty="o", cex=.8, box.col="darkgreen")
reg3a<-lm(df$L2_DCM~df$L2_STM, data=df)
abline(reg3a)

#input
plot(df$L3_TCM,df$BR_INS, main="CPU L3 e Branch", pch=c(1:1),
     xlab="L3_TCM", ylab="BR_INS ", xlim=c(-10,100),ylim=c(15,30),col=ifelse(df$input==8192,"blue",ifelse(df$input==4096,"red",ifelse(df$input==2048,"yellow",ifelse(df$input==1024,"green",ifelse(df$input==512,"orange",ifelse(df$input==256,"brown","pink")))))))
legend("topleft", pch=c(1:1), col=c("blue", "red","yellow","green","orange","brown","pink"), legend=c(8192,4096,2048,1024,512,256,128), bty="o", cex=.8, box.col="darkgreen")
reg4<-lm(df$BR_INS~df$L3_TCM, data=df)
abline(reg4)

#class
plot(df$L3_TCM,df$BR_INS, main="CPU L3 e Branch", pch=c(1:1),
     xlab="L3_TCM", ylab="BR_INS ", xlim=c(-10,100),ylim=c(15,30),col=ifelse(df$input==1,"blue",ifelse(df$pct_gpu==0.8,"red",ifelse(df$pct_gpu==0.75,"yellow",ifelse(df$pct_gpu==0.7,"green",ifelse(df$pct_gpu==0.65,"orange",ifelse(df$pct_gpu==0.6,"brown","pink")))))))
legend("topleft", pch=c(1:1), col=c("blue", "red","yellow","green","orange","brown","pink"), legend=c(1,0.8,0.75,0.7,0.65,0.6,0), bty="o", cex=.8, box.col="darkgreen")
reg4a<-lm(df$BR_INS~df$L3_TCM, data=df)
abline(reg4a)

#input
plot(df$L3_TCM,df$sm_efficiency, main="CPU L3 e SM Efficiency", pch=c(1:1),
     ylab="sm_efficiency", xlab="L3_TCM ", xlim=c(0,100),ylim=c(80,100),col=ifelse(df$input==8192,"blue",ifelse(df$input==4096,"red",ifelse(df$input==2048,"yellow",ifelse(df$input==1024,"green",ifelse(df$input==512,"orange",ifelse(df$input==256,"brown","pink")))))))
legend("bottomright", pch=c(1:1), col=c("blue", "red","yellow","green","orange","brown","pink"), legend=c(8192,4096,2048,1024,512,256,128), bty="o", cex=.8, box.col="darkgreen")
reg5<-lm(df$sm_efficiency~df$L3_TCM, data=df)
abline(reg5)

#class
plot(df$L3_TCM,df$sm_efficiency, main="CPU L3 e SM Efficiency", pch=c(1:1),
     ylab="sm_efficiency", xlab="L3_TCM ", xlim=c(0,100),ylim=c(80,100),col=ifelse(df$input==1,"blue",ifelse(df$pct_gpu==0.8,"red",ifelse(df$pct_gpu==0.75,"yellow",ifelse(df$pct_gpu==0.7,"green",ifelse(df$pct_gpu==0.65,"orange",ifelse(df$pct_gpu==0.6,"brown","pink")))))))
legend("bottomright", pch=c(1:1), col=c("blue", "red","yellow","green","orange","brown","pink"), legend=c(1,0.8,0.75,0.7,0.65,0.6,0), bty="o", cex=.8, box.col="darkgreen")
reg5a<-lm(df$sm_efficiency~df$L3_TCM, data=df)
abline(reg5a)

#input
plot(df$L3_TCM,df$ite, main="CPU L3 e Iteracoes", pch=c(1:1),
     xlab="L3_TCM ", ylab="Iteracoes", xlim=c(-10,100),ylim=c(0,70),col=ifelse(df$input==8192,"blue",ifelse(df$input==4096,"red",ifelse(df$input==2048,"yellow",ifelse(df$input==1024,"green",ifelse(df$input==512,"orange",ifelse(df$input==256,"brown","pink")))))))
legend("topleft", pch=c(1:1), col=c("blue", "red","yellow","green","orange","brown","pink"), legend=c(8192,4096,2048,1024,512,256,128), bty="o", cex=.8, box.col="darkgreen")
reg6<-lm(df$ite~df$L3_TCM, data=df)
abline(reg6)

#class
plot(df$L3_TCM,df$ite, main="CPU L3 e Iteracoes", pch=c(1:1),
     xlab="L3_TCM ", ylab="Iteracoes", xlim=c(-10,100),ylim=c(0,70),col=ifelse(df$input==1,"blue",ifelse(df$pct_gpu==0.8,"red",ifelse(df$pct_gpu==0.75,"yellow",ifelse(df$pct_gpu==0.7,"green",ifelse(df$pct_gpu==0.65,"orange",ifelse(df$pct_gpu==0.6,"brown","pink")))))))
legend("topleft", pch=c(1:1), col=c("blue", "red","yellow","green","orange","brown","pink"), legend=c(1,0.8,0.75,0.7,0.65,0.6,0), bty="o", cex=.8, box.col="darkgreen")
reg6a<-lm(df$ite~df$L3_TCM, data=df)
abline(reg6a)

#input
plot( df$ite,df$sm_efficiency,main="Iteracoes e SM Efficiency", pch=c(1:1),
      xlab="Iteracoes", ylab="sm_efficiency", xlim=c(00,70),ylim=c(80,100),col=ifelse(df$input==8192,"blue",ifelse(df$input==4096,"red",ifelse(df$input==2048,"yellow",ifelse(df$input==1024,"green",ifelse(df$input==512,"orange",ifelse(df$input==256,"brown","pink")))))))
legend("topright", pch=c(1:1), col=c("blue", "red","yellow","green","orange","brown","pink"), legend=c(8192,4096,2048,1024,512,256,128), bty="o", cex=.8, box.col="darkgreen")
reg7<-lm(df$ite~df$sm_efficiency, data=df)
abline(reg7)

#class
plot( df$ite,df$sm_efficiency,main="Iteracoes e SM Efficiency", pch=c(1:1),
      xlab="Iteracoes", ylab="sm_efficiency", xlim=c(00,70),ylim=c(80,100),col=ifelse(df$input==1,"blue",ifelse(df$pct_gpu==0.8,"red",ifelse(df$pct_gpu==0.75,"yellow",ifelse(df$pct_gpu==0.7,"green",ifelse(df$pct_gpu==0.65,"orange",ifelse(df$pct_gpu==0.6,"brown","pink")))))))
legend("topright", pch=c(1:1), col=c("blue", "red","yellow","green","orange","brown","pink"), legend=c(1,0.8,0.75,0.7,0.65,0.6,0), bty="o", cex=.8, box.col="darkgreen")
reg7a<-lm(df$ite~df$sm_efficiency, data=df)
abline(reg7a)

###############################################################################

plot( df$FP_INS,df$L3_TCM,main="L3_TCM e FP_INS", pch=c(1:1),
      xlab="L3_TCM", ylab="FP_INS", xlim=c(0,30),ylim=c(0,100),col=ifelse(df$input==1,"blue",ifelse(df$pct_gpu==0.8,"red",ifelse(df$pct_gpu==0.75,"yellow",ifelse(df$pct_gpu==0.7,"green",ifelse(df$pct_gpu==0.65,"orange",ifelse(df$pct_gpu==0.6,"brown","pink")))))))
legend("topright", pch=c(1:1), col=c("blue", "red","yellow","green","orange","brown","pink"), legend=c(1,0.8,0.75,0.7,0.65,0.6,0), bty="o", cex=.8, box.col="darkgreen")
reg8a<-lm(df$L3_TCM~df$FP_INS, data=df)
abline(reg8a)