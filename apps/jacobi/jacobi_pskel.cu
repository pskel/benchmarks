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
#include "hr_time.h"
//#include "wb.h"

using namespace std;
using namespace PSkel;

struct Arguments{
	float h;
};

namespace PSkel{

/*
__parallel__ void stencilKernel(float input[BLOCK_SIZE][BLOCK_SIZE],float output[BLOCK_SIZE][BLOCK_SIZE], Arguments args, size_t ty, size_t tx){					 
	//size_t index = (tx-1+1)*10+(ty+1);
	//printf("idx %d ",index);
	//printf("val %f\n",shared[index]);
	output[ty][tx] = 0.25f * (input[ty][tx-1] + input[ty][tx+1] + input[ty-1][tx] + input[ty+1][tx] - args.h);
}
*/
__parallel__ void stencilKernel(Array2D<float> &input, Array2D<float> &output, const Mask2D<float> &mask, float args, size_t i, size_t j){
	//output(i,j) = 0.25f * ( mask.get(0, input, i, j) + mask.get(1, input, i, j) +  
	//			mask.get(2, input, i, j) + mask.get(3, input, i, j) - args.h );
						 
	
	//float L1 = input(i-1,j);
	//float L2 = input(i,j-1) + input(i,j+1);
	//float L3 = input(i+1,j);

	//output(i,j) = (L1+L2+L3 - args) * 0.25f;
	
	//printf("%f\t",output(i,j));
	output(i,j) = 0.25f * ( input(i-1,j) + (input(i,j-1) + input(i,j+1)) + input(i+1,j) - args);
	
	//output(i,j) = 0.25f * ( input(i-1,j) + (input(i,j-1) + input(i,j+1)) + input(i+1,j) - args);
   /*int width = input.getWidth(); 
    int height = input.getHeight();
    //	Corner 1	
>>>>>>> 94366149f8c7501f5cd79b875bdd69b74eb59bc6
    if ( (j == 0) && (i == 0) ) {
         output(i,j) = 0.25f * (input(i+1,j) + input(i,j+1) - args.h);
    }	//	Corner 2	
    else if ((j == 0) && (i == width-1)) {
         output(i,j) = 0.25f * (input(i,j+1) + input(i-1,j) - args.h);
    }	//	Corner 3	
    else if ((j == height-1) && (i == width-1)) {
        output(i,j) = 0.25f * (input(i,j-1) + input(i-1,j) - args.h);
<<<<<<< HEAD
    }	//	Corner 4	
=======
    }		Corner 4	
>>>>>>> 94366149f8c7501f5cd79b875bdd69b74eb59bc6
    else if ((j == height-1) && (i == 0)) {
        output(i,j) = 0.25f * (input(i+1,j) + input(i,j-1) - args.h);
    }	//	Edge 1	
    else if (j == 0) {
        output(i,j) = 0.25f * (input(i-1,j) + input(i+1,j) + input(i,j+1) - args.h);
        //output[y*width+x] = 0.25f * (input[(y)*width + (x-1)] + input[(y)*width +(x+1)] + input[(y+1)*width +(x)]- args.h);
<<<<<<< HEAD
    }	// Edge 2	
    else if (i == width-1) {
        output(i,j) = 0.25f * (input(i-1,j) + input(i,j-1) + input(i,j+1) - args.h);
        //output[y*width+x] = 0.25f * (input[(y)*width + (x-1)] + input[(y-1)*width +(x)] +input[(y+1)*width +(x)] - args.h);
=======
    }	//	Edge 2	
    else if (i == width-1) {
        output(i,j) = 0.25f * (input(i-1,j) + input(i,j-1) + input(i,j+1) - args.h);
>>>>>>> 94366149f8c7501f5cd79b875bdd69b74eb59bc6
    }	//	Edge 3	
    else if (j == height-1) {
        output(i,j) = 0.25f * (input(i-1,j) + input(i+1,j) + input(i,j-1) - args.h);
    }	//	Edge 4	
    else if (i == 0) {
        output(i,j) = 0.25f * (input(i,j-1) + input(i+1,j) + input(i,j+1) - args.h);
   }	//	Inside the grid  
    else {
        output(i,j) = 0.25f * (input(i,j-1) + input(i+1,j) + input(i-1,j) + input(i,j+1) - args.h);
    }    
    */
  
    }
}


int main(int argc, char **argv){
	int x_max, y_max, T_MAX, pyramidHeight, GPUBlockSizeX, GPUBlockSizeY, numCPUThreads;
	float GPUTime;

	if (argc != 10){
		printf ("Wrong number of parameters.\n");
		printf ("Usage: jacobi WIDTH HEIGHT ITERATIONS PYRAMID_HEIGHT GPUPERCENT GPUBLOCKS_X GPUBLOCKS_Y CPUTHREADS OUTPUT_WRITE_FLAG\n");
		exit (-1);
	}

	x_max = atoi (argv[1]);
	y_max = atoi (argv[2]);
	T_MAX=atoi(argv[3]);
	pyramidHeight=atoi(argv[4]);
	GPUTime = atof(argv[5]);
	GPUBlockSizeX = atoi(argv[6]);
	GPUBlockSizeY = atoi(argv[7]);
	numCPUThreads = atoi(argv[8]);
	int writeToFile = atoi(argv[9]);

	Array2D<float> inputGrid(x_max, y_max);
	Array2D<float> outputGrid(x_max, y_max);
	//int n[4][2] = {{0,1},{-1,0},{1,0},{-1,0}};
	//Mask2D<float> mask(4,n);	
	Mask2D<float> mask(4);
	
	mask.set(0,0,-1,0);
	mask.set(1,0,1,0);
	mask.set(2,1,0,0);
	mask.set(3,-1,0,0);
	
	//Arguments args;
	float args;
	//args.h = 1.f / (float) x_max;
	args = 4.f / (float) (x_max*x_max);
		
	//omp_set_num_threads(numCPUThreads);
	size_t gpuHeight = ceil(inputGrid.getHeight()*GPUTime);
	size_t cpuHeight = inputGrid.getHeight()-gpuHeight;	
	/* initialize the first timesteps */
/*
	#ifdef PSKEL_OMP
	if(GPUTime == 0.0){
		#pragma omp parallel num_threads(numCPUThreads)
    		{
		#pragma omp for
		for(size_t h = 1; h < inputGrid.getHeight()-1; h++){	
			for(size_t w = 1; w < inputGrid.getWidth()-1; w++){
				inputGrid(h,w) = 1.0f + w*0.1 + h*0.01;
				outputGrid(h,w) = 0.0f;
			}
		}
		}
	}
	else{ //NUMA first touch
		//StencilTiling<Array2D<float>,Mask2D<float> > gpuTiling(inputGrid, outputGrid, mask);
		#pragma omp parallel num_threads(numCPUThreads)
    		{
		if(omp_get_thread_num() == 0){
			for(size_t h=0; h < gpuHeight; h++){
				for(size_t w = 0; w < inputGrid.getWidth();w++){
					inputGrid(h,w) = 1.0f; // + w*0.1 + h*0.01;
				 	outputGrid(h,w) = 0.0f;
				}
			}
		}
		else{
			size_t split = ceil(float(cpuHeight)/numCPUThreads);
        		size_t  begin = split * omp_get_thread_num() + gpuHeight;
        		size_t  end = split * (omp_get_thread_num() + 1) + gpuHeight;
                	if(end > inputGrid.getHeight()){
                		end = inputGrid.getHeight();
                	}
	
			for(size_t h = begin; h < end; h++){           
                      		for(size_t w = 0; w < inputGrid.getWidth(); w++){
                                	inputGrid(h,w) = 1.0f; // + w*0.1 + h*0.01;
                                	outputGrid(h,w) = 0.0f;
                        	}
                	}
		}
		}	
	}
	#else
*/	
	//#pragma omp parallel num_threads(numCPUThreads)
	{
	//#pragma omp for 
	for(size_t h = 0; h < y_max; h++){	
		for(size_t w = 0; w < x_max; w++){
			inputGrid(h,w) = 1.0f + w*0.1f + h*0.01f;
			outputGrid(h,w) = 1.0f;
		}
	}
	}
//	#endif
	hr_timer_t timer;
	//hrt_start(&timer);
    
	//wbTime_start(GPU, "Doing GPU Computation (memory + compute)");
	Stencil2D<Array2D<float>, Mask2D<float>, float> jacobi(inputGrid, outputGrid, mask, args);
	
	hrt_start(&timer);
    


	//Runtime< Stencil2D<Array2D<float>, Mask2D<float>, Arguments> > stencilComponent(&jacobi);
	/*
	hrt_start(&timer);
	//stencil.runIterativeCPU(iterations, numCPUThreads);
	//stencil.runIterativeAutoGPU(T_MAX,GPUBlockSize);
	stencil.runIterativeGPU(T_MAX,GPUBlockSize);
	hrt_stop(&timer);
	cout << hrt_elapsed_time(&timer) << endl;
	*/
	
	#ifdef PSKEL_PAPI
		if(GPUTime < 1.0)
			PSkelPAPI::init(PSkelPAPI::CPU);
	#endif
	
	//stencil.runIterativePartition(T_MAX, 1.0-CPUTime, numCPUThreads, GPUBlockSize);
	//stencil.runIterativeAutoHybrid(T_MAX, CPUTime, numCPUThreads, GPUBlockSize);	
	
	//jacobi.runSequential();
	//jacobi.runIterativeCPU(T_MAX, numCPUThreads);
	
	
	if(GPUTime == 0.0){
		//jacobi.runIterativeCPU(T_MAX, numCPUThreads);
		//#ifdef PSKEL_PAPI
		//	for(unsigned int i=0;i<NUM_GROUPS_CPU;i++){
				//cout << "Running iteration " << i << endl;
		//		jacobi.runIterativeCPU(T_MAX, numCPUThreads, i);	
		//	}
		//#else
			//cout<<"Running Iterative CPU"<<endl;
		//if(numCPUThreads==1){
		//	cout<<"Running Seq"<<endl;
		//	jacobi.runIterativeSequential(T_MAX);
		//}
		//else{
			#ifdef PSKEL_PAPI
            		for(unsigned int i=0;i<NUM_GROUPS_CPU;i++){
				PSkelPAPI::papi_start(PSkelPAPI::CPU,i);
			#endif
			jacobi.runIterativeCPU(T_MAX, numCPUThreads);	
			#ifdef PSKEL_PAPI
				PSkelPAPI::papi_stop(PSkelPAPI::CPU,i);
            		}
			#endif
		//}
	}
	else if(GPUTime == 1.0){
		#ifdef PSKEL_CUDA
		#ifdef PSKEL_SHARED
			jacobi.runIterativeGPU(T_MAX,pyramidHeight,GPUBlockSizeX, GPUBlockSizeY);
		#else
			jacobi.runIterativeGPU(T_MAX,GPUBlockSizeX, GPUBlockSizeY);
		#endif
		#endif
	}
	else{
		#ifdef PSKEL_CUDA
		jacobi.runIterativePartition(T_MAX, GPUTime, numCPUThreads,GPUBlockSizeX, GPUBlockSizeY);
		/*
        #ifdef PSKEL_PAPI
			for(unsigned int i=0;i<NUM_GROUPS_CPU;i++){
				jacobi.runIterativePartition(T_MAX, GPUTime, numCPUThreads,GPUBlockSizeX,i);
			}
		#else
			jacobi.runIterativePartition(T_MAX, GPUTime, numCPUThreads,GPUBlockSizeX);
		#endif
        */
		#endif
	}
	
	
	//wbTime_stop(GPU, "Doing GPU Computation (memory + compute)");
	hrt_stop(&timer);

	#ifdef PSKEL_PAPI
		if(GPUTime < 1.0){
			PSkelPAPI::print_profile_values(PSkelPAPI::CPU);
			PSkelPAPI::shutdown();
		}
	#endif
	
	cout << "Exec_time\t" << hrt_elapsed_time(&timer) << endl;

	if(writeToFile == 1){
		/*stringstream outputFile;
		outputFile << "output_" <<x_max << "_" << y_max << "_" << T_MAX << "_" << GPUTime << "_" << GPUBlockSize <<"_" << numCPUThreads << ".txt";
		string out = outputFile.str();
		
		ofstream ofs(out.c_str(), std::ofstream::out);
		
		ofs.precision(6);
		
		for (size_t h = 1; h < outputGrid.getHeight()-1; h++){		
			for (size_t w = 1; w < outputGrid.getWidth()-1; w++){
				ofs<<outputGrid(h,w)<<" ";
			}
			ofs<<endl;
		}*/		
		
		cout<<setprecision(2);
		cout<<fixed;
		cout<<"INPUT"<<endl;
		for(size_t h = 0; h < inputGrid.getHeight(); h++){		
			for(size_t w = 0; w < inputGrid.getWidth(); w++){
				cout<<inputGrid(h,w)<<"\t";
			}
			cout<<endl;
		}
		//for(int i=0; i<y_max/10;i+=10){
		//	cout<<"("<<i<<","<<i<<") = "<<inputGrid(i,i)<<"\t("<<x_max-i<<","<<y_max-i<<") = "<<inputGrid(x_max-i,y_max-i)<<endl;
		//}
		//cout<<endl;
		
		cout<<"OUTPUT"<<endl;
		//for(int i=0; i<y_max/10;i+=10){
		//	cout<<"("<<i<<","<<i<<") = "<<outputGrid(i,i)<<"\t\t("<<x_max-i<<","<<y_max-i<<") = "<<outputGrid(x_max-i,y_max-i)<<endl;
		//}
		//cout<<endl;
		
		for(size_t h = 0; h < outputGrid.getHeight(); h++){		
			for(size_t w = 0; w < outputGrid.getWidth(); w++){
				cout<<outputGrid(h,w)<<"\t";
			}
			cout<<endl;
		}
	}
	//~inputGrid();
	//~outputGrid();
	//~mask();
	//~jacobi();
	return 0;
}
