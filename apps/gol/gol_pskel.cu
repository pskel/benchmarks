//#define PSKEL_LOGMODE 1

#include <stdio.h>
#include <omp.h>
#include <iostream>
#include <iomanip>
#include <string>
#include <sstream>
#include <fstream>

//#define PSKEL_SHARED_MASK
#define PSKEL_CUDA
//#define GOL_KERNEL
//#define PSKEL_PAPI
//#define PSKEL_PAPI_DEBUG
#ifndef PSKEL_OMP
        #ifndef PSKEL_TBB
                #define PSKEL_OMP
                #undef PSKEL_TBB
        #endif
#else
#ifndef PSKEL_TBB
        #ifndef PSKEL_OMP
                #define PSKEL_TBB
                #undef PSKEL_OMP
        #endif
#endif
#endif


#include "PSkel.h"
//#include "hr_time.h"
//#include "wb.h"

using namespace std;
using namespace PSkel;

namespace PSkel{
__parallel__ void stencilKernel(Array2D<bool> &input, Array2D<bool> &output, Mask2D<bool> &mask, bool args, size_t i, size_t j){
    int neighbors =  input(i-1,j-1) + input(i-1,j) + input(i-1,j+1)  +
                     input(i,j-1)   + input(i,j+1) + 
		     input(i+1,j-1) + input(i+1,j) + input(i+1,j+1);
                      
    bool central = input(i,j);
    //printf("%d,%d\n",i,j);
    //int neighbors = mask.get(0,input,i,j) + mask.get(1,input,i,j) + mask.get(2,input,i,j) +

    //	              mask.get(3,input,i,j) + mask.get(4,input,i,j) + mask.get(5,input,i,j) +
    //		      mask.get(6,input,i,j) + mask.get(7,input,i,j);
    
    //int neighbors =  input(i-1,j-1) + input(i-1,j) + input(i-1,j+1)  +
    //                 input(i+1,j-1) + input(i+1,j) + input(i+1,j+1)  + 
    //                 input(i,j-1)   + input(i,j+1) ;
    /*
    bool neighbors = 0;
    bool height=input.getHeight();
    bool width=input.getWidth();
    
    if ( (j == 0) && (i == 0) ) { //	Corner 1	
        neighbors = input(i+1,j) + input(i,j+1) + input (i+1,j+1);
    }	//	Corner 2	
    else if ((j == 0) && (i == width-1)) {
        neighbors = input(i-1,j) + input(i,j+1) + input(i-1,j+1);
    }	//	Corner 3	
    else if ((j == height-1) && (i == width-1)) {
        neighbors = input(i-1,j) + input(i,j-1) + input(i-1,j-1);
    }	//	Corner 4	
    else if ((j == height-1) && (i == 0)) {
        neighbors = input(i,j-1) + input(i+1,j) + input(i+1,j-1);
    }	//	Edge 1	
    else if (j == 0) {
        neighbors = input(i-1,j) + input(i+1,j) + input(i-1,j+1) + input(i,j+1) + input(i+1,j+1);
    }	//	Edge 2	
    else if (i == width-1) {
        neighbors = input(i,j-1) +  input(i-1,j-1) + input(i-1,j) +  input(i-1,j+1) + input(i,j+1);
    }	//Edge 3	
    else if (j == height-1) {
        neighbors = input(i-1,j-1) + input(i,j-1) + input(i+1,j-1) + input(i-1,j) + input(i+1,j);
    }	//Edge 4
    else if (i == 0) {
        neighbors = input(i,j-1) + input(i+1,j-1) + input(i+1,j) + input(i,j+1) + input(i+1,j+1);
    }	//Inside the grid
    else {
        neighbors =  input(i-1,j-1) + input(i-1,j) + input(i-1,j+1)  +
                     input(i+1,j-1) + input(i+1,j) + input(i+1,j+1)  + 
                     input(i,j-1)   + input(i,j+1) ;
    }
    */ 
    output(i,j) = (neighbors == 3 || (neighbors == 2 && central))?1:0;
        
    }
}

int main(int argc, char **argv){
	int width, height, T_MAX,timeTileSize,GPUBlockSizeX, GPUBlockSizeY, numCPUThreads,verbose;
	float GPUTime;

	if (argc != 10){
		printf ("Wrong number of parameters.\n");
		printf ("Usage: gol WIDTH HEIGHT ITERATIONS TIME_TILE_SIZE GPUPERCENT GPUBLOCKS_X GPUBLOCKS_Y CPUTHREADS VERBOSE\n");
		exit (-1);
	}

	width = atoi (argv[1]);
	height = atoi (argv[2]);
	T_MAX = atoi(argv[3]);
    	timeTileSize = atoi(argv[4]);
	GPUTime = atof(argv[5]);
	GPUBlockSizeX = atoi(argv[6]);
	GPUBlockSizeY = atoi(argv[7]);
	numCPUThreads = atoi(argv[8]);
	verbose = atoi(argv[9]);
	
	Array2D<bool> inputGrid(width, height);
	Array2D<bool> outputGrid(width, height);
	Mask2D<bool> mask(8);
	
	mask.set(0,-1,-1);	mask.set(1,-1,0);	mask.set(2,-1,1);
	mask.set(3,0,-1);						mask.set(4,0,1);
	mask.set(5,1,-1);	mask.set(6,1,0);	mask.set(7,1,1);
		
	//omp_set_num_threads(numCPUThreads);

	//srand(123456789);
	#pragma omp parallel num_threads(numCPUThreads)
	{
	unsigned int seed = 25234 + 17 * omp_get_thread_num();
	#pragma omp for
    	for(int h = 0; h < height; h++){		
       		for(int w = 0; w < width; w++){
      			inputGrid(h,w) = (bool) (rand_r(&seed)%2) ;            
            		//outputGrid(i,j) =  inputGrid(i,j);
		}
	}
	}

	if(verbose){
 		cout<<"INPUT"<<endl;
                for(size_t h = 0; h < height; h++){             
                        for(size_t w = 0; w < width; w++){
                                cout<<inputGrid(h,w);
                        }
                        cout<<endl;
                }
	}

	#ifdef PSKEL_PAPI
	if(GPUTime < 1.0)
		PSkelPAPI::init(PSkelPAPI::CPU);
	else 
		PSkelPAPI::init(PSkelPAPI::NVML);
	#endif	
	
	//hr_timer_t timer;
	//hrt_start(&timer);
	//wbTime_start(GPU, "Doing GPU Computation (memory + compute)");
	Stencil2D<Array2D<bool>, Mask2D<bool>, bool> stencil(inputGrid, outputGrid, mask, 0);
	
	if(GPUTime == 0.0){
		//jacobi.runIterativeCPU(T_MAX, numCPUThreads);
		//#ifdef PSKEL_PAPI
		//	for(unsigned bool i=0;i<NUM_GROUPS_CPU;i++){
		//		//cout << "Running iteration " << i << endl;
		//		stencil.runIterativeCPU(T_MAX, numCPUThreads, i);	
		//	}
		//#else
			//cout<<"Running Iterative CPU"<<endl;
		
		#ifdef PSKEL_PAPI
		//for(unsigned int i=0;i<NUM_GROUPS_CPU;i++){
		PSkelPAPI::papi_start(PSkelPAPI::CPU,5);
		#endif
		stencil.runIterativeCPU(T_MAX, numCPUThreads);	
		#ifdef PSKEL_PAPI
		PSkelPAPI::papi_stop(PSkelPAPI::CPU,5);
		//}
		#endif
	}
	else if(GPUTime == 1.0){
		#ifdef PSKEL_PAPI
        PSkelPAPI::papi_start(PSkelPAPI::NVML,0);
        #endif
        #ifdef PSKEL_SHARED
		//stencil.runIterativeGPU(T_MAX,timeTileSizei,GPUBlockSizeX, GPUBlockSizeY);
        #else
        	stencil.runIterativeGPU(T_MAX,GPUBlockSizeX, GPUBlockSizeY);
        #endif
		#ifdef PSKEL_PAPI
        PSkelPAPI::papi_stop(PSkelPAPI::NVML,0);
        #endif

	}
	else{
		stencil.runIterativePartition(T_MAX, GPUTime, numCPUThreads,GPUBlockSizeX, GPUBlockSizeY);
		/*
        	#ifdef PSKEL_PAPI
			for(unsigned bool i=0;i<NUM_GROUPS_CPU;i++){
				stencil.runIterativePartition(T_MAX, GPUTime, numCPUThreads,GPUBlockSizeX,i);
			}
		#else
			//stencil.runIterativePartition(T_MAX, GPUTime, numCPUThreads,GPUBlockSizeX);
		#endif
        */
	}
	
	
	//wbTime_stop(GPU, "Doing GPU Computation (memory + compute)");
	//hrt_stop(&timer);

	#ifdef PSKEL_PAPI
		if(GPUTime < 1.0){
			PSkelPAPI::print_profile_values(PSkelPAPI::CPU);
		}
		else{
			PSkelPAPI::print_profile_values(PSkelPAPI::NVML);
		}
		PSkelPAPI::shutdown();
	#endif
    
    if(verbose){		
		//cout<<setprecision(6);
		//cout<<fixed;
		//cout<<"INPUT"<<endl;
		/*for(bool i=0; i<width;i+=10){
            
			cout<<"("<<i<<","<<i<<") = "<<inputGrid(i,i)<<"\t\t(";
            cout<<width-i<<","<<height-i<<") = "<<inputGrid(height-i,width-i)<<endl;
		}
		cout<<endl;
        */
        	//for(size_t h = 0; h < height; h++){		
		//	for(size_t w = 0; w < width; w++){
		//		cout<<inputGrid(h,w);
		//	}
		//	cout<<endl;
		//}
		
		cout<<"OUTPUT"<<endl;
		//for(bool i=0; i<width/10;i+=10){
		//	cout<<"("<<i<<","<<i<<") = "<<outputGrid[i*width+i]<<"\t\t("<<width-i<<","<<height-i<<") = "<<outputGrid[(height-i)*width+(width-i)]<<endl;
		//}
		//cout<<endl;
		
		for(size_t h = 0; h < height; ++h){		
			for(size_t w = 0; w < width; ++w){
				cout<<outputGrid(h,w);
			}
			cout<<endl;
		}
    }
    
    //cout << "Exec_time\t" << hrt_elapsed_time(&timer) << endl;
    
    return 0;
}
