# PSKEL LIBRARY
PSKEL_PATH = $(HOME)/github/pskel/include

# CUDA
CUDAC		= /usr/local/cuda/bin/nvcc
CUDA_LIB_PATH 	= /usr/local/cuda/lib64
GENCODE 	= -gencode arch=compute_35,code=\"sm_35,compute_35\"
CUDA_FLAGS 	= -O3 ${GENCODE} -m64 --ptxas-options=-v -std=c++11

# GCC
GCC		= /usr/bin/g++
GCC_FLAGS 	= -Xcompiler -O3 -Xcompiler -fopenmp -Xcompiler -ftree-vectorize -Xcompiler -march=native -Xcompiler -mtune=native #-Xcompiler -std=c++11

# TBB
TBB_LIB_PATH	= ${HOME}/tbb/2018.1/lib/intel64/gcc4.7
TBB_SRC_PATH	= ${HOME}/tbb/2018.1/include

# GAlib
GA_LIB_PATH 	= $(HOME)/galib247/ga
GA_SRC_PATH	= $(HOME)/galib247 

LIBS		= -I${PSKEL_PATH} -I${GA_SRC_PATH} -L${GA_LIB_PATH} -I${TBB_SRC_PATH} -L${TBB_LIB_PATH} -ltbb -ltbbmalloc -lga -lm 

BIN_DIR		= $(HOME)/github/benchmarks/apps/bin

all: pskel_omp_gcc

pskel_omp_gcc: $(SRC)
	${CUDAC} -ccbin=${GCC} ${GCC_FLAGS} ${CUDA_FLAGS} -o ${BIN_DIR}//${OBJS} ${SRC} ${LIBS} -DPSKEL_OMP -DPSKEL_GA -DCACHE_BLOCK

