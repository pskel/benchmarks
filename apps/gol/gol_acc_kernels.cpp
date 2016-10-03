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

using namespace std;

void stencilKernel(float *input, float *output, int width, int height, int T_MAX){
    #pragma acc data copy(input[0:width*height]) create(output[0:width*height])
    {
	for(int t=0;t<T_MAX/2;t++){
        #pragma acc kernels
        {
        #pragma acc loop independent vector(16)
        for(int j=0;j<height;j++){
            #pragma acc loop independent vector(16)
            for(int i=0;i<width;i++){
                float nw = ((j-1)>=0 && (i-1)>=0)    ? input[(j-1)*width + (i-1)] : 0;
                float n  = ((j-1)>=0)                ? input[(j-1)*width + (i  )] : 0;
                float ne = ((j-1)>=0 && (i+1)<width) ? input[(j-1)*width + (i+1)] : 0;
                float w  = ((i-1)<width)             ? input[(j  )*width + (i-1)] : 0;
                //bool c  =                             input[(j  )*width + (i  )];
                float e  = ((i+1)<width)             ? input[(j  )*width + (i+1)] : 0;
                float sw = ((j+1)<height && (i-1)>=0)? input[(j+1)*width + (i-1)] : 0;
                float s  = ((j+1)<height)            ? input[(j+1)*width + (i  )] : 0;
                float se = ((j+1)>=0 && (i+1)<width) ? input[(j+1)*width + (i+1)] : 0;
                
                float sum = nw + n + ne + w + e + sw + s + se;
                
                output[j*width + i] = (sum == 3.0f || (sum == 2.0f && input[(j)*width + (i)]==1.0f))?1.0f:0.0f;
		}
	}
        
	#pragma acc loop independent vector(16)
	for(int j=0;j<height;j++){
	    #pragma acc loop independent vector(16)
            for(int i=0;i<width;i++){
                float nw = ((j-1)>=0 && (i-1)>=0)    ? input[(j-1)*width + (i-1)] : 0;
                float n  = ((j-1)>=0)                ? input[(j-1)*width + (i  )] : 0;
                float ne = ((j-1)>=0 && (i+1)<width) ? input[(j-1)*width + (i+1)] : 0;
                float w  = ((i-1)<width)             ? input[(j  )*width + (i-1)] : 0;
                //bool c  =                             input[(j  )*width + (i  )];
                float e  = ((i+1)<width)             ? input[(j  )*width + (i+1)] : 0;
                float sw = ((j+1)<height && (i-1)>=0)? input[(j+1)*width + (i-1)] : 0;
                float s  = ((j+1)<height)            ? input[(j+1)*width + (i  )] : 0;
                float se = ((j+1)>=0 && (i+1)<width) ? input[(j+1)*width + (i+1)] : 0;
                
                float sum = nw + n + ne + w + e + sw + s + se;
                
                output[j*width + i] = (sum == 3.0f || (sum == 2.0f && input[(j)*width + (i)] == 1.0f))?1.0f:0.0f;
	    }
	}
   //swap
   /*    
    if(T_MAX>1 & t<T_MAX - 1){
    #pragma acc loop independent vector(8)
    for(int j=0;j<height;j++){
            #pragma acc loop independent vector(32)
            for(int i=0;i<width;i++){
                 input[j*width + i] = output[j*width + i];
                }
        }
	}*/
    }// iterations
	}//kernels
    }//acc data
}//stencil kernel

int main(int argc, char **argv){
	int width;
	int height;
	int T_MAX;
    int verbose;

	float *inputGrid;
	float *outputGrid;

	if (argc != 5){
		printf ("Wrong number of parameters.\n");
		printf ("Usage: gol WIDTH HEIGHT ITERATIONS VERBOSE\n");
		exit (-1);
	}

	width = atoi (argv[1]);
	height = atoi (argv[2]);
	T_MAX = atoi (argv[3]);
    verbose = atoi (argv[4]);

	inputGrid = (float*) calloc(width*height,sizeof(float));
	outputGrid = (float*) calloc(width*height,sizeof(float));

	srand(123456789);
	for(int j=1;j<height-1;j++) {
		for(int i=1;i<width-1;i++) {
			inputGrid[j*width + i] = (float) (rand()%2);
		}
	}
    
    if(verbose){
        cout<<"INPUT"<<endl;
        for(int j=0;j<height;j++) {
            for(int i=0;i<width;i++) {
                cout<<inputGrid[j*width + i];
            }
            cout<<endl;
        } 
    }
    
    hr_timer_t timer;
	hrt_start(&timer);
	//#pragma pskel stencil dim2d(width, height) inout(inputGrid, outputGrid) iterations(T_MAX) device(cpu)
	stencilKernel(inputGrid, outputGrid,width,height,T_MAX);
    
    
	hrt_stop(&timer);
	
	if(verbose){		
		//cout<<setprecision(6);
		//cout<<fixed;
		/*cout<<"INPUT"<<endl;
		for(int i=0; i<width;i+=10){
            
			cout<<"("<<i<<","<<i<<") = "<<inputGrid[i*width+i]<<"\t\t(";
            cout<<width-i<<","<<height-i<<") = "<<inputGrid[(height-i)*width+(width-i)]<<endl;
		}
		cout<<endl;
		*/
		cout<<"OUTPUT"<<endl;
		//for(int i=0; i<width/10;i+=10){
		//	cout<<"("<<i<<","<<i<<") = "<<outputGrid[i*width+i]<<"\t\t("<<width-i<<","<<height-i<<") = "<<outputGrid[(height-i)*width+(width-i)]<<endl;
		//}
		//cout<<endl;
		
		for(int h = 0; h < height; ++h){		
			for(int w = 0; w < width; ++w){
				cout<<inputGrid[h*width + w];
			}
			cout<<endl;
		}
	}
    cout << "Exec_time\t" << hrt_elapsed_time(&timer) << endl;
  
	return 0;
}
