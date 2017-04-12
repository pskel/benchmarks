# Classification Tree with rpart
library(rpart)
library(rpart.plot)
library(caret)
library(randomForest)
library(sperrorest)
library(party)

library(rattle)					# Fancy tree plot

library(RColorBrewer)		# Color selection for fancy tree plot
library(party)					# Alternative decision tree algorithm
library(partykit)				# Convert rpart object to BinaryTree
library(caret)	

###############################################################################
#PREDICTING REAL APPS

#READ SYNTHETIC FLOAT DATA
options(digits = 2, width = 100)
#df=read.csv("quadro_syn_float_data.csv")
df=read.csv("synthetic4c.csv")
#df=read.csv("synthetic_quadro_predicted.csv")
#df2=read.csv("synthetic2b.csv")
#apps=read.csv("apps_profile.csv")
apps=read.csv("apps_quadro.csv")

#df2 = df2[which(!is.na(df2$pct_oracle)),]

#transform values
df$app = as.character(df$app)
df$pct_gpu = factor(df$pct_gpu)
df$pct_oracle = factor(df$pct_oracle)
df$l2_utilization = factor(df$l2_utilization)

df = df[-which(is.na(df$pct_oracle)),]

#remove 1 iteration instances
df = df[-which((df$ite == 1)),]

df$pct_type = df$pct_oracle

df$pct_type = as.integer(df$pct_type)
df[which(df$pct_oracle != 1 & df$pct_oracle != 0),"pct_type"] = 2
df$pct_type = as.factor(df$pct_type)

#add new metrics
df$PAPI_FP_INS_ELEMENT = df$PAPI_FP_INS/(df$input*df$input)
df$PAPI_BR_INS_ELEMENT = df$PAPI_BR_INS/(df$input*df$input)
df$PAPI_LD_INS_ELEMENT = df$PAPI_LD_INS/(df$input*df$input)
df$PAPI_SR_INS_ELEMENT = df$PAPI_SR_INS/(df$input*df$input)
df$PAPI_TOT_INS_ELEMENT = df$PAPI_TOT_INS/(df$input*df$input)

df$GPU_FLOPS_SP_ELEMENT = df$flops_sp/(df$input*df$input)
df$GPU_FLOPS_SP_ADD_ELEMENT = df$flops_sp_add/(df$input*df$input)
df$GPU_FLOPS_SP_MUL_ELEMENT = df$flops_sp_mul/(df$input*df$input)
df$GPU_FLOPS_SP_SPECIAL_ELEMENT = df$flops_sp_special/(df$input*df$input)
df$GPU_FLOPS_SP_ADD_ELEMENT = df$flops/(df$input*df$input)
df$GPU_CF_ISSUED_ELEMENT = df$cf_issued/(df$input*df$input)
df$GPU_CF_EXECUTED_ELEMENT = df$cf_executed/(df$input*df$input)
df$GPU_DRAM_READ_TRANSACTIONS_ELEMENT = df$dram_read_transactions/(df$input*df$input)
df$GPU_DRAM_WRITE_TRANSACTIONS_ELEMENT = df$dram_write_transactions/(df$input*df$input)
#dram throughtput?
#gld/gst transactions/throughput por elemento?
df$GPU_INST_EXECUTED_ELEMENT = df$inst_executed/(df$input*df$input)
#issue slots?
#cache throughtput?
df$GPU_L2_READ_TRANSACTIONS_ELEMENT = df$l2_read_transactions/(df$input*df$input)
df$GPU_L2_WRITE_TRANSACTIONS_ELEMENT = df$l2_write_transactions/(df$input*df$input)
df$GPU_LDST_EXECUTED_ELEMENT = df$ldst_executed/(df$input*df$input)

#remove non used values
df = df[,c("app", "ite","input","pct_gpu", "Exec_time", "BR_INS","BR_MSP","BR_TKN","FPO_CYC","FP_INS","INS_CYC","L2_DCM","L2_DCR","L2_LDM","L2_STM","L3_DCR","L3_TCM","LD_INS","REF_CYC","SR_INS","STL_ICY","achieved_occupancy","alu_fu_utilization","branch_efficiency","cf_fu_utilization","dram_utilization","gld_efficiency","gld_transactions_per_request","gst_efficiency","gst_transactions_per_request","inst_per_warp","ipc","issue_slot_utilization","issued_ipc","l1_cache_global_hit_rate","l1_cache_local_hit_rate","l1_shared_utilization","l2_l1_read_hit_rate","l2_utilization","ldst_fu_utilization","sm_efficiency","stall_data_request","stall_exec_dependency","stall_inst_fetch","stall_sync","stall_other","warp_execution_efficiency")]

#######################################################################################
#int data nao mostrou melhoria
#READ SYNTHETIC INT DATA
df.int=read.csv("quadro_syn_int_data.csv")

#transform values
df.int$app = as.character(df.int$app)
df.int$pct_gpu = factor(df.int$pct_gpu)

#add new metrics
df.int$PAPI_FP_INS_ELEMENT = df.int$PAPI_FP_INS/(df.int$input*df.int$input)
df.int$PAPI_BR_INS_ELEMENT = df.int$PAPI_BR_INS/(df.int$input*df.int$input)
df.int$PAPI_LD_INS_ELEMENT = df.int$PAPI_LD_INS/(df.int$input*df.int$input)
df.int$PAPI_SR_INS_ELEMENT = df.int$PAPI_SR_INS/(df.int$input*df.int$input)
df.int$PAPI_TOT_INS_ELEMENT = df.int$PAPI_TOT_INS/(df.int$input*df.int$input)

df.int$GPU_FLOPS_SP_ELEMENT = df.int$flops_sp/(df.int$input*df.int$input)
df.int$GPU_FLOPS_SP_ADD_ELEMENT = df.int$flops_sp_add/(df.int$input*df.int$input)
df.int$GPU_FLOPS_SP_MUL_ELEMENT = df.int$flops_sp_mul/(df.int$input*df.int$input)
df.int$GPU_FLOPS_SP_SPECIAL_ELEMENT = df.int$flops_sp_special/(df.int$input*df.int$input)
df.int$GPU_FLOPS_SP_ADD_ELEMENT = df.int$flops/(df.int$input*df.int$input)
df.int$GPU_CF_ISSUED_ELEMENT = df.int$cf_issued/(df.int$input*df.int$input)
df.int$GPU_CF_EXECUTED_ELEMENT = df.int$cf_executed/(df.int$input*df.int$input)
df.int$GPU_DRAM_READ_TRANSACTIONS_ELEMENT = df.int$dram_read_transactions/(df.int$input*df.int$input)
df.int$GPU_DRAM_WRITE_TRANSACTIONS_ELEMENT = df.int$dram_write_transactions/(df.int$input*df.int$input)
#dram throughtput?
#gld/gst transactions/throughput por elemento?
df.int$GPU_INST_EXECUTED_ELEMENT = df.int$inst_executed/(df.int$input*df.int$input)
#issue slots?
#cache throughtput?
df.int$GPU_L2_READ_TRANSACTIONS_ELEMENT = df.int$l2_read_transactions/(df.int$input*df.int$input)
df.int$GPU_L2_WRITE_TRANSACTIONS_ELEMENT = df.int$l2_write_transactions/(df.int$input*df.int$input)
df.int$GPU_LDST_EXECUTED_ELEMENT = df.int$ldst_executed/(df.int$input*df.int$input)

#remove non used values
df.int = df.int[,c("app", "ite","input","pct_gpu", "Exec_time", "BR_INS","BR_MSP","BR_TKN","FPO_CYC","FP_INS","INS_CYC","L2_DCM","L2_DCR","L2_LDM","L2_STM","L3_DCR","L3_TCM","LD_INS","REF_CYC","SR_INS","STL_ICY","PAPI_TOT_INS_ELEMENT","PAPI_SR_INS_ELEMENT","PAPI_LD_INS_ELEMENT","PAPI_BR_INS_ELEMENT","PAPI_FP_INS_ELEMENT","achieved_occupancy","alu_fu_utilization","branch_efficiency","cf_fu_utilization","dram_utilization","gld_efficiency","gld_transactions_per_request","gst_efficiency","gst_transactions_per_request","inst_per_warp","ipc","issue_slot_utilization","issued_ipc","l1_cache_global_hit_rate","l1_cache_local_hit_rate","l1_shared_utilization","l2_l1_read_hit_rate","l2_utilization","ldst_fu_utilization","sm_efficiency","stall_data_request","stall_exec_dependency","stall_inst_fetch","stall_sync","stall_other","warp_execution_efficiency","GPU_LDST_EXECUTED_ELEMENT","GPU_L2_WRITE_TRANSACTIONS_ELEMENT","GPU_L2_READ_TRANSACTIONS_ELEMENT","GPU_INST_EXECUTED_ELEMENT","GPU_DRAM_WRITE_TRANSACTIONS_ELEMENT","GPU_DRAM_READ_TRANSACTIONS_ELEMENT","GPU_CF_EXECUTED_ELEMENT","GPU_CF_ISSUED_ELEMENT","GPU_FLOPS_SP_ADD_ELEMENT","GPU_FLOPS_SP_SPECIAL_ELEMENT","GPU_FLOPS_SP_MUL_ELEMENT","GPU_FLOPS_SP_ELEMENT")]

######################################################################################

#READ AND SET REAL APPS
apps=read.csv("quadro_app_data.csv")
apps.time = read.csv("quadro_app_time.csv")
apps.time = apps.time[,c("app","input","ite","pct_gpu","Exec_time")]

#add new metrics
apps$PAPI_FP_INS_ELEMENT = apps$PAPI_FP_INS/(apps$input*apps$input)
apps$PAPI_BR_INS_ELEMENT = apps$PAPI_BR_INS/(apps$input*apps$input)
apps$PAPI_LD_INS_ELEMENT = apps$PAPI_LD_INS/(apps$input*apps$input)
apps$PAPI_SR_INS_ELEMENT = apps$PAPI_SR_INS/(apps$input*apps$input)
apps$PAPI_TOT_INS_ELEMENT = apps$PAPI_TOT_INS/(apps$input*apps$input)
apps$GPU_FLOPS_SP_ELEMENT = apps$flops_sp/(apps$input*apps$input)
apps$GPU_FLOPS_SP_ADD_ELEMENT = apps$flops_sp_add/(apps$input*apps$input)
apps$GPU_FLOPS_SP_MUL_ELEMENT = apps$flops_sp_mul/(apps$input*apps$input)
apps$GPU_FLOPS_SP_SPECIAL_ELEMENT = apps$flops_sp_special/(apps$input*apps$input)
apps$GPU_FLOPS_SP_FMA_ELEMENT = apps$flops_sp_fma/(apps$input*apps$input)
apps$GPU_CF_ISSUED_ELEMENT = apps$cf_issued/(apps$input*apps$input)
apps$GPU_CF_EXECUTED_ELEMENT = apps$cf_executed/(apps$input*apps$input)
apps$GPU_DRAM_READ_TRANSACTIONS_ELEMENT = apps$dram_read_transactions/(apps$input*apps$input)
apps$GPU_DRAM_WRITE_TRANSACTIONS_ELEMENT = apps$dram_write_transactions/(apps$input*apps$input)
#dram throughtput?
#gld/gst transactions/throughput por elemento?
apps$GPU_INST_EXECUTED_ELEMENT = apps$inst_executed/(apps$input*apps$input)
#issue slots?
#cache throughtput?
apps$GPU_L2_READ_TRANSACTIONS_ELEMENT = apps$l2_read_transactions/(apps$input*apps$input)
apps$GPU_L2_WRITE_TRANSACTIONS_ELEMENT = apps$l2_write_transactions/(apps$input*apps$input)
apps$GPU_LDST_EXECUTED_ELEMENT = apps$ldst_executed/(apps$input*apps$input)

apps = apps[,c("app", "ite","input","pct_gpu", "Exec_time", "BR_INS","BR_MSP","BR_TKN","FPO_CYC","FP_INS","INS_CYC","L2_DCM","L2_DCR","L2_LDM","L2_STM","L3_DCR","L3_TCM","LD_INS","REF_CYC","SR_INS","STL_ICY","achieved_occupancy","alu_fu_utilization","branch_efficiency","cf_fu_utilization","dram_utilization","gld_efficiency","gld_transactions_per_request","gst_efficiency","gst_transactions_per_request","inst_per_warp","ipc","issue_slot_utilization","issued_ipc","l1_cache_global_hit_rate","l1_cache_local_hit_rate","l1_shared_utilization","l2_l1_read_hit_rate","l2_utilization","ldst_fu_utilization","sm_efficiency","stall_data_request","stall_exec_dependency","stall_inst_fetch","stall_sync","stall_other","warp_execution_efficiency")]

apps = apps[which(apps$input==8192),] #receive size 8192
apps = apps[which(apps$ite==1 | apps$ite==60),]

########################################################################################
#FINAL RESULT IS FIT.FLOAT
#fit <- rpart(pct_gpu ~ ite + input + BR_INS	+ BR_MSP + 	BR_TKN + FPO_CYC + 	FP_INS + 	INS_CYC + 	L2_DCM + 	L2_DCR + 	L2_LDM + 	L2_STM + 	L3_DCR + 	L3_TCM + 	LD_INS + 	REF_CYC + 	SR_INS + 	STL_ICY	 + PAPI_TOT_INS_ELEMENT+ PAPI_SR_INS_ELEMENT + PAPI_LD_INS_ELEMENT + PAPI_BR_INS_ELEMENT + PAPI_FP_INS_ELEMENT + achieved_occupancy + alu_fu_utilization + branch_efficiency + cf_fu_utilization + dram_utilization + gld_efficiency + gld_transactions_per_request + gst_efficiency + gst_transactions_per_request + inst_per_warp + ipc + issue_slot_utilization + issued_ipc + l1_cache_global_hit_rate + l1_cache_local_hit_rate + l1_shared_utilization + l2_l1_read_hit_rate + l2_utilization + ldst_fu_utilization + sm_efficiency + stall_data_request + stall_exec_dependency +  stall_inst_fetch + stall_sync + stall_other  + warp_execution_efficiency + GPU_LDST_EXECUTED_ELEMENT + GPU_L2_WRITE_TRANSACTIONS_ELEMENT + GPU_L2_READ_TRANSACTIONS_ELEMENT + GPU_INST_EXECUTED_ELEMENT + GPU_DRAM_WRITE_TRANSACTIONS_ELEMENT + GPU_DRAM_READ_TRANSACTIONS_ELEMENT + GPU_CF_EXECUTED_ELEMENT + GPU_CF_ISSUED_ELEMENT + GPU_FLOPS_SP_ADD_ELEMENT + GPU_FLOPS_SP_SPECIAL_ELEMENT + GPU_FLOPS_SP_MUL_ELEMENT + GPU_FLOPS_SP_ELEMENT,method="class", data=df,control=rpart.control(minsplit=20,minbucket=8))

#fit <- rpart(pct_gpu ~ ite + input + BR_INS	+ BR_MSP + 	BR_TKN + FPO_CYC + 	FP_INS + 	INS_CYC + 	L2_DCM + 	L2_DCR + 	L2_LDM + 	L2_STM + 	L3_DCR + 	L3_TCM + 	LD_INS + 	REF_CYC + 	SR_INS + 	STL_ICY	 + PAPI_TOT_INS_ELEMENT+ PAPI_SR_INS_ELEMENT + PAPI_LD_INS_ELEMENT + PAPI_BR_INS_ELEMENT + PAPI_FP_INS_ELEMENT + achieved_occupancy + alu_fu_utilization + branch_efficiency + cf_fu_utilization + dram_utilization + gld_efficiency + gld_transactions_per_request + gst_efficiency + gst_transactions_per_request + inst_per_warp + ipc + issue_slot_utilization + issued_ipc + l1_cache_global_hit_rate + l1_cache_local_hit_rate + l1_shared_utilization + l2_l1_read_hit_rate + l2_utilization + ldst_fu_utilization + sm_efficiency + stall_data_request + stall_exec_dependency +  stall_inst_fetch + stall_sync + stall_other  + warp_execution_efficiency + GPU_LDST_EXECUTED_ELEMENT + GPU_L2_WRITE_TRANSACTIONS_ELEMENT + GPU_L2_READ_TRANSACTIONS_ELEMENT + GPU_INST_EXECUTED_ELEMENT + GPU_DRAM_WRITE_TRANSACTIONS_ELEMENT + GPU_DRAM_READ_TRANSACTIONS_ELEMENT + GPU_CF_EXECUTED_ELEMENT + GPU_CF_ISSUED_ELEMENT + GPU_FLOPS_SP_ADD_ELEMENT + GPU_FLOPS_SP_SPECIAL_ELEMENT + GPU_FLOPS_SP_MUL_ELEMENT + GPU_FLOPS_SP_ELEMENT,method="class", data=df.int,control=rpart.control(minsplit=5))

#fit1 <- rpart(pct_gpu ~ ite + BR_INS	+ BR_MSP + 	BR_TKN + FP_INS + INS_CYC + L2_DCM + L2_LDM + L2_STM + L3_TCM + LD_INS + SR_INS, method="class", data=df.int,control=rpart.control(minsplit=5))

#fit2 <- rpart(pct_gpu ~ ite + alu_fu_utilization + branch_efficiency + cf_fu_utilization + dram_utilization + gld_efficiency + gld_transactions_per_request + gst_efficiency + gst_transactions_per_request + inst_per_warp + ipc + l1_cache_global_hit_rate + l1_shared_utilization + l2_l1_read_hit_rate + l2_utilization + ldst_fu_utilization + warp_execution_efficiency, method="class", data=df.int,control=rpart.control(minsplit=5))

#fit3 <- rpart(pct_gpu ~ ite + BR_INS	+ BR_MSP + FP_INS + INS_CYC + L2_DCM + L2_LDM + L2_STM + L3_TCM + LD_INS + SR_INS + alu_fu_utilization + branch_efficiency + cf_fu_utilization + dram_utilization + gld_efficiency + gld_transactions_per_request + gst_efficiency + gst_transactions_per_request + inst_per_warp + ipc + l1_cache_global_hit_rate + l1_shared_utilization + l2_l1_read_hit_rate + l2_utilization + ldst_fu_utilization + warp_execution_efficiency, method="class", data=df.int,control=rpart.control(minsplit=5))


########################################################################################################

#GOL

#fit.int <- rpart(pct_gpu ~ ite + BR_INS	+ FP_INS + L2_DCM + L2_DCR + 	L2_LDM + 	L2_STM + 	L3_DCR + 	L3_TCM + 	LD_INS + 	SR_INS + 	achieved_occupancy + alu_fu_utilization + branch_efficiency + cf_fu_utilization + dram_utilization + gld_efficiency + gld_transactions_per_request + gst_efficiency + gst_transactions_per_request + inst_per_warp + ipc + issue_slot_utilization + issued_ipc + l1_cache_global_hit_rate + l1_cache_local_hit_rate + l1_shared_utilization + l2_l1_read_hit_rate + l2_utilization + ldst_fu_utilization + sm_efficiency + warp_execution_efficiency,method="class", data=df.int,control=rpart.control(minsplit=20))

#plot tree
#rpart.plot(fit.int,main=paste("rpart CPU-GPU minsplit fit.int",collapse=" "),cex = 0.6)

#############################################################################################################
#FLOAT APPS

#BR_INS	+ BR_MSP + 	BR_TKN + FPO_CYC + 	FP_INS + 	INS_CYC + 	L2_DCM + 	L2_DCR + 	L2_LDM + 	L2_STM + 	L3_DCR + 	L3_TCM + 	LD_INS + 	REF_CYC + 	SR_INS + 	STL_ICY	 + PAPI_TOT_INS_ELEMENT+ PAPI_SR_INS_ELEMENT + PAPI_LD_INS_ELEMENT + PAPI_BR_INS_ELEMENT + PAPI_FP_INS_ELEMENT + achieved_occupancy + alu_fu_utilization + branch_efficiency + cf_fu_utilization + dram_utilization + gld_efficiency + gld_transactions_per_request + gst_efficiency + gst_transactions_per_request + inst_per_warp + ipc + issue_slot_utilization + issued_ipc + l1_cache_global_hit_rate + l1_cache_local_hit_rate + l1_shared_utilization + l2_l1_read_hit_rate + l2_utilization + ldst_fu_utilization + sm_efficiency + stall_data_request + stall_exec_dependency +  stall_inst_fetch + stall_sync + stall_other  + warp_execution_efficiency + GPU_LDST_EXECUTED_ELEMENT + GPU_L2_WRITE_TRANSACTIONS_ELEMENT + GPU_L2_READ_TRANSACTIONS_ELEMENT + GPU_INST_EXECUTED_ELEMENT + GPU_DRAM_WRITE_TRANSACTIONS_ELEMENT + GPU_DRAM_READ_TRANSACTIONS_ELEMENT + GPU_CF_EXECUTED_ELEMENT + GPU_CF_ISSUED_ELEMENT + GPU_FLOPS_SP_ADD_ELEMENT + GPU_FLOPS_SP_SPECIAL_ELEMENT + GPU_FLOPS_SP_MUL_ELEMENT + GPU_FLOPS_SP_ELEMENT

#df[which(df$sm_efficiency >= 90),'sm_efficiency'] = "high"
#df[which(df$sm_efficiency >= 70 & df$sm_efficiency < 90),'sm_efficiency'] = "medium-high"
#df[which(df$sm_efficiency >= 50 & df$sm_efficiency < 70),'sm_efficiency'] = "medium"
#df[which(df$sm_efficiency >= 30 & df$sm_efficiency < 50),'sm_efficiency'] = "medium-low"
#df[which(df$sm_efficiency >= 0 & df$sm_efficiency < 30),'sm_efficiency'] = "low"
#df$sm_efficiency = as.factor(df$sm_efficiency)


colnames(df)[which(names(df) == "l2_l1_read_hit_rate")] <- "GPU_L2_TCH"
colnames(df)[which(names(df) == "l1_cache_global_hit_rate")] <- "GPU_L1_TCH"
colnames(df)[which(names(df) == "sm_efficiency")] <- "GPU_SME"
colnames(df)[which(names(df) == "ite")] <- "ITERATIONS"
colnames(df)[which(names(df) == "L2_DCM")] <- "CPU_L2_DCM"
colnames(df)[which(names(df) == "L3_TCM")] <- "CPU_L3_TCM"

colnames(apps)[which(names(apps) == "l2_l1_read_hit_rate")] <- "GPU_L2_TCH"
colnames(apps)[which(names(apps) == "l1_cache_global_hit_rate")] <- "GPU_L1_TCH"
colnames(apps)[which(names(apps) == "sm_efficiency")] <- "GPU_SME"
colnames(apps)[which(names(apps) == "ite")] <- "ITERATIONS"
colnames(apps)[which(names(apps) == "L2_DCM")] <- "CPU_L2_DCM"
colnames(apps)[which(names(apps) == "L3_TCM")] <- "CPU_L3_TCM"


df = df[which(df$numAdd==1 & df$numMult==1),]

df2 = df

df = df[,-match(c("flop_count_sp_mul"),names(df))]
#control=rpart.control(minsplit=20,minbucket=8)

#fit <- svm(pct_oracle ~ ., data=df, cost=100, gamma=1)

#remove synthetic loop
df = df[-which(df$pct_oracle==0.95 | df$pct_oracle==0.9),]

###### PREDICTION 1 #########
fitsvm <- svm(pct_type ~ BR_INS	+ ite + FP_INS + L2_DCM + L3_TCM + BR_MSP + l1_shared_utilization + l2_l1_read_hit_rate + l2_utilization + ldst_fu_utilization, data=df, na.action=na.omit)

plot(fitsvm, df,L2_DCM ~ L3_TCM)

fit1 <- rpart(pct_type ~ BR_INS	+ ite + FP_INS + L2_DCM + L3_TCM + BR_MSP + 	achieved_occupancy + alu_fu_utilization + branch_efficiency + cf_fu_utilization + dram_utilization + gld_efficiency + inst_per_warp + ipc + issue_slot_utilization + issued_ipc + l1_shared_utilization + l2_l1_read_hit_rate + l2_utilization + ldst_fu_utilization + stall_data_request + stall_inst_fetch + stall_sync + stall_other,method="class", data=df,control=rpart.control(minsplit=10,minbucket=3))

x <- prp(fit1,type=0,extra=102,digits=4,under=FALSE,faclen=0,varlen=0,split.border.col=1,fallen.leaves = TRUE,leaf.round=1.9,ycompress = TRUE,compress=TRUE,xcompact=FALSE,xcompact.ratio=0.8,ycompact=FALSE,nn=FALSE,split.font=1,branch=1,lt="\n< ",ge="\n>= ",xflip=TRUE,cex=0.6,ycompress.cex=Inf,accept.cex=0,Fallen.yspace=0.05,trace=TRUE,nn.cex=0.7)


predictions = predict(fit1,apps,type="class")
accuracy.global = sum(predictions==apps$pct_gpu)/nrow(apps)
print(accuracy.global)
table(predictions)
table(apps$pct_gpu)
print(table(predictions,apps$pct_gpu))

apps$pct_gpu_p1 = predictions

setEPS()
postscript("prp_tree1.eps")


dev.off()
###########################################

###### PREDICTION 2 #########
fit2 <- rpart(pct_oracle ~ l1_cache_global_hit_rate + ite + L2_DCM + L3_TCM + l2_l1_read_hit_rate,method="class", data=df,control=rpart.control(minsplit=5,minbucket=2))

predictions2 = predict(fit2,apps,type="class")
accuracy.global = sum(predictions2==apps$pct_gpu)/nrow(apps)
print(accuracy.global)
table(predictions2)
table(apps$pct_gpu)
print(table(predictions2,apps$pct_gpu))

apps$pct_gpu_p2 = predictions2

setEPS()
postscript("prp_tree_quadro1.eps")

x <- prp(fit2,type=0,extra=102,digits=4,under=FALSE,faclen=0,varlen=0,split.border.col=1,fallen.leaves = TRUE,leaf.round=1.9,ycompress = TRUE,compress=TRUE,xcompact=FALSE,xcompact.ratio=0.8,ycompact=FALSE,nn=FALSE,split.font=1,branch=1,lt="\n< ",ge="\n>= ",xflip=TRUE,cex=0.6,ycompress.cex=Inf,accept.cex=0,Fallen.yspace=0.05,trace=TRUE,nn.cex=0.7)

dev.off()
###########################################

###### PREDICTION 3 #########
#predict4 = fit3 <- rpart(pct_oracle ~ ite + L2_DCM + L3_TCM + l2_l1_read_hit_rate,method="class", data=df,control=rpart.control(minsplit=5,minbucket=2))

fit3 <- rpart(pct_oracle ~ ITERATIONS + CPU_L2_DCM + CPU_L3_TCM + GPU_L2_TCH,method="class", data=df,control=rpart.control(minsplit=5,minbucket=2))

#prune
pfit<- prune(fit3, cp=fit3$cptable[which.min(fit3$cptable[,"xerror"]),"CP"])

predictions3 = predict(fit3,apps,type="class")
print(predictions3)
setEPS()
postscript("prp_tree5a.eps")


x <- prp(fit3,type=0,extra=102,digits=4,under=FALSE,faclen=0,varlen=0,split.border.col=1,fallen.leaves = TRUE,leaf.round=1.8,ycompress = TRUE,compress=TRUE,xcompact=FALSE,xcompact.ratio=0.5,ycompact=FALSE,nn=FALSE,split.font=0.9,branch=1,lt="\n< ",ge="\n>= ",xflip=TRUE,cex=0.6,ycompress.cex=Inf,accept.cex=0,Fallen.yspace=0.05,trace=TRUE,nn.cex=0.7)

dev.off()

accuracy.global = sum(predictions3==apps$pct_gpu)/nrow(apps)
print(accuracy.global)
table(predictions2)
table(apps$pct_gpu)
print(table(predictions3,apps$pct_gpu))

apps$pct_gpu_p5 = predictions3

dev.off()
###########################################


###### PREDICTION QUADRO #########
#predict4 = fit3 <- rpart(pct_oracle ~ ite + L2_DCM + L3_TCM + l2_l1_read_hit_rate,method="class", data=df,control=rpart.control(minsplit=5,minbucket=2))

df$dram_utilization = as.integer(df$dram_utilization)

#ite + l1_cache_global_hit_rate + BR_INS + FP_INS + L2_DCM + L3_TCM + l2_l1_read_hit_rate +  branch_efficiency + l2_utilization + FP_INS + LD_INS + achieved_occupancy + alu_fu_utilization + ldst_fu_utilization + dram_utilization + l1_shared_utilization + flop_sp_efficiency + sm_efficiency

fit4 <- rpart(pct_oracle ~ ITERATIONS + GPU_L1_TCH + GPU_L2_TCH + CPU_L2_DCM + CPU_L3_TCM ,method="class", data=df,control=rpart.control(minsplit=5,minbucket=3))

#prune
pfit<- prune(fit, cp=fit$cptable[which.min(fit$cptable[,"xerror"]),"CP"])

predictions_fit = predict(pfit,apps,type="class")
predictions_pfit = predict(fit4,apps,type="class")
print(predictions_fit)
print(predictions_pfit)
setEPS()
postscript("prp_tree_quadro2b.eps")

x <- prp(fit,type=0,extra=102,digits=4,under=FALSE,faclen=0,varlen=0,split.border.col=1,fallen.leaves = TRUE,leaf.round=1.8,ycompress = TRUE,compress=TRUE,xcompact=FALSE,xcompact.ratio=0.5,ycompact=FALSE,nn=FALSE,split.font=0.9,branch=1,lt="\n< ",ge="\n>= ",xflip=TRUE,cex=0.6,ycompress.cex=Inf,accept.cex=0,Fallen.yspace=0.05,trace=TRUE,nn.cex=0.7)

#x <- prp(fit4,type=0,extra=102,digits=4,under=FALSE,faclen=0,varlen=0,split.border.col=1,fallen.leaves = TRUE,leaf.round=1.8,ycompress = TRUE,compress=TRUE,xcompact=FALSE,xcompact.ratio=0.5,ycompact=FALSE,nn=FALSE,split.font=0.9,branch=1,lt="\n< ",ge="\n>= ",xflip=TRUE,cex=0.6,ycompress.cex=Inf,accept.cex=0,Fallen.yspace=0.05,trace=TRUE,nn.cex=0.7)

dev.off()

accuracy.global = sum(predictions4==apps$pct_gpu)/nrow(apps)
print(accuracy.global)
table(predictions2)
table(apps$pct_gpu)
print(table(predictions3,apps$pct_gpu))

apps$pct_gpu_p5 = predictions3

dev.off()
###########################################



#create file with predictions
write.csv(apps,file='app_predicted.csv',row.names=F,quote=F)

fit <- rpart(pct_oracle ~ ite + L2_DCM + L3_TCM + l2_l1_read_hit_rate + sm_efficiency,method="class", data=df,control=rpart.control(minsplit=5,minbucket=2))

predictions = predict(fit,apps,type="class")
accuracy.global = sum(predictions==apps$pct_gpu)/nrow(apps)
print(accuracy.global)
table(predictions)
table(apps$pct_gpu)
print(table(predictions,apps$pct_gpu))

fit.float <- rpart(pct_gpu ~ BR_INS	+ ITERATIONS + FP_INS + L2_DCM + L2_DCR + 	CPU_L2_LDM + 	L2_STM + 	L3_DCR + 	CPU_L3_TCM + 	LD_INS + 	SR_INS + 	achieved_occupancy + alu_fu_utilization + branch_efficiency + cf_fu_utilization + dram_utilization + gld_efficiency + gld_transactions_per_request + gst_efficiency + gst_transactions_per_request + inst_per_warp + ipc + issue_slot_utilization + issued_ipc + GPU_L1_TCH + l1_cache_local_hit_rate + l1_shared_utilization + GPU_L2_TCH + l2_utilization + ldst_fu_utilization + GPU_SME + stall_data_request + stall_exec_dependency +  stall_inst_fetch + stall_sync + stall_other  + warp_execution_efficiency,method="class", data=df,control=rpart.control(minsplit=20,minbucket=8))

#plot tree
rpart.plot(fit.float,main=paste("Partitioning decision tree",collapse=" "),cex = 0.6,varlen=30,fallen.leaves = TRUE)

setEPS()
postscript("prp_tree.eps")
#box.col=gray.colors(7,1,1)[fit.float$frame$yval]
x <- prp(fit,type=0,extra=102,digits=4,under=FALSE,faclen=0,varlen=0,split.border.col=1,fallen.leaves = TRUE,leaf.round=1.9,ycompress = TRUE,compress=TRUE,xcompact=FALSE,xcompact.ratio=0.8,ycompact=FALSE,nn=FALSE,split.font=1,branch=1,lt="\n< ",ge="\n>= ",xflip=TRUE,cex=0.6,ycompress.cex=Inf,accept.cex=0,Fallen.yspace=0.05,trace=TRUE,nn.cex=0.7)
dev.off()



prp(fit,type=0,extra=102,digits=4,under=FALSE,faclen=0,varlen=0,split.border.col=0,fallen.leaves = TRUE,leaf.round=1,ycompress = TRUE,compress=TRUE,xcompact=TRUE,xcompact.ratio=0.5,ycompact=FALSE,nn=FALSE,split.font=1,branch=1,tweak=0.95,cex=0.65,branch.tweak=1.1,split.cex=1,xflip=TRUE,left=TRUE,nn.cex=0.7)
#split.cex=1,cex=0.6,compress=TRUE,branch.tweak=1.1)

#try a pretty plot
par(xpd=TRUE,cex.lab=1)
plot(fit.float,uniform=TRUE,compress = FALSE,nspace,margin=1,minbranch=1)
text(fit.float,use.n=FALSE,cex=0.5)

colnames(apps)[which(names(apps) == "l2_l1_read_hit_rate")] <- "GPU_L2_TCH"
colnames(apps)[which(names(apps) == "l1_cache_global_hit_rate")] <- "GPU_L1_TCH"
colnames(apps)[which(names(apps) == "sm_efficiency")] <- "GPU_SME"
colnames(apps)[which(names(apps) == "ITERATIONS")] <- "ite"
colnames(apps)[which(names(apps) == "L2_LDM")] <- "CPU_L2_LDM"
colnames(apps)[which(names(apps) == "L3_TCM")] <- "CPU_L3_TCM"


apps.convolution = apps[c(which(apps$app == 'convolution')),]
predictions.convolution = predict(fit.float,apps.convolution,type="class")
accuracy.convolution = sum(predictions.convolution==apps.convolution$pct_gpu)/nrow(apps.convolution)
print(accuracy.convolution)
table(predictions.convolution)
table(apps.convolution$pct_gpu)
print(table(predictions.convolution,apps.convolution$pct_gpu))

apps.jacobi = apps[c(which(apps$app == 'jacobi')),]
predictions.jacobi = predict(fit.float,apps.jacobi,type="class")
accuracy.jacobi = sum(predictions.jacobi==apps.jacobi$pct_gpu)/nrow(apps.jacobi)
print(accuracy.jacobi)
table(predictions.jacobi)
table(apps.jacobi$pct_gpu)
print(table(predictions.jacobi,apps.jacobi$pct_gpu))

apps.cloudsim = apps[c(which(apps$app == 'cloudsim')),]
predictions.cloudsim = predict(fit.float,apps.cloudsim,type="class")
accuracy.cloudsim = sum(predictions.cloudsim==apps.cloudsim$pct_gpu)/nrow(apps.cloudsim)
print(accuracy.cloudsim)
table(predictions.cloudsim)
table(apps.cloudsim$pct_gpu)
print(table(predictions.cloudsim,apps.cloudsim$pct_gpu))

#predicting int apps with float decision tree is better than using int decision tree
apps.gol = apps[c(which(apps$app == 'gol')),]
predictions.gol = predict(fit.float,apps.gol,type="class")
accuracy.gol = sum(predictions.gol==apps.gol$pct_gpu)/nrow(apps.gol)
print(accuracy.gol)
table(predictions.gol)
table(apps.gol$pct_gpu)
print(table(predictions.gol,apps.gol$pct_gpu))

apps.fast = apps[c(which(apps$app == 'fast')),]
predictions.fast = predict(fit.float,apps.fast,type="class")
accuracy.fast = sum(predictions.fast==apps.fast$pct_gpu)/nrow(apps.fast)
print(accuracy.fast)
table(predictions.fast)
table(apps.fast$pct_gpu)
print(table(predictions.fast,apps.fast$pct_gpu))

#predict all
predictions = predict(fit,apps,type="class")
accuracy.global = sum(predictions==apps$pct_gpu)/nrow(apps)
print(accuracy.global)
table(predictions)
table(apps$pct_gpu)
print(table(predictions,apps$pct_gpu))

############################################################################################################

#Add predicted values to apps table

#apps.time.cloudsim = apps.time[which(apps.time$app == "cloudsim"),]
apps$pct_gpu_predicted = predictions
apps$Exec_time_predicted = as.numeric(0)
apps$Exec_time_cpu = as.numeric(0)
apps$Exec_time_gpu = as.numeric(0)
apps$Exec_time_50 = as.numeric(0)
apps$Exec_time_55 = as.numeric(0)
apps$Exec_time_60 = as.numeric(0)
apps$Exec_time_65 = as.numeric(0)
apps$Exec_time_70 = as.numeric(0)
apps$Exec_time_75 = as.numeric(0)
apps$Exec_time_80 = as.numeric(0)
apps$Exec_time_85 = as.numeric(0)

for (i in 1:nrow(apps)){
  apps$Exec_time_predicted[i] = apps.time[which(apps.time$app == apps[i,]$app & apps.time$input == apps[i,]$input & apps.time$ite == apps[i,]$ite & apps.time$pct_gpu == as.factor(predictions[i])),c("Exec_time")]
  apps$Exec_time_cpu[i] = apps.time[which(apps.time$app == apps[i,]$app & apps.time$input == apps[i,]$input & apps.time$ite == apps[i,]$ite & apps.time$pct_gpu == 0),c("Exec_time")]
  apps$Exec_time_gpu[i] = apps.time[which(apps.time$app == apps[i,]$app & apps.time$input == apps[i,]$input & apps.time$ite == apps[i,]$ite & apps.time$pct_gpu == 1),c("Exec_time")]
  # Partitioning times
  apps$Exec_time_50[i] = apps.time[which(apps.time$app == apps[i,]$app & apps.time$input == apps[i,]$input & apps.time$ite == apps[i,]$ite & apps.time$pct_gpu == 0.5),c("Exec_time")]
  apps$Exec_time_55[i] = apps.time[which(apps.time$app == apps[i,]$app & apps.time$input == apps[i,]$input & apps.time$ite == apps[i,]$ite & apps.time$pct_gpu == 0.55),c("Exec_time")]
  apps$Exec_time_60[i] = apps.time[which(apps.time$app == apps[i,]$app & apps.time$input == apps[i,]$input & apps.time$ite == apps[i,]$ite & apps.time$pct_gpu == 0.6),c("Exec_time")]
  apps$Exec_time_65[i] = apps.time[which(apps.time$app == apps[i,]$app & apps.time$input == apps[i,]$input & apps.time$ite == apps[i,]$ite & apps.time$pct_gpu == 0.65),c("Exec_time")]
  apps$Exec_time_70[i] = apps.time[which(apps.time$app == apps[i,]$app & apps.time$input == apps[i,]$input & apps.time$ite == apps[i,]$ite & apps.time$pct_gpu == 0.7),c("Exec_time")]
  apps$Exec_time_75[i] = apps.time[which(apps.time$app == apps[i,]$app & apps.time$input == apps[i,]$input & apps.time$ite == apps[i,]$ite & apps.time$pct_gpu == 0.75),c("Exec_time")]
  apps$Exec_time_80[i] = apps.time[which(apps.time$app == apps[i,]$app & apps.time$input == apps[i,]$input & apps.time$ite == apps[i,]$ite & apps.time$pct_gpu == 0.8),c("Exec_time")]
  apps$Exec_time_85[i] = apps.time[which(apps.time$app == apps[i,]$app & apps.time$input == apps[i,]$input & apps.time$ite == apps[i,]$ite & apps.time$pct_gpu == 0.85),c("Exec_time")]
}

#insert sequencial time with input 8192
seq.time=read.csv("seq.csv")
apps$Exec_time_seq = as.numeric(0)
for (i in which(apps$input == 8192)){
  apps$Exec_time_seq[i] = seq.time[which(seq.time$app == apps[i,]$app & seq.time$input == apps[i,]$input & seq.time$ite == apps[i,]$ite),c("Exec_time")]
}

speedup.app = apps[which(apps$input == 8192),c("app")]
speedup.ite = apps[which(apps$input == 8192),c("ite")]
speedup.predicted = apps[which(apps$input == 8192),c("Exec_time_seq")]/apps[which(apps$input == 8192),c("Exec_time_predicted")]
speedup.gpu = apps[which(apps$input == 8192),c("Exec_time_seq")]/apps[which(apps$input == 8192),c("Exec_time_gpu")]
speedup.cpu = apps[which(apps$input == 8192),c("Exec_time_seq")]/apps[which(apps$input == 8192),c("Exec_time_cpu")]
speedup.oracle = apps[which(apps$input == 8192),c("Exec_time_seq")]/apps[which(apps$input == 8192),c("Exec_time")]

speedup.50 = apps[which(apps$input == 8192),c("Exec_time_seq")]/apps[which(apps$input == 8192),c("Exec_time_50")]
speedup.55 = apps[which(apps$input == 8192),c("Exec_time_seq")]/apps[which(apps$input == 8192),c("Exec_time_55")]
speedup.60 = apps[which(apps$input == 8192),c("Exec_time_seq")]/apps[which(apps$input == 8192),c("Exec_time_60")]
speedup.65 = apps[which(apps$input == 8192),c("Exec_time_seq")]/apps[which(apps$input == 8192),c("Exec_time_65")]
speedup.70 = apps[which(apps$input == 8192),c("Exec_time_seq")]/apps[which(apps$input == 8192),c("Exec_time_70")]
speedup.75 = apps[which(apps$input == 8192),c("Exec_time_seq")]/apps[which(apps$input == 8192),c("Exec_time_75")]
speedup.80 = apps[which(apps$input == 8192),c("Exec_time_seq")]/apps[which(apps$input == 8192),c("Exec_time_80")]
speedup.85 = apps[which(apps$input == 8192),c("Exec_time_seq")]/apps[which(apps$input == 8192),c("Exec_time_85")]

apps$speedup_predicted = apps$Exec_time_seq/apps$Exec_time_predicted
apps$speedup_oracle = apps$Exec_time_seq/apps$Exec_time
apps$speedup_cpu = apps$Exec_time_seq/apps$Exec_time_cpu
apps$speedup_50 = apps$Exec_time_seq/apps$Exec_time_50
apps$speedup_55 = apps$Exec_time_seq/apps$Exec_time_55
apps$speedup_60 = apps$Exec_time_seq/apps$Exec_time_60
apps$speedup_65 = apps$Exec_time_seq/apps$Exec_time_65
apps$speedup_70 = apps$Exec_time_seq/apps$Exec_time_70
apps$speedup_75 = apps$Exec_time_seq/apps$Exec_time_75
apps$speedup_80 = apps$Exec_time_seq/apps$Exec_time_80
apps$speedup_85 = apps$Exec_time_seq/apps$Exec_time_85
apps$speedup_gpu = apps$Exec_time_seq/apps$Exec_time_gpu

#error medio
mean(abs(apps$Exec_time - apps$Exec_time_50))
mean(abs(apps$Exec_time - apps$Exec_time_55))
mean(abs(apps$Exec_time - apps$Exec_time_60))
mean(abs(apps$Exec_time - apps$Exec_time_65))
mean(abs(apps$Exec_time - apps$Exec_time_70))
mean(abs(apps$Exec_time - apps$Exec_time_75))
mean(abs(apps$Exec_time - apps$Exec_time_80))
mean(abs(apps$Exec_time - apps$Exec_time_85))
mean(abs(apps$Exec_time - apps$Exec_time_cpu))
mean(abs(apps$Exec_time - apps$Exec_time_gpu))

write.csv(apps,file='quadro_app_data_predicted.csv',row.names=F,quote=F)
write.csv(apps[,c("app","input","ite","pct_gpu","pct_gpu_predicted","Exec_time","Exec_time_predicted","Exec_time_seq", "speedup_oracle","speedup_predicted","Exec_time_cpu","Exec_time_50","Exec_time_55","Exec_time_65","Exec_time_70","Exec_time_75","Exec_time_80","Exec_time_85","Exec_time_gpu","speedup_cpu","speedup_50","speedup_55","speedup_60","speedup_65","speedup_70","speedup_75","speedup_80","speedup_85","speedup_gpu")],file='quadro_app_data_predicted_speedup.csv',row.names=F,quote=F)

####################################################################################################
#PLOT BAR GRAPHS
#plot speedup
apps = read.csv('quadro_app_data_predicted_speedup.csv')

par(xpd=TRUE,cex.lab=1.5)
for(j in c("cloudsim","convolution","fast","gol","jacobi")){
#  apps.exec_time = apps[which(apps$app == j),c("input","ite","Exec_time_cpu","Exec_time_gpu","Exec_time_predicted","Exec_time")]
  
  for(i in c(8192)){
    x <- apps[which(apps$input == i & apps$app ==j),c("speedup_cpu")]
    x <- c(x,exp(mean(log(x[-1])))) #geometric mean
    y <- apps[which(apps$input == i & apps$app ==j),c("speedup_gpu")]
    y <- c(y,exp(mean(log(y[-1])))) #geometric mean
    w <- apps[which(apps$input == i & apps$app ==j),c("speedup_predicted")]
    w <- c(w,exp(mean(log(w[-1])))) #geometric mean
    z <- apps[which(apps$input == i & apps$app ==j),c("speedup_oracle")]
    z <- c(z,exp(mean(log(z[-1])))) #geometric mean
    
    # create a two row matrix with x and y
    height <- rbind(x,y,w,z)
    # Use height and set 'beside = TRUE' to get pairs
    # save the bar midpoints in 'mp'
    # Set the bar pair labels to A:D
    #png(paste(c(j,"_",i,".png"),collapse=""))
   setEPS()
   postscript(paste(c(j,"_",i,".eps"),collapse=""))
barplot(height, beside = TRUE,ylim = c(0, 30), names.arg = c(1,10,20,30,40,50,60,"mean"),xlab = "# of iterations",ylab = "Speedup over single core",legend = c("CPU only","GPU only","Predictive model","Oracle"),args.legend = list(x="top",horiz=FALSE,inset=c(0,-0.1),ncol=2,cex=1.5),cex.axis=1.3,cex.names=1.2,cex.lab=1.5,mgp=c(2.8,1,0))
    text(x = xx, y=height[x][], label=round(height[x],1), pos=3, col="black", font=2, cex=1.1)
    dev.off()
  }
}

# plot % variation
for(j in c("gol","jacobi")){
  for(i in c(8192)){
    x1 <- apps[which(apps$input == i & apps$app == j & apps$ite==60),c("speedup_cpu")]
    x2 <- apps[which(apps$input == i & apps$app == j & apps$ite==60),c("speedup_50")]
    x3 <- apps[which(apps$input == i & apps$app == j & apps$ite==60),c("speedup_55")]
    x4 <- apps[which(apps$input == i & apps$app == j & apps$ite==60),c("speedup_60")]
    x5 <- apps[which(apps$input == i & apps$app == j & apps$ite==60),c("speedup_65")]
    x6 <- apps[which(apps$input == i & apps$app == j & apps$ite==60),c("speedup_70")]
    x7 <- apps[which(apps$input == i & apps$app == j & apps$ite==60),c("speedup_75")]
    x8 <- apps[which(apps$input == i & apps$app == j & apps$ite==60),c("speedup_80")]
    x9 <- apps[which(apps$input == i & apps$app == j & apps$ite==60),c("speedup_85")]
    x10 <- apps[which(apps$input == i & apps$app == j & apps$ite==60),c("speedup_gpu")]
    
    height <- c(x1,x2,x3,x4,x5,x6,x7,x8,x9,x10)
    setEPS()
    postscript(paste(c(j,"_",i,"_partition.eps"),collapse=""))
    #names.arg = c(0.0,0.5,0.55,0.6,0.65,0.7,0.75,0.8,0.85,1.0)
    xx <- barplot(height,xlab = "",ylab = "Speedup over single core",ylim = c(0,30),cex.axis=1.1,cex.names=1.5,cex.lab=1.8,mgp=c(2.8,0.5,0),names.arg=FALSE)
    text(x = xx+0.5 , y=-1, label=c("0%","50%","55%","60%","65%","70%","75%","80%","85%","100%"), pos=2,cex=1.5,srt=45,xpd=TRUE)
    dev.off()
  }
}

#plot speedup geomean for all iterations of all aplications
i=8192
apps.geomean = apps[which(apps$input==8192),]
fast.index = which(apps.geomean$app == "fast" & apps.geomean$ite != 1)
conv.index = which(apps.geomean$app == "convolution" & apps.geomean$ite != 1)
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
postscript("geomean_speedup3.eps")
xx <- barplot(height,xlab = "Work partitioning",ylab = "Speedup over single core",ylim = c(0,20),names.arg = FALSE,cex.names=1.5,cex.lab=1.5,cex.axis=1.1,mgp=c(3,1,.1))
text(x = xx, y=height, label=round(height,1), pos=3, col="black", font=2, cex=1.1)
text(x = xx+0.5 , y=-0.7, label=c("0.0",0.5,0.55,0.6,0.65,0.7,0.75,0.8,0.85,"1.0"," \npredictive\nmodel","oracle"), pos=2,cex=1.1,srt=45,xpd=TRUE)
dev.off()

##############################################################################################

> mean(abs(apps$Exec_time - apps$Exec_time_50))
[1] 0.5964739
> mean(abs(apps$Exec_time - apps$Exec_time_55))
[1] 0.6364154
> mean(abs(apps$Exec_time - apps$Exec_time_60))
[1] 0.6883319
> mean(abs(apps$Exec_time - apps$Exec_time_65))
[1] 0.8093116
> mean(abs(apps$Exec_time - apps$Exec_time_70))
[1] 0.9567763
> mean(abs(apps$Exec_time - apps$Exec_time_75))
[1] 1.140817
> mean(abs(apps$Exec_time - apps$Exec_time_80))
[1] 1.337155
> mean(abs(apps$Exec_time - apps$Exec_time_85))
[1] 1.551838
> mean(abs(apps$Exec_time - apps$Exec_time_cpu))
[1] 1.435262
> mean(abs(apps$Exec_time - apps$Exec_time_gpu))
[1] 1.95967

########################################################################################
for(j in c("cloudsim","convolution","fast","gol","jacobi")){
  apps.exec_time = apps[which(apps$app == j),c("input","ite","Exec_time_cpu","Exec_time_gpu","Exec_time_predicted","Exec_time")]
 
  for(i in c(128,256,512,1024,2048,4096,8192)){
    x <- apps.exec_time[which(apps.exec_time$input == i),c("Exec_time_cpu")]
    y <- apps.exec_time[which(apps.exec_time$input == i),c("Exec_time_gpu")]
    w <- apps.exec_time[which(apps.exec_time$input == i),c("Exec_time_predicted")]
    z <- apps.exec_time[which(apps.exec_time$input == i),c("Exec_time")]
    
    # create a two row matrix with x and y
    height <- rbind(x, y,w,z)
    # Use height and set 'beside = TRUE' to get pairs
    # save the bar midpoints in 'mp'
    # Set the bar pair labels to A:D
    png(paste(c(j,"_",i,".png"),collapse=""))
    
    barplot(height, beside = TRUE,ylim = c(0, max(x)+max(x)*0.1), names.arg = c(1,10,20,30,40,50,60),xlab = "# of iterations",ylab = "Execution time (s)",legend = c("CPU_ONLY","GPU_ONLY","Predictive model","Oracle"),args.legend = list(x = "top",cex=0.75),main = paste(c(j," - ",i,"x",i), collapse=" "))
    
    dev.off()
  }
}
####################################################################################################
