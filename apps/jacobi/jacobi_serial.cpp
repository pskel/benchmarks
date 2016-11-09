#include <fstream>
#include <string>
#include <stdio.h>
#include <string.h>
#include <iostream>
#include <ctime>
#include <iostream>
#include <cstdlib>
#include <stdlib.h>

#include <omp.h>
#include "hr_time.h"

#include "tbb/task_scheduler_init.h"
#include "tbb/blocked_range.h"
#include "tbb/parallel_for.h"

using namespace std;

void update(float *input, float* output, size_t begin, size_t end, size_t width){
	for (size_t y = begin; y < end; y++){
		for (size_t x = 0; x < width; x++){
		output[y*width+x] = 0.25f * (input[(y+1)*width + x] + input[(y-1)*width + x] +
                                             input[y*width + (x+1)] + input[y*width + (x-1)] );
		
		}
	}
}


class TBBStencil{
private:
	float *input;
	float *output;
	int width, height;
public:	
	TBBStencil (){}

	TBBStencil(float *_input, float *_output, int _width, int _height){
		input = _input;
		output = _output;
		width = _width;
		height = _height;
	}

	void swap(){
		float *temp;
		temp = output;
		output = input;
		input = temp;		
	}

	void operator()(const tbb::blocked_range<size_t> &r)const{
		//size_t begin = r.begin();
		//size_t end = r.end();
		//update(input,output,begin,end,width);
		
 		for (size_t y = r.begin(); y != r.end(); y++){
			for (size_t x = 1; x < width-1; x++){
				output[y*width+x] = 0.25f * (input[(y+1)*width + x] + input[(y-1)*width + x] + input[y*width + (x+1)] + input[y*width + (x-1)] );
			
			}
	}
	}
};

//float* TBBStencil::input = NULL;
//float* TBBStencil::output = NULL;
//int TBBStencil::width = 0;
//int TBBStencil::height = 0;

void stencilKernel(float *input, float *output, int width, int height, int T_MAX,float alpha, float beta){
	for (int t = 0; t < T_MAX; t++){
		#pragma omp parallel for
		for (int y = 1; y < height - 1; y++){
			for (int x = 1; x < width - 1; x++){
                		output[y*width+x] = 0.25f * (input[(y+1)*width + x] + input[(y-1)*width + x] +
				                   	     input[y*width + (x+1)] + input[y*width + (x-1)] - beta);

						    //alpha * input[y*width + x] +
						    //0.25f * (input[(y+1)*width + x] + input[(y-1)*width + x] +
						    //				                   	     input[y*width + (x+1)] + input[y*width + (x-1)] - beta);
    			}
    		}   
    	
    	swap(output,input);
    	//#pragma omp parallel for
    	//for (int y = 1; y < height - 1; y++){
    	//	for (int x = 1; x < width - 1; x++){
	//			input[y*width+x] = output[y*width+x];
	//		}
	//	}
	}
	//swap(output,input);
	if(T_MAX%2==0)
	   memcpy(input,output,width*height*sizeof(int));
}

int main(int argc, char **argv){
	int width;
	int height;
	int T_MAX;
	int nthreads;

	float *inputGrid;
	float *outputGrid;
	float alpha,beta;

	if (argc != 5){
		printf ("Wrong number of parameters.\n");
		printf ("Usage: jacobi WIDTH HEIGHT ITERATIONS NTHREADS\n");
		exit (-1);
	}

	width = atoi (argv[1]);
	height = atoi (argv[2]);
	T_MAX = atoi (argv[3]);
	nthreads = atoi (argv[4]);
	alpha = 0.25/(float) width;
    	beta = 1.0/(float) height;

	tbb::task_scheduler_init init(nthreads); // (tbb::task_scheduler_init::automatic);
	
	inputGrid = (float*) malloc(width*height*sizeof(float));
	outputGrid = (float*) malloc(width*height*sizeof(float));

	#pragma omp parallel for
	for(int j=0;j<height;j++) {
		for(int i=0;i<width;i++) {
			inputGrid[j*width + i] = 1. + i*0.1 + j*0.01;
		}
	}
  
	//#pragma pskel stencil dim2d(width,height) inout(inputGrid, outputGrid) iterations(T_MAX) device(gpu)
	hr_timer_t timer;
	hrt_start(&timer);

	//stencilKernel(inputGrid, outputGrid,width,height,T_MAX,alpha,beta);
	TBBStencil jacobi(inputGrid,outputGrid,width,height); 
    //TBBStencil::setValues(inputGrid, outputGrid, width, height);	
	for(int it = 0; it < T_MAX; it++){
		tbb::parallel_for(tbb::blocked_range<size_t>(1, height-1), jacobi);
		jacobi.swap();	
    	}
	if(T_MAX%2==0){
		jacobi.swap();
	}
	hrt_stop(&timer);
	cout << "Exec_time\t" << hrt_elapsed_time(&timer) << endl;  
	return 0;
}
