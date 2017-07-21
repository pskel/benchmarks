#include <stdio.h>
#include <iostream>
#include <fstream>
#include <string>
#include <sstream>

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

#define PSKEL_CUDA

#include "PSkel.h"
#include "hr_time.h"

#define MASK_RADIUS 2
#define MASK_WIDTH  5

using namespace std;
using namespace PSkel;

//*******************************************************************************************
// CONVOLUTION
//*******************************************************************************************

namespace PSkel{
	__parallel__ void stencilKernel(Array2D<float> &input, Array2D<float> &output, Mask2D<float> &mask, int null, size_t i, size_t j){
		//float accum = 0.0f;
		/*for(int n=0;n<mask.size;n++){
			accum += mask.get(n,input,i,j) * mask.getWeight(n);
		}
		output(i,j)= accum;
		*/

		//float L1 = input(i-2,j-2) * 0.33 + input(i-2,j-1) * 0.33 + input(i-2,j)   * 0.33 + input(i-2,j+1) * 0.33  + input(i-2,j+2) * 0.33;
		float L2 = /*input(i-1,j-2) * 0.33 + */ input(i-1,j-1) * 0.33 + input(i-1,j)   * 0.33 + input(i-1,j+1) * 0.33  /*+ input(i-1,j+2) * 0.33*/; 
        float L3 = /*input(i, j-2)  * 0.33 + */ input(i,j-1)   * 0.33 + input(i,j)     * 0.33 + input(i,j+1)   * 0.33  /*+ input(i, j+2)  * 0.33*/; 
        float L4 = /*input(i+1,j-2) * 0.33 + */ input(i+1,j-1) * 0.33 + input(i+1,j)   * 0.33 + input(i+1,j+1) * 0.33  /*+ input(i+1,j+2) * 0.33*/;  
 		//float L5 = input(i+2,j-2) * 0.33 + input(i+2,j-1) * 0.33 + input(i+2,j)   * 0.33 + input(i+2,j+1) * 0.33  + input(i+2,j+2) * 0.33; 
		
/*
		float L1 = input(i-2,j-2) * 0.33 + input(i-1,j-2) * 0.33 + input(i,j-2)   * 0.33 + input(i+1,j-2) * 0.33  + input(i+2,j-2) * 0.33;
		float L2 = input(i-2,j-1) * 0.33 + input(i-1,j-1) * 0.33 + input(i,j-1)   * 0.33 + input(i+1,j-1) * 0.33  + input(i+2,j-1) * 0.33; 
                float L3 = input(i-2, j)  * 0.33 + input(i-1,j)   * 0.33 + input(i,j)     * 0.33 + input(i+1,j)   * 0.33  + input(i+2, j)  * 0.33; 
                float L4 = input(i-2,j+1) * 0.33 + input(i-1,j+1) * 0.33 + input(i,j+1)   * 0.33 + input(i+1,j+1) * 0.33  + input(i+2,j+1) * 0.33;  
 		float L5 = input(i-2,j+2) * 0.33 + input(i-1,j+2) * 0.33 + input(i,j+2)   * 0.33 + input(i+1,j+2) * 0.33  + input(i+2,j+2) * 0.33; 
		
*/
/*
		float L1 = input(i-2,j-2) * mask.getWeight(0)  + input(i-1,j-2) * mask.getWeight(1)  + input(i,j-2) * mask.getWeight(2)  + input(i+1,j-2) * mask.getWeight(3) + input(i+2,j-2) * mask.getWeight(4);
		float L2 = input(i-2,j-1) * mask.getWeight(5)  + input(i-1,j-1) * mask.getWeight(6)  + input(i,j-1) * mask.getWeight(7)  + input(i+1,j-1) * mask.getWeight(8) + input(i+2,j-1) * mask.getWeight(9); 
                float L3 = input(i-2, j)  * mask.getWeight(10) + input(i-1,j)   * mask.getWeight(11)  + input(i,j)  * mask.getWeight(12)  + input(i+1,j)   * mask.getWeight(13) + input(i+2, j)  * mask.getWeight(14); 
                float L4 = input(i-2,j+1) * mask.getWeight(15) + input(i-1,j+1) * mask.getWeight(16)  + input(i,j+1) * mask.getWeight(17)  + input(i+1,j+1) * mask.getWeight(18) + input(i+2,j+1) * mask.getWeight(19);  
 		float L5 = input(i-2,j+2) * mask.getWeight(20) + input(i-1,j+2) * mask.getWeight(21)  + input(i,j+2) * mask.getWeight(22)  + input(i+1,j+2) * mask.getWeight(23) + input(i+2,j+2) * mask.getWeight(24); 
	*/	
	
		output(i,j) = /*L1 + */L2 + L3 + L4/* + L5*/;
			
		/*output(i,j) = input(i-2,j-2) * 0.33 + input(i-2,j-1) * 0.33 + input(i-2,j)   * 0.33 + input(i-2,j+1) * 0.33  + input(i-2,j+2) * 0.33 + 
			      input(i-1,j-2) * 0.33 + input(i-1,j-1) * 0.33 + input(i-1,j)   * 0.33 + input(i-1,j+1) * 0.33  + input(i-1,j+2) * 0.33 + 
                              input(i, j-2)  * 0.33 + input(i-1,j-1) * 0.33 + input(i,j)     * 0.33 + input(i,j+1)   * 0.33  + input(i,j+2)   * 0.33 + 
                              input(i+1,j-2) * 0.33 + input(i+1,j-1) * 0.33 + input(i+1,j)   * 0.33 + input(i+1,j+1) * 0.33  + input(i+1,j+2) * 0.33 +  
 		 	      input(i+2,j-2) * 0.33 + input(i+2,j-1) * 0.33 + input(i+2,j)   * 0.33 + input(i+2,j+1) * 0.33  + input(i+2,j+2) * 0.33; 
		*/
		/*
		output(i,j) = mask.get(0,input,i,j) * mask.getWeight(0) +
					  mask.get(1,input,i,j) * mask.getWeight(1) +
					  mask.get(2,input,i,j) * mask.getWeight(2) +
					  mask.get(3,input,i,j) * mask.getWeight(3) +
					  mask.get(4,input,i,j) * mask.getWeight(4) +
					  mask.get(5,input,i,j) * mask.getWeight(5) +
					  mask.get(6,input,i,j) * mask.getWeight(6) +
					  mask.get(7,input,i,j) * mask.getWeight(7) +
					  mask.get(8,input,i,j) * mask.getWeight(8) +
					  mask.get(9,input,i,j) * mask.getWeight(9) +
					  mask.get(10,input,i,j) * mask.getWeight(10) +
					  mask.get(11,input,i,j) * mask.getWeight(11) +
					  mask.get(12,input,i,j) * mask.getWeight(12) +
					  mask.get(13,input,i,j) * mask.getWeight(13) +
					  mask.get(14,input,i,j) * mask.getWeight(14) +
					  mask.get(15,input,i,j) * mask.getWeight(15) +
					  mask.get(16,input,i,j) * mask.getWeight(16) +
					  mask.get(17,input,i,j) * mask.getWeight(17) +
					  mask.get(18,input,i,j) * mask.getWeight(18) +
					  mask.get(19,input,i,j) * mask.getWeight(19) +
					  mask.get(20,input,i,j) * mask.getWeight(20) +
					  mask.get(21,input,i,j) * mask.getWeight(21) +
					  mask.get(22,input,i,j) * mask.getWeight(22) +
					  mask.get(23,input,i,j) * mask.getWeight(23) +
					  mask.get(24,input,i,j) * mask.getWeight(24); 
		*/
	}
}//end namespace

//*******************************************************************************************
// MAIN
//*******************************************************************************************

int main(int argc, char **argv){	
		
	Mask2D<float> mask(25);
	float GPUTime;
	int GPUBlockSizeX, GPUBlockSizeY, numCPUThreads,timeTileSize,x_max,y_max;
	
	if (argc != 10){
		printf ("Wrong number of parameters.\n");
		//printf ("Usage: convolution INPUT_IMAGE ITERATIONS GPUTIME GPUBLOCKS CPUTHREADS OUTPUT_WRITE_FLAG\n");
		printf ("Usage: convolution WIDTH HEIGHT ITERATIONS TIME_TILE_SIZE GPUTIME GPUBLOCK_X GPUBLOCK_Y CPUTHREADS OUTPUT_WRITE_FLAG\n");
		printf ("You entered: ");
		for(int i=0; i< argc;i++){
			printf("%s ",argv[i]);
		}
		printf("\n");
		exit (-1);
	}
	
	x_max = atoi(argv[1]);
	y_max = atoi(argv[2]);
	int T_MAX = atoi(argv[3]);
	timeTileSize = atoi(argv[4]);
	GPUTime = atof(argv[5]);
	GPUBlockSizeX = atoi(argv[6]);
	GPUBlockSizeY = atoi(argv[7]);
	numCPUThreads = atoi(argv[8]);
	int writeToFile = atoi(argv[9]);
	
	Array2D<float> inputGrid(x_max, y_max);
	Array2D<float> outputGrid(x_max, y_max);	

	mask.set(0,-2,2,0.1);	mask.set(1,-1,2,0.2);	mask.set(2,0,2,0.3);	mask.set(3,1,2,0.4);	mask.set(4,2,2,0.5);
	mask.set(5,-2,1,0.6);	mask.set(6,-1,1,0.7);	mask.set(7,0,1,0.1);	mask.set(8,1,1,0.3);	mask.set(9,2,1,0.5);
	mask.set(10,-2,0,0.7);	mask.set(11,-1,0,0.1);	mask.set(12,0,0,0.2);	mask.set(13,1,0,0.1);	mask.set(14,2,0,0.5);
	mask.set(15,-2,-1,0.8);	mask.set(16,-1,-1,0.0);	mask.set(17,0,-1,0.1);	mask.set(18,1,-1,0.5);	mask.set(19,2,-1,0.5);
	mask.set(20,-2,-2,0.9);	mask.set(21,-1,-2,0.9);	mask.set(22,0,-2,0.9);	mask.set(23,1,-2,0.9);	mask.set(24,2,-2,0.9);
	
	#pragma omp parallel num_threads(numCPUThreads)
	{
		unsigned int seed = 12345 + 17 *  omp_get_thread_num();
		#pragma omp for
		for (int x = 0; x < x_max; x++){
			for (int y = 0; y < y_max; y++){		
				inputGrid(x,y) = ((float)(rand_r(&seed) % 255))/255;
			}
		}
	}
	cout<<"Data initialized"<<endl;	
	Stencil2D<Array2D<float>, Mask2D<float>, int> stencil(inputGrid, outputGrid, mask, 0);
	hr_timer_t timer;
	
	
	#ifdef PSKEL_PAPI
		if(GPUTime < 1.0)
			PSkelPAPI::init(PSkelPAPI::CPU);
	#endif
	
	hrt_start(&timer);
	
	if(GPUTime == 0.0){
		#ifdef PSKEL_PAPI
		for(unsigned int i=0;i<NUM_GROUPS_CPU;i++){
			PSkelPAPI::papi_start(PSkelPAPI::CPU,i);
		#endif
			stencil.runIterativeCPU(T_MAX, numCPUThreads);
		#ifdef PSKEL_PAPI
			PSkelPAPI::papi_stop(PSkelPAPI::CPU,i);
		}
		#endif
	}
	else if(GPUTime == 1.0){
		stencil.runIterativeGPU(T_MAX, GPUBlockSizeX, GPUBlockSizeY);
	}
	else{
		stencil.runIterativePartition(T_MAX, GPUTime, numCPUThreads,GPUBlockSizeX,GPUBlockSizeY);
	}
	
	hrt_stop(&timer);

	#ifdef PSKEL_PAPI
		if(GPUTime < 1.0){
			PSkelPAPI::print_profile_values(PSkelPAPI::CPU);
			PSkelPAPI::shutdown();
		}
	#endif
	
	cout << "Exec_time\t" << hrt_elapsed_time(&timer) << endl;

	if(writeToFile == 1){
		cout.precision(12);
		cout<<"INPUT"<<endl;
		for(int i=10; i<y_max;i+=10){
			cout<<"("<<i<<","<<i<<") = "<<inputGrid(i,i)<<"\t\t("<<x_max-i<<","<<y_max-i<<") = "<<inputGrid(x_max-i,y_max-i)<<endl;
		}
		cout<<endl;
		
		cout<<"OUTPUT"<<endl;
		for(int i=10; i<y_max;i+=10){
			cout<<"("<<i<<","<<i<<") = "<<outputGrid(i,i)<<"\t\t("<<x_max-i<<","<<y_max-i<<") = "<<outputGrid(x_max-i,y_max-i)<<endl;
		}
		cout<<endl;
	}
	return 0;
}


