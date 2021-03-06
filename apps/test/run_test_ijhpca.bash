#!/bin/bash
CPU_EVENTS="" #"perf stat -e cpu-cycles -e instructions -e branches -e branch-misses -e cache-references -e cache-misses -e LLC-loads -e LLC-load-misses -e cpu-clock"
GPU_EVENTS="nvprof --metrics l1_cache_global_hit_rate,sm_efficiency,achieved_occupancy,ipc,inst_per_warp,inst_executed,warp_execution_efficiency,gld_efficiency,gst_efficiency"
OUTPUT_FLAG=0
OPTIMUS=""
OUTPUT_DIR=""
EXEC=$1
TEST_DIR="./${EXEC}"
BIN_DIR="../../bin"
BIN_ACC_KERNELS="../bin/${EXEC}_acc_kernels"
BIN_ACC_PARALLEL="../bin/${EXEC}_acc_parallel"
BIN_ACC_MULTICORE="../bin/${EXEC}_acc_multicore"
BIN_PSKEL="../bin/${EXEC}_pskel"
BIN_PSKEL_PAPI="${BIN_DIR}/${EXEC}_papi_omp_gcc"
BIN_PSKEL_OMP="${BIN_DIR}/${EXEC}_pskel_omp_gcc"
BIN_PSKEL_TBB="../../bin/${EXEC}_pskel_tbb_icc"
BIN_SHARED="../bin/${EXEC}_pskel_shared"
BIN_PAPI="../bin/${EXEC}_papi"
BIN_ACC_PAPI="../../bin/${EXEC}_acc_papi"

NUMA_CTL='' #"numactl --physcpubind=0-11"
NVPROF="nvprof --metrics all --events all"
######TESTES DE TEMPO###########
#make acc_kernels -C ../apps/${EXEC}
#make acc_parallel -C ../apps/${EXEC}
#make acc_multicore -C ../apps/${EXEC}
#make pskel_omp_gcc -C ../${EXEC}
#make pskel_papi -C ../apps/${EXEC}
#make pskel_shared -C ../apps/${EXEC}
#make papi_tesla_omp_gcc -C ../${EXEC}

OUTPUT_DIR="${TEST_DIR}/"
#mkdir ${OUTPUT_DIR}

#teste profiling GPU a 100%
VERBOSE=0
GPU_PERCENT=0
GPU_BLOCK_X=32
GPU_BLOCK_Y=4
CPU_THREADS=20
ITERATIONS=1
TIME_TILE_SIZE=2
TOAST_FLAG=1
for INPUT_SIZE in 45000
do
	for EXEC in 'gol' 
	do	
	
		BIN_PSKEL="${BIN_DIR}/${EXEC}_pskel"
		BIN_PSKEL_PAPI="${BIN_DIR}/${EXEC}_papi"
		
		OUTPUT_DIR="ijhpca/${EXEC}/prof"

		#${NUMA_CTL} nvprof ${BIN_PSKEL_OMP} ${INPUT_SIZE} ${INPUT_SIZE} 1 ${TIME_TILE_SIZE} 1 ${GPU_BLOCK_X} ${GPU_BLOCK_Y} ${CPU_THREADS} ${VERBOSE} &>> ${OUTPUT_DIR}/${EXEC}_${INPUT_SIZE}_${ITERATIONS}_1_${CPU_THREADS}.txt

		#${NUMA_CTL} ${NVPROF} ${BIN_PSKEL_OMP} ${INPUT_SIZE} ${INPUT_SIZE} 1 ${TIME_TILE_SIZE} 1 ${GPU_BLOCK_X} ${GPU_BLOCK_Y} ${CPU_THREADS} ${VERBOSE} &>> ${OUTPUT_DIR}/${EXEC}_${INPUT_SIZE}_${ITERATIONS}_1_${CPU_THREADS}.txt
	
		#${NUMA_CTL} ${BIN_PSKEL_PAPI} ${INPUT_SIZE} ${INPUT_SIZE} 1 ${TIME_TILE_SIZE} 0 ${GPU_BLOCK_X} ${GPU_BLOCK_Y} ${CPU_THREADS} ${VERBOSE} &>> ${OUTPUT_DIR}/${EXEC}_${INPUT_SIZE}_${ITERATIONS}_1_${CPU_THREADS}.txt
	

		for GPU_PERCENT in 0.5 0.6 0.7 0.8 0.9 1.0
		do	
		OUTPUT_DIR="ijhpca/${EXEC}/time"

		for ITERATIONS in 9000 
		do 
	
		for ITERATION in {1..1..1}
		do
			echo $"Running ${EXEC} with INPUT_SIZE = ${INPUT_SIZE} ITERATIONS = ${ITERATIONS} GPU_PARTITION ${GPU_PERCENT}"
			echo "ITERATION #${ITERATION}"
        	
			#${NUMA_CTL} ${BIN_PSKEL_OMP} ${INPUT_SIZE} ${INPUT_SIZE} ${ITERATIONS} ${TIME_TILE_SIZE} 1 ${GPU_BLOCK_X} ${GPU_BLOCK_Y} ${CPU_THREADS} ${VERBOSE} &>> ${OUTPUT_DIR}/${EXEC}_${INPUT_SIZE}_${ITERATIONS}_1_${CPU_THREADS}_time.txt
			#sleep 1

			${NUMA_CTL} ${BIN_PSKEL} ${INPUT_SIZE} ${INPUT_SIZE} ${ITERATIONS} ${TIME_TILE_SIZE} ${GPU_PERCENT} ${TOAST_FLAG} ${GPU_BLOCK_X} ${GPU_BLOCK_Y} ${CPU_THREADS} ${VERBOSE} &>> ${OUTPUT_DIR}/${EXEC}_${INPUT_SIZE}_${ITERATIONS}_${GPU_PERCENT}_${CPU_THREADS}.txt
			sleep 1

#${BIN_ACC_PAPI} ${INPUT_SIZE} ${INPUT_SIZE} ${ITERATIONS} ${VERBOSE} &>> ${OUTPUT_DIR}/${EXEC}_accpapi_${INPUT_SIZE}_${ITERATIONS}_${CPU_THREADS}.txt
			#sleep 1
		
			#nvprof ${BIN_ACC_KERNELS} ${INPUT_SIZE} ${INPUT_SIZE} ${ITERATIONS} ${VERBOSE} &>> ${OUTPUT_DIR}/${EXEC}_gpuacckernels_${INPUT_SIZE}_${ITERATIONS}_${CPU_THREADS}.txt
			#sleep 1
        
        		#nvprof --events all --metrics all ${BIN_ACC_KERNELS} ${INPUT_SIZE} ${INPUT_SIZE} 2 ${VERBOSE} &>> ${OUTPUT_DIR}/${EXEC}_gpuacckernels_${INPUT_SIZE}_${ITERATIONS}_${CPU_THREADS}.txt
			#sleep 1

			#${BIN_ACC_MULTICORE} ${INPUT_SIZE} ${INPUT_SIZE} 50 ${VERBOSE} &>> ${OUTPUT_DIR}/${EXEC}_acccpu_${INPUT_SIZE}_${ITERATIONS}_12.txt
			#sleep 1

			#nvprof ${BIN_SHARED} ${INPUT_SIZE} ${INPUT_SIZE} ${ITERATIONS} ${TIME_TILE_SIZE} ${GPU_PERCENT} ${GPU_BLOCK_X} ${GPU_BLOCK_Y} ${CPU_THREADS} ${VERBOSE} &>> ${OUTPUT_DIR}/${EXEC}_gpupskelshared_${INPUT_SIZE}_${ITERATIONS}_${CPU_THREADS}.txt
			#sleep 1

			#nvprof --metrics all --events all ${BIN_SHARED} ${INPUT_SIZE} ${INPUT_SIZE} ${TIME_TILE_SIZE} ${TIME_TILE_SIZE} ${GPU_PERCENT} ${GPU_BLOCK_X} ${GPU_BLOCK_Y} ${CPU_THREADS} ${VERBOSE} &>> ${OUTPUT_DIR}/${EXEC}_gpupskelshared_${INPUT_SIZE}_${ITERATIONS}_${CPU_THREADS}.txt
			#sleep 1
		
			#${BIN_PAPI} ${INPUT_SIZE} ${INPUT_SIZE} ${ITERATIONS} ${GPU_PERCENT}  ${GPU_BLOCK_X} ${GPU_BLOCK_Y} ${CPU_THREADS} ${VERBOSE} &>> ${OUTPUT_DIR}/${EXEC}_pskelpapi_${INPUT_SIZE}_${ITERATIONS}_${CPU_THREADS}.txt
			#sleep 1
		
			#Running with 24 theads
			#${BIN_PAPI} ${INPUT_SIZE} ${INPUT_SIZE} ${ITERATIONS} ${GPU_PERCENT}  ${GPU_BLOCK_X} ${GPU_BLOCK_Y} 24 ${VERBOSE} &>> ${OUTPUT_DIR}/${EXEC}_pskelpapi_${INPUT_SIZE}_${ITERATIONS}_24.txt
			#sleep 1

			#${BIN_ACC_PAPI} ${INPUT_SIZE} ${INPUT_SIZE} ${ITERATIONS} ${VERBOSE} &>> ${OUTPUT_DIR}/${EXEC}_accpapi_${INPUT_SIZE}_${ITERATIONS}_${CPU_NUM_THREADS}.txt
			#sleep 1	
		done
		done
		done
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
