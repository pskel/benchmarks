#!/bin/bash
CPU_EVENTS="" #"perf stat -e cpu-cycles -e instructions -e branches -e branch-misses -e cache-references -e cache-misses -e LLC-loads -e LLC-load-misses -e cpu-clock"
GPU_EVENTS="nvprof --metrics l1_cache_global_hit_rate,sm_efficiency,achieved_occupancy,ipc,inst_per_warp,inst_executed,warp_execution_efficiency,gld_efficiency,gst_efficiency"
OUTPUT_FLAG=0
OPTIMUS=""
OUTPUT_DIR=""
EXEC=$1
TEST_DIR="./${EXEC}"
BIN_DIR="../../bin"
#BIN_ACC_KERNELS="../bin/${EXEC}_acc_kernels"
#BIN_ACC_PARALLEL="../bin/${EXEC}_acc_parallel"
#BIN_ACC_MULTICORE="../bin/${EXEC}_acc_multicore"
#BIN_PSKEL="../bin/${EXEC}_pskel"
#BIN_PSKEL_PAPI="${BIN_DIR}/${EXEC}_papi_omp_gcc"
#BIN_PSKEL_OMP="${BIN_DIR}/${EXEC}_pskel_omp_gcc"
#BIN_PSKEL_TBB="../../bin/${EXEC}_pskel_tbb_icc"
#BIN_SHARED="../bin/${EXEC}_pskel_shared"
#BIN_PAPI="../bin/${EXEC}_papi"
#BIN_ACC_PAPI="../../bin/${EXEC}_acc_papi"
BIN_PAPI_MOORE="../../bin/${EXEC}_papi_omp_gcc_moore"
BIN_PAPI_NEUMAN="../../bin/${EXEC}_papi_omp_gcc_neuman"
BIN_PSKEL_MOORE="../../bin/${EXEC}_pskel_omp_gcc_moore"
BIN_PSKEL_NEUMAN="../../bin/${EXEC}_pskel_omp_gcc_neuman"

NUMA_CTL="numactl --physcpubind=0-11"
NVPROF="nvprof --metrics all --events elapsed_cycles_sm,gld_inst_32bit,gst_inst_32bit,warps_launched,threads_launched,inst_issued1,inst_issued2,thread_inst_executed,gld_request,gst_request,active_cycles,active_warps,sm_cta_launched,not_predicated_off_thread_inst_executed,uncached_global_load_transaction,global_store_transaction,__l1_global_load_transactions,__l1_global_store_transactions"
######TESTES DE TEMPO###########
#make acc_kernels -C ../apps/${EXEC}
#make acc_parallel -C ../apps/${EXEC}
#make acc_multicore -C ../apps/${EXEC}
make -C ../${EXEC}
#make pskel_papi -C ../apps/${EXEC}
#make pskel_shared -C ../apps/${EXEC}
#make papi_tesla_omp_gcc -C ../${EXEC}

OUTPUT_DIR="${TEST_DIR}/time5"
#mkdir ${OUTPUT_DIR}

#teste profiling GPU a 100%
VERBOSE=0
GPU_PERCENT=0
GPU_BLOCK_X=16
GPU_BLOCK_Y=16
CPU_THREADS=12
ITERATIONS=50
TIME_TILE_SIZE=2

for ADD in 1
do
	for MULT in 1
	do
	if [[ !("$ADD" = 0 && "$MULT" = 0) ]]
	then
		for INPUT_SIZE in 1024 512 256 128 
		do
			for ITERATIONS in 50 30 10
			do 
				for GPU_PERCENT in 0 1 
				do
					#for MASK_TYPE in 0 1
					#do
						for MASK_RANGE in 1 2 3
						do
							for ITERATION in {1..1..1}
							do
								echo $"Running with INPUT_SIZE = ${INPUT_SIZE}"
								echo "ITERATION #${ITERATION}"
        	
								#${NUMA_CTL} ${BIN_PAPI_MOORE} ${INPUT_SIZE} ${INPUT_SIZE} ${ITERATIONS} 0 ${GPU_BLOCK_X} ${CPU_THREADS} ${MASK_RANGE} ${ADD} ${MULT} ${VERBOSE} &>> ${OUTPUT_DIR}/${EXEC}_${INPUT_SIZE}_${ITERATIONS}_${GPU_PERCENT}_${CPU_THREADS}_1_${MASK_RANGE}_${ADD}_${MULT}.txt
								
								${NUMA_CTL} ${BIN_PSKEL_MOORE}_r${MASK_RANGE}_a${ADD}_m${MULT} ${INPUT_SIZE} ${INPUT_SIZE} ${ITERATIONS} ${GPU_PERCENT} ${GPU_BLOCK_X} ${CPU_THREADS} ${MASK_RANGE} ${ADD} ${MULT} ${VERBOSE} &>> ${OUTPUT_DIR}/${EXEC}_${INPUT_SIZE}_${ITERATIONS}_${GPU_PERCENT}_${CPU_THREADS}_1_${MASK_RANGE}_${ADD}_${MULT}.txt
							
								#${NUMA_CTL} ${BIN_PAPI_NEUMAN} ${INPUT_SIZE} ${INPUT_SIZE} ${ITERATIONS} 0 ${GPU_BLOCK_X} ${CPU_THREADS} ${MASK_RANGE} ${ADD} ${MULT} ${VERBOSE} &>> ${OUTPUT_DIR}/${EXEC}_${INPUT_SIZE}_${ITERATIONS}_${GPU_PERCENT}_${CPU_THREADS}_0_${MASK_RANGE}_${ADD}_${MULT}.txt
								
								${NUMA_CTL} ${BIN_PSKEL_NEUMAN}_r${MASK_RANGE}_a${ADD}_m${MULT} ${INPUT_SIZE} ${INPUT_SIZE} ${ITERATIONS} ${GPU_PERCENT} ${GPU_BLOCK_X} ${CPU_THREADS} ${MASK_RANGE} ${ADD} ${MULT} ${VERBOSE} &>> ${OUTPUT_DIR}/${EXEC}_${INPUT_SIZE}_${ITERATIONS}_${GPU_PERCENT}_${CPU_THREADS}_0_${MASK_RANGE}_${ADD}_${MULT}.txt
								sleep 1
							done
						done
					#done
				done
			done
		done
	fi
	done
done


OUTPUT_DIR="${TEST_DIR}/prof5"
GPU_PERCENT=1
for ADD in 1
do
	for MULT in 1
	do
	if [[ !("$ADD" = 0 && "$MULT" = 0) ]]
	then
		for INPUT_SIZE in 1024 512 256 128 
		do
			for ITERATIONS in 1
			do 
				#for GPU_PERCENT in 0 1 
				#do
					for MASK_TYPE in 0 1
					do
						for MASK_RANGE in 1 2 3
						do
							for ITERATION in {1..1..1}
							do
								echo $"Running with INPUT_SIZE = ${INPUT_SIZE}"
								echo "ITERATION #${ITERATION}"
								
								${NUMA_CTL} ${BIN_PAPI_MOORE}_r${MASK_RANGE}_a${ADD}_m${MULT} ${INPUT_SIZE} ${INPUT_SIZE} ${ITERATIONS} 0 ${GPU_BLOCK_X} ${CPU_THREADS} ${MASK_RANGE} ${ADD} ${MULT} ${VERBOSE} &>> ${OUTPUT_DIR}/${EXEC}_${INPUT_SIZE}_${ITERATIONS}_${GPU_PERCENT}_${CPU_THREADS}_1_${MASK_RANGE}_${ADD}_${MULT}.txt
							
								${NUMA_CTL} ${NVPROF} ${BIN_PSKEL_MOORE}_r${MASK_RANGE}_a${ADD}_m${MULT} ${INPUT_SIZE} ${INPUT_SIZE} ${ITERATIONS} 1 ${GPU_BLOCK_X} ${CPU_THREADS} ${MASK_RANGE} ${ADD} ${MULT} ${VERBOSE} &>> ${OUTPUT_DIR}/${EXEC}_${INPUT_SIZE}_${ITERATIONS}_${GPU_PERCENT}_${CPU_THREADS}_1_${MASK_RANGE}_${ADD}_${MULT}.txt
								
								${NUMA_CTL} ${BIN_PAPI_NEUMAN}_r${MASK_RANGE}_a${ADD}_m${MULT} ${INPUT_SIZE} ${INPUT_SIZE} ${ITERATIONS} 0 ${GPU_BLOCK_X} ${CPU_THREADS} ${MASK_RANGE} ${ADD} ${MULT} ${VERBOSE} &>> ${OUTPUT_DIR}/${EXEC}_${INPUT_SIZE}_${ITERATIONS}_${GPU_PERCENT}_${CPU_THREADS}_0_${MASK_RANGE}_${ADD}_${MULT}.txt
								
								${NUMA_CTL} ${NVPROF} ${BIN_PSKEL_NEUMAN}_r${MASK_RANGE}_a${ADD}_m${MULT} ${INPUT_SIZE} ${INPUT_SIZE} ${ITERATIONS} 1 ${GPU_BLOCK_X} ${CPU_THREADS} ${MASK_RANGE} ${ADD} ${MULT} ${VERBOSE} &>> ${OUTPUT_DIR}/${EXEC}_${INPUT_SIZE}_${ITERATIONS}_${GPU_PERCENT}_${CPU_THREADS}_0_${MASK_RANGE}_${ADD}_${MULT}.txt
							sleep 1
							done
						done
					done
				#done
			done
		done
	fi
	done
done

#GPU_PERCENT=0
#INPUT_SIZE=4096
#ITERATIONS=10

#for CPU_THREADS_SIZE in 1 2 3 4 5 6 7 8 9 10 11 12
#do
#        for ITERATION in {1..3..1}
#        do
#                echo $"Running with INPUT_SIZE = ${INPUT_SIZE}"
#                echo "ITERATION #${ITERATION}"

#                OMP_NUM_THREADS=${CPU_THREADS} ${BIN_ACC_MULTICORE} ${INPUT_SIZE} ${INPUT_SIZE} ${ITERATIONS} ${VERBOSE} &>> ${OUTPUT_DIR}/${EXEC}_multicore_${INPUT_SIZE}_${ITERATIONS}_${CPU_THREADS}.txt
#                sleep 1

#                ${BIN_PSKEL} ${INPUT_SIZE} ${INPUT_SIZE} ${ITERATIONS} ${GPU_PERCENT} ${GPU_BLOCK_X} ${GPU_BLOCK_Y} ${CPU_THREADS} ${VERBOSE} &>> ${OUTPUT_DIR}/${EXEC}_pskelcpu_${INPUT_SIZE}_${ITERATIONS}_${CPU_THREADS}.txt
#                sleep 1     
#    
#        done
#done


#teste com uma variacao de gpu de 0.1 a 0.9 e max threads
#CPU_THREADS=8
#for BLOCK_SIZE in 8 16 32
#do
	#for GPU_PERCENT in 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9
	#do
		#for ITERATION in {1..10..1}
		#do
			#echo $"Running with GPU_PERCENT=${GPU_PERCENT} BLOCK_SIZE=${BLOCK_SIZE} CPU_THREADS=${CPU_THREADS} ITERATION #${ITERATION}"
			
			#echo "ITERATION #${ITERATION}" >> ${OUTPUT_DIR}/${EXEC}_${IMG1_SIZE}_${ITERATIONS}_${GPU_PERCENT}_${BLOCK_SIZE}_${CPU_THREADS}.txt
			#time -p ${OPTIMUS} ${CPU_EVENTS} ${GPU_EVENTS} ${BIN} ${IMG1_DIR} ${ITERATIONS} $GPU_PERCENT $BLOCK_SIZE $CPU_THREADS ${OUTPUT_FLAG} 2>> ${OUTPUT_DIR}/${EXEC}_${IMG1_SIZE}_${ITERATIONS}_${GPU_PERCENT}_${BLOCK_SIZE}_${CPU_THREADS}.txt
			#sleep 1
			
			#echo "ITERATION #${ITERATION}" >> ${OUTPUT_DIR}/${EXEC}_${IMG2_SIZE}_${ITERATIONS}_${GPU_PERCENT}_${BLOCK_SIZE}_${CPU_THREADS}.txt
			#time -p ${OPTIMUS} ${CPU_EVENTS} ${GPU_EVENTS} ${BIN} ${IMG2_DIR} ${ITERATIONS} $GPU_PERCENT $BLOCK_SIZE $CPU_THREADS ${OUTPUT_FLAG} 2>> ${OUTPUT_DIR}/${EXEC}_${IMG2_SIZE}_${ITERATIONS}_${GPU_PERCENT}_${BLOCK_SIZE}_${CPU_THREADS}.txt
			#sleep 1

			#echo "ITERATION #${ITERATION}" >> ${OUTPUT_DIR}/${EXEC}_${IMG3_SIZE}_${ITERATIONS}_${GPU_PERCENT}_${BLOCK_SIZE}_${CPU_THREADS}.txt
			#time -p ${OPTIMUS} ${CPU_EVENTS} ${GPU_EVENTS} ${BIN} ${IMG3_DIR} ${ITERATIONS} $GPU_PERCENT $BLOCK_SIZE $CPU_THREADS ${OUTPUT_FLAG} 2>> ${OUTPUT_DIR}/${EXEC}_${IMG3_SIZE}_${ITERATIONS}_${GPU_PERCENT}_${BLOCK_SIZE}_${CPU_THREADS}.txt
			#sleep 1
		#done
	#done
#done

#teste CPU sequencial e max threads
#GPU_EVENTS=""
#GPU_PERCENT=0
#BLOCK_SIZE=0
#for CPU_THREADS in 1 8
#do
#	for ITERATION in {1..10..1}
#	do
#		echo $"Running with GPU_PERCENT=${GPU_PERCENT} BLOCK_SIZE=${BLOCK_SIZE} CPU_THREADS=${CPU_THREADS} ITERATION #${ITERATION}"
#		
#		echo "ITERATION #${ITERATION}" >> ${OUTPUT_DIR}/${EXEC}_${IMG1_SIZE}_${ITERATIONS}_${GPU_PERCENT}_${BLOCK_SIZE}_${CPU_THREADS}.txt
#		time -p ${OPTIMUS} ${CPU_EVENTS} ${GPU_EVENTS} ${BIN} ${IMG1_DIR} ${ITERATIONS} $GPU_PERCENT $BLOCK_SIZE $CPU_THREADS ${OUTPUT_FLAG} 2>> ${OUTPUT_DIR}/${EXEC}_${IMG1_SIZE}_${ITERATIONS}_${GPU_PERCENT}_${BLOCK_SIZE}_${CPU_THREADS}.txt
#		sleep 1
#		
#		echo "ITERATION #${ITERATION}" >> ${OUTPUT_DIR}/${EXEC}_${IMG2_SIZE}_${ITERATIONS}_${GPU_PERCENT}_${BLOCK_SIZE}_${CPU_THREADS}.txt
#		time -p ${OPTIMUS} ${CPU_EVENTS} ${GPU_EVENTS} ${BIN} ${IMG2_DIR} ${ITERATIONS} $GPU_PERCENT $BLOCK_SIZE $CPU_THREADS ${OUTPUT_FLAG} 2>> ${OUTPUT_DIR}/${EXEC}_${IMG2_SIZE}_${ITERATIONS}_${GPU_PERCENT}_${BLOCK_SIZE}_${CPU_THREADS}.txt
#		sleep 1
#
#		echo "ITERATION #${ITERATION}" >> ${OUTPUT_DIR}/${EXEC}_${IMG3_SIZE}_${ITERATIONS}_${GPU_PERCENT}_${BLOCK_SIZE}_${CPU_THREADS}.txt
#		time -p ${OPTIMUS} ${CPU_EVENTS} ${GPU_EVENTS} ${BIN} ${IMG3_DIR} ${ITERATIONS} $GPU_PERCENT $BLOCK_SIZE $CPU_THREADS ${OUTPUT_FLAG} 2>> ${OUTPUT_DIR}/${EXEC}_${IMG3_SIZE}_${ITERATIONS}_${GPU_PERCENT}_${BLOCK_SIZE}_${CPU_THREADS}.txt
#		sleep 1
#	done
#done
