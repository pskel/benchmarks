ICC 		= /opt/intel/bin/icpc 
ICC_FLAGS	= -Xcompiler -O3 -Xcompiler -xhost -Xcompiler -openmp -Xcompiler -tbb  -Xcompiler -qopt-report2 -Xcompiler -qopt-report-file:stdout -Xcompiler -qopt-report-phase=vec
GCC 		= /usr/bin/g++ 
GCC_FLAGS	= -Xcompiler -O3 -Xcompiler -fopenmp -Xcompiler -ftree-vectorize -Xcompiler -march=native -Xcompiler -mtune=native -Xcompiler -fopenmp
CUDAC 		= /usr/local/cuda-8.0/bin/nvcc #-ccbin=${CC}
ACC		= /opt/pgi/linux86-64/2016/bin/pgc++
PSKEL_SRC	= python ../pskelccv2.py 
OPTIMUS         = optirun #remover este valor se não estiver em um sistema OPTIMUS (notebook)
CUDA_LIB_PATH   = /usr/local/cuda-5.5/lib64
GENCODE		= -gencode arch=compute_35,code=\"sm_35,compute_35\" -gencode arch=compute_20,code=sm_20 -gencode arch=compute_30,code=sm_30
CUDAFLAGS    	= -O3 ${GENCODE} -m64 -lineinfo #-Xcompiler -ftree-vectorize -Xcompiler -march=native -Xcompiler -mtune=native -Xcompiler -O3
CUDAFLAGS_T    	= -O3 ${GENCODE} -m64 -lineinfo #-Xcompiler -ftree-vectorize -Xcompiler -march=native -Xcompiler -mtune=native -Xcompiler -O3
ACCFLAGS	= -O3 -ta=tesla -tp=sandybridge -Minfo=accel
ACCFLAGS_T	= -O3 -ta=tesla -tp=sandybridge -Minfo=accel
ACCFLAGS_M	= -O3 -ta=multicore -tp=sandybridge -Minfo=accel
CXXFLAGS	= -O3 -w
TBB_SRC_PATH	= /home/alyson/usr/tbb-2017.5/include #/opt/intel/tbb/include
TBB_LIB_PATH	= /home/alyson/usr/tbb-2017.5/lib/intel64/gcc4.7 #/opt/intel/tbb/lib/intel64/gcc4.4
OMP_TBB         = -fopenmp -lgomp -I${TBB_SRC_PATH} -L${TBB_LIB_PATH} -ltbb
GA_LIB_PATH 	= /home/alyson/galib247/ga
GA_SRC_PATH 	= /home/alyson/galib247/
PAPI_LIB_PATH 	= /usr/local/lib
PAPI_SRC_PATH 	= /usr/local/include
HR_TIME		= ../../pskel/include
LIBS		= -I${HR_TIME} -I${GA_SRC_PATH} -L${GA_LIB_PATH} -lm -I${TBB_SRC_PATH} -L${TBB_LIB_PATH} -ltbb -ltbbmalloc -lpapi
ACC_LIBS	= -I${HR_TIME} -lrt -mp 
SRC_NAME        = gol
BIN_DIR         = ../../bin/

all: pskel_omp_gcc

serial: ${SRC_NAME}_serial.cpp
	${CUDAC} ${CUDAFLAGS} -o ${BIN_DIR}${SRC_NAME}_serial ${SRC_NAME}_serial.cpp ${LIBS}

acc_parallel: ${SRC_NAME}_acc_parallel.cpp
	${ACC} ${ACCFLAGS_T} -o  ${BIN_DIR}${SRC_NAME}_acc_parallel ${SRC_NAME}_acc_parallel.cpp ${ACC_LIBS}

acc_papi: ${SRC_NAME}_acc_parallel.cpp
	${ACC} ${ACCFLAGS_M} -o  ${BIN_DIR}${SRC_NAME}_acc_papi ${SRC_NAME}_acc_parallel.cpp ${ACC_LIBS} -I${PAPI_SRC_PATH} -L${PAPI_LIB_PATH} -lpapi -DPSKEL_PAPI -DTESLA
	
acc_multicore: ${SRC_NAME}_acc_kernels.cpp
	${ACC} ${ACCFLAGS_M} -o  ${BIN_DIR}${SRC_NAME}_acc_multicore ${SRC_NAME}_acc_parallel.cpp ${ACC_LIBS}

acc_kernels: ${SRC_NAME}_acc_kernels.cpp
	${ACC} ${ACCFLAGS} -o  ${BIN_DIR}${SRC_NAME}_acc_kernels ${SRC_NAME}_acc_kernels.cpp ${ACC_LIBS}

pskel: ${SRC_NAME}_pskel.cu
	${CUDAC} ${CUDAFLAGS} -o ${BIN_DIR}${SRC_NAME}_pskel ${SRC_NAME}_pskel.cu ${LIBS}

pskel_omp_gcc: ${SRC_NAME}_pskel.cu
	${CUDAC} -ccbin=${GCC} ${GCC_FLAGS} ${CUDAFLAGS} -o ${BIN_DIR}${SRC_NAME}_pskel_omp_gcc ${SRC_NAME}_pskel.cu ${LIBS} -DPSKEL_OMP

pskel_tbb_gcc: ${SRC_NAME}_pskel.cu
	${CUDAC} -ccbin=${GCC} ${GCC_FLAGS} ${CUDAFLAGS} -o ${BIN_DIR}${SRC_NAME}_pskel_tbb_gcc ${SRC_NAME}_pskel.cu ${LIBS} -DPSKEL_TBB

pskel_omp_icc: ${SRC_NAME}_pskel.cu
	 ${CUDAC} -ccbin=${ICC} ${ICC_FLAGS} ${CUDAFLAGS} -o ${BIN_DIR}${SRC_NAME}_pskel_omp_icc ${SRC_NAME}_pskel.cu ${LIBS} -DPSKEL_OMP

pskel_tbb_icc: ${SRC_NAME}_pskel.cu
	 ${CUDAC} -ccbin=${ICC} ${ICC_FLAGS} ${CUDAFLAGS} -o ${BIN_DIR}${SRC_NAME}_pskel_tbb_icc ${SRC_NAME}_pskel.cu ${LIBS} -DPSKEL_TBB

pskel_shared: ${SRC_NAME}_pskel.cu
	${CUDAC} ${CUDAFLAGS} -o ${BIN_DIR}${SRC_NAME}_pskel_shared ${SRC_NAME}_pskel.cu ${LIBS} -Xptxas -v --keep --keep-dir nvcc -DPSKEL_SHARED


debug: ${SRC_NAME}_pskel.cu
	${CUDAC} ${CUDAFLAGS} -o ${BIN_DIR}${SRC_NAME}_pskel ${SRC_NAME}_pskel.cu ${LIBS} -DDEBUG
	
pskel_managed: ${SRC_NAME}_pskel.cu
	${CUDAC} ${CUDAFLAGS_T} -o ${BIN_DIR}${SRC_NAME}_pskel ${SRC_NAME}_pskel.cu ${LIBS}
	
src: ${SRC_NAME}_serial.cpp
	${PSKEL_SRC} ${SRC_NAME}_serial.cpp ${SRC_NAME}_src2src.cu
	${CUDAC} ${CUDAFLAGS} -ccbin=/usr/bin/g++ -o ${BIN_DIR}${SRC_NAME}_src2src ${SRC_NAME}_src2src.cu ${LIBS}

papi_tesla_omp_gcc: ${SRC_NAME}_pskel.cu
	${CUDAC} -ccbin=${GCC} ${GCC_FLAGS} ${CUDAFLAGS} -o ${BIN_DIR}${SRC_NAME}_papi_omp_gcc ${SRC_NAME}_pskel.cu ${LIBS} -DPSKEL_OMP -DPSKEL_PAPI -DTESLA -DXEON

papi_quadro_omp_gcc: ${SRC_NAME}_pskel.cu
	${CUDAC} -ccbin=${GCC} ${GCC_FLAGS} ${CUDAFLAGS} -o ${BIN_DIR}${SRC_NAME}_papi_omp_gcc ${SRC_NAME}_pskel.cu ${LIBS} -DPSKEL_OMP -DPSKEL_PAPI -DQUADRO -DXEON
	
papi: ${SRC_NAME}_pskel.cu
	${CUDAC} ${CUDAFLAGS} -o ${BIN_DIR}${SRC_NAME}_papi ${SRC_NAME}_pskel.cu ${LIBS} -lpapi -DPSKEL_PAPI -DTIME
	
papi_debug:${SRC_NAME}_pskel.cu
	${CUDAC} ${CUDAFLAGS} -o ${BIN_DIR}${SRC_NAME}_papi ${SRC_NAME}_pskel.cu ${LIBS} -DPSKEL_PAPI -DPSKEL_PAPI_DEBUG

papi_tesla: ${SRC_NAME}_pskel.cu
	${CUDAC} ${CUDAFLAGS} -o ${BIN_DIR}${SRC_NAME}_papi ${SRC_NAME}_pskel.cu ${LIBS} -I${PAPI_SRC_PATH} -L${PAPI_LIB_PATH} -lpapi -DPSKEL_PAPI -DTESLA
	
papi_debug_tesla: ${SRC_NAME}_pskel.cu
	${CUDAC} ${CUDAFLAGS} -o ${BIN_DIR}${SRC_NAME}_papi ${SRC_NAME}_pskel.cu ${LIBS} -I${PAPI_SRC_PATH} -L${PAPI_LIB_PATH} -lpapi -DPSKEL_PAPI -DPSKEL_PAPI_DEBUG -DTESLA	

papi_quadro: ${SRC_NAME}.cu
	${CUDAC} ${CUDAFLAGS} -o ${BIN_DIR}${SRC_NAME} ${SRC_NAME}.cu ${LIBS} -DPSKEL_PAPI -DQUADRO
	
papi_debug_quadro: ${SRC_NAME}.cu
	${CUDAC} ${CUDAFLAGS} -o ${BIN_DIR}${SRC_NAME} ${SRC_NAME}.cu ${LIBS} -DPSKEL_PAPI -DPSKEL_PAPI_DEBUG -DQUADRO	

cupti:  ${SRC_NAME}.cu
	${CUDAC} ${CUDAFLAGS} -o ${BIN_DIR}${SRC_NAME} ${SRC_NAME}.cu ${LIBS} -DCUPTI

time:  ${SRC_NAME}.cu
	${CUDAC} ${CUDAFLAGS} -o ${BIN_DIR}${SRC_NAME} ${SRC_NAME}.cu ${LIBS} -DTIME
	
pskelold: ${SRC_NAME}.cu
	${CUDAC} ${CUDAFLAGS} ${GENCODE} -o ${SRC_NAME}.o -c ${SRC_NAME}.cu
	${CUDAC} ${CUDAFLAGS} -o ${BIN_DIR}${SRC_NAME} ${SRC_NAME}.o ${LIBS} -Ilibcutil

testseq:
	time -p ${BIN_DIR}${SEQ_SRC_NAME} 480 480 1
	
testpskel:
	time -p ${BIN_DIR}${SRC_NAME} 480 480 1 0.0 32 8 0

testoptimus:
	time -p ${OPTIMUS} ${BIN_DIR}${SRC_NAME} 480 480 1 1.0 32 8 0
	
clean:
	 rm -f *.o ${BIN_DIR}${SRC_NAME}_pskel ${BIN_DIR}${SEQ_SRC_NAME}
