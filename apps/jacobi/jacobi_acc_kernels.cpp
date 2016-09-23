#include <fstream>
#include <string>
#include <stdio.h>
#include <string.h>
#include <iostream>
#include <iomanip>  
#include <ctime>
#include <iostream>
#include <cstdlib>
#include <stdlib.h>

#include "hr_time.h"
#include <omp.h>
#include <openacc.h>

using namespace std;

inline void stencilKernel(float* input, float* output, int width, int height, int T_MAX,float alpha, float beta){
	#pragma acc data copyin(input[0:width*height]) copyout(output[0:width*height])
	{
	for (int t = 0; t < T_MAX/2; t++){
	#pragma acc kernels //loop gang worker vector_length(32) num_workers(32)
	{
		#pragma acc loop independent vector(16) 
		for (int y = 0; y < height; y++){
			#pragma acc loop independent vector(16)
			for (int x = 0; x < width; x++){
                float N  = ((j-1)>=0)     ? input[(j-1)*width + (i  )] : 0.0f;
                float W  = ((i-1)<width)  ? input[(j  )*width + (i-1)] : 0.0f;
                float E  = ((i+1)<width)  ? input[(j  )*width + (i+1)] : 0.0f;
                float S  = ((j+1)<height) ? input[(j+1)*width + (i  )] : 0.0f;
                output[y*width+x] = 0.25f * (N + W + E + S - beta);
			}
		}  
		
		//swap data
		/*if(T_MAX > 1 && t<T_MAX-1){
			#pragma acc loop independent vector(8) 
			for (int y = 0; y < height ; y++){
				#pragma acc loop independent vector(32)
				for (int x = 0; x < width ; x++){
					input[y*width+x] = output[y*width+x];
				}
			}
		}*/
		#pragma acc loop independent vector(16) 
		for (int y = 0; y < height; y++){
			#pragma acc loop independent vector(16) 
			for (int x = 0; x < width; x++){
                float N  = ((j-1)>=0)     ? output[(j-1)*width + (i  )] : 0.0f;
                float W  = ((i-1)<width)  ? output[(j  )*width + (i-1)] : 0.0f;
                float E  = ((i+1)<width)  ? output[(j  )*width + (i+1)] : 0.0f;
                float S  = ((j+1)<height) ? output[(j+1)*width + (i  )] : 0.0f;
                input[y*width+x] = 0.25f * (N + W + E + S - beta);
			}
		}  
		
	}
	}
	}
	#pragma acc exit data
}

int main(int argc, char **argv){
	int width;
	int height;
	int T_MAX;
	int verbose;

	float *inputGrid;
	float *outputGrid;
	float alpha,beta;

	if (argc != 5){
		printf ("Wrong number of parameters.\n");
		printf ("Usage: jacobi WIDTH HEIGHT ITERATIONS VERBOSE\n");
		exit (-1);
	}

	width = atoi (argv[1]);
	height = atoi (argv[2]);
	T_MAX = atoi (argv[3]);
	verbose = atoi (argv[4]);

	alpha = 0.25/(float) width;
    	beta = 4.0f/(float) (height*height);

	inputGrid = (float*) calloc(width*height,sizeof(float));
	outputGrid = (float*) calloc(width*height,sizeof(float));

	#pragma omp parallel for
	for(int j=1;j<height-1;j++) {
		for(int i=1;i<width-1;i++) {
			inputGrid[j*width + i] = 1. + i*0.1 + j*0.01;
			outputGrid[j*width + i] = 0.0f;
		}
	}
  		
	hr_timer_t timer;
	hrt_start(&timer);
	//#pragma pskel stencil dim2d(width,height) inout(inputGrid, outputGrid) iterations(T_MAX) device(cpu)
	stencilKernel(inputGrid, outputGrid,width,height,T_MAX,alpha,beta);
	
	hrt_stop(&timer);
	
	cout << "Exec_time\t" << hrt_elapsed_time(&timer) << endl;
	
	if(verbose){		
		cout<<setprecision(2);
		cout<<fixed;
		cout<<"INPUT"<<endl;
		for(int i=0; i<width/10;i+=10){
			cout<<"("<<i<<","<<i<<") = "<<inputGrid[i*width+i]<<"\t\t("<<width-i<<","<<height-i<<") = "<<inputGrid[(height-i)*width+(width-i)]<<endl;
		}
		cout<<endl;
		
		cout<<"OUTPUT"<<endl;
		//for(int i=0; i<width/10;i+=10){
		//	cout<<"("<<i<<","<<i<<") = "<<outputGrid[i*width+i]<<"\t\t("<<width-i<<","<<height-i<<") = "<<outputGrid[(height-i)*width+(width-i)]<<endl;
		//}
		//cout<<endl;
		
		for(size_t h = 0; h < height; h++){		
			for(size_t w = 0; w < width; w++){
				cout<<inputGrid[h*width + w]<<" ";
			}
			cout<<endl;
		}
	}
  
	return 0;
}
