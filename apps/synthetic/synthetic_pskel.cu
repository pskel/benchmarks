#define TIME 1
//#define PSKEL_LOGMODE 1
//#define TBB_USE_DEBUG 1

#define PSKEL_CUDA

#include "PSkel.h"
#include "hr_time.h"
#include <omp.h>
#include <fstream>
#include <string>
#include <stdio.h>
#include <iostream>
#include <sstream> 
#include <cmath>
#include <cassert>


#ifndef PSKEL_NEUMAN
	#ifndef PSKEL_MOORE
		#define PSKEL_NEUMAN
	#endif
#else
#ifndef PSKEL_MOORE
	#ifndef PSKEL_NEUMAN
		#define PSKEL_MOORE
	#endif
#endif
#endif


using namespace std;
using namespace PSkel;

struct Arguments{
	//int neighborhood, radius, numAdd, numSub, numMult, numDiv, numPow, numSqrt, numFma;
	int numAdd, numMult,radius;

	Arguments(){
		//neighborhood = 0;
		radius = 2;
		numAdd = 10;
		//numSub = 0;
		numMult = 0;
		//numDiv = 0;
		//numPow = 0;
		//numSqrt = 0;
		//numFma = 0;
	}

	//Arguments(int nb, int r, int nAdd, int nSub, int nMult, int nDiv, int nPow, int nSqrt, int nFma){
    	Arguments(int r, int nAdd, int nMult){
		//neighborhood = nb;
		radius = r;
		numAdd = nAdd;
		//numSub = nSub;
		numMult = nMult;
		//numDiv = nDiv;
		//numPow = nPow;
		//numSqrt = nSqrt;
		//numFma = nFma;
	}
};

namespace PSkel{
	#ifdef PSKEL_INT
	__parallel__ void stencilKernel(Array2D<int> input,Array2D<int> output,Mask2D<int> mask,Arguments args, size_t h, size_t w){
		int returnValue = input(h,w);
	#else
	__parallel__ void stencilKernel(Array2D<float> input,Array2D<float> output,Mask2D<float> mask,Arguments args, size_t h, size_t w){
		float  returnValue = input(h,w);
	#endif

		int loopControl;
		int opControl;
		int i,j,k,fim,ini;

		loopControl = args.numAdd > 0 ? (args.numAdd-1)/mask.size + 1 : 0; //estava assim originalmente
		//opControl = args.numAdd > mask.size ? mask.size : args.numAdd;
		opControl = args.numAdd > 0 ? args.radius : 0;


		
		#ifdef PSKEL_NEUMAN
		for(int i = 0; i < loopControl; i++){    
        		fim = 0;
        		ini = 0;
        		k = 0;
        		for (j = -opControl; j <= 0; j++) {
            			for(k = ini; k <= fim; k++){
                			//if(j != 0 || k !=0){
                                       		returnValue = returnValue + input(h+j,w+k);	
                			//}
            			}
            			ini--;
            			fim++;                
        		}        
        		ini+=2;
        		fim-=2;
        
        		for(j = 1; j <= opControl; j++){
             			for(k = ini; k <= fim; k++){
                	      		returnValue = returnValue + input(h+j,w+k);		
				}
            			ini++;
            			fim--;
        		}
    		}

		#else
		#ifdef PSKEL_MOORE
		
		//Adição
		//loopControl = ceil(float(args.numAdd)/float(mask.size));
		//loopControl = args.numAdd > 0 ? (args.numAdd-1)/mask.size + 1 : 0; //estava assim originalmente
		//opControl = args.numAdd > mask.size ? mask.size : args.numAdd;
		//opControl = args.numAdd > 0 ? args.radius : 0;

		//loopControl = loopControl/2;
		//printf("Executing ADD loopControl: %d opControl: %d\n",loopControl,opControl);
		for(i = 0; i<loopControl; i++){
		//for(int i = -loopControl; i <= loopControl; i++){
			for(j = -opControl;j <= opControl; j++){
				for(k = -opControl; k <= opControl; k++){  //for(int k = 0; k < opControl; k++){
					//returnValue = returnValue + mask.get(j,input,h,w);
					//returnValue = returnValue + mask.getWeight(j);
					returnValue = returnValue + input(h+j,w+k);
				}
			}
		}
		#endif
		#endif
		

		//Multiplicação
		//loopControl = ceil(float(args.numMult)/float(mask.size));
		loopControl = args.numMult > 0 ? (args.numMult-1)/mask.size + 1 : 0;
		//opControl = args.numMult > mask.size ? mask.size: args.numMult;
		opControl = args.numMult > 0 ? args.radius : 0;
		
		//loopControl = loopControl/2;
		//printf("Executing MULT loopControl: %d opControl: %d\n",loopControl,opControl);

		#ifdef PSKEL_NEUMAN
		for(i = 0; i < loopControl; i++){    
        		fim = 0;
        		ini = 0;
        		k = 0;
        		for (j = -opControl; j <= 0; j++) {
            			for(k = ini; k<= fim; k++){
                			//if(j != 0 || k !=0){
                                       		returnValue = returnValue * input(h+j,w+k);	
                			//}
            			}
            			ini--;
            			fim++;                
        		}        
        		ini+=2;
        		fim-=2;
        
        		for(j = 1; j <= opControl; j++){
             			for(k = ini; k <= fim; k++){
                	      		returnValue = returnValue * input(h+j,w+k);		
				}
            			ini++;
            			fim--;
        		}
    		}

		#else
		#ifdef PSKEL_MOORE
		for(i = 0; i<loopControl; i++){
			for(j = -opControl; j <= opControl; j++){
				for(k = -opControl; k <= opControl; k++){
					//returnValue = returnValue * mask.get(j,input,h,w);
					//returnValue = returnValue * mask.getWeight(j);
					returnValue = returnValue * input(h+j,w+k);
				}
			}
		}		
		#endif
		#endif
		
		//Divisao
		/*loopControl = (args.numDiv-1)/mask.size + 1;
		opControl = args.numDiv>mask.size?mask.size:args.numDiv;
		for(int i = 0; i<loopControl; i++){
			for(int j = 0; j<opControl; j++){
				returnValue = returnValue / mask.get(j,input,h,w);
			}
		}

		*/

        	output(h,w) = returnValue;
		
	}
}

int main(int argc, char **argv){
    //hr_timer_t timer_a;
    //hrt_start(&timer_a);
    
    int width, height, iterations, maskType,maskRange,GPUBlockSize, numCPUThreads, maskSize,writeToFile;

    int nAdd, nMult;
    //int nSub, nDiv, nPow, nFma;
    float GPUTime;

    if (argc != 11){
        printf ("Wrong number of parameters.\n");
        //printf ("Usage: synthetic WIDTH HEIGHT ITERATIONS GPUTIME GPUBLOCKS CPUTHREADS MASKTYPE MASKRANGE NumADDS NumSUBS NumMults NumDivs NumPows NumSqrts NumFmas OUTPUT_WRITE_FLAG\n");

        printf ("Usage: synthetic WIDTH HEIGHT ITERATIONS GPUTIME GPUBLOCKS CPUTHREADS MASKRANGE NumADDS NumMults OUTPUT_WRITE_FLAG\n"); //Masktype is now defined from #ifdef
        exit(-1);
    }

    width = atoi (argv[1]);
    height = atoi (argv[2]);
    iterations = atoi (argv[3]);
    GPUTime = atof(argv[4]);
    GPUBlockSize = atoi(argv[5]);
    numCPUThreads = atoi(argv[6]);
    
    #ifdef PSKEL_NEUMAN
    maskType = 0;
    //cout<<"Neuman"<<endl;
    #else
    maskType = 1;
    //cout<<"Moore"<<endl;
    #endif

    maskRange = atoi (argv[7]); 
    nAdd = atoi(argv[8]) ;
    //nSub = 0; //atoi(argv[10]);
    nMult = atoi(argv[9]) ;
    //nDiv = 0; //atoi(argv[12]);
    //nPow = 0; //atoi(argv[13]);
    //nSqrt = 0; //atoi(argv[14]);
    //nFma = 0; //atoi(argv[15]);
    writeToFile = atoi(argv[10]);
    
    if(nAdd == 0 && nMult == 0){
	printf("The number of Adds and Mults are 0!\n");
	exit(-1);
    }

    #ifdef PSKEL_INT
    Array2D<int> inputGrid(width, height);
    Array2D<int> outputGrid(width, height);
    #else
    Array2D<float> inputGrid(width, height);
    Array2D<float> outputGrid(width, height);	
    #endif

    /*for(int h=0; h<inputGrid.getHeight(); h++)
        for(int w=0; w<inputGrid.getWidth(); w++)
            inputGrid(h,w) = h*inputGrid.getWidth()+w;
    */

    #pragma omp parallel num_threads(numCPUThreads)
    {
        unsigned int seed = 1234 + 17 *  omp_get_thread_num();
        #pragma omp for
        for (int x = 0; x < height; x++){
            for (int y = 0; y < width; y++){		
                //#ifdef PSKEL_INT
                //inputGrid(x,y) = 1 + rand()%99;
                //outputGrid(x,y) = 1;
            //	#else
                inputGrid(x,y) = (1.0 + rand_r(&seed)%9) + 1.0/(1+rand_r(&seed)%100);
                outputGrid(x,y) = 1.0;
            //	#endif
            }
        }
    }

    //Calculate the mask size based on neighborhood type. 0 (zero) for Von Neumann >1 (more than one) for Moore.
    if(maskType == 0){
        //Neumann number 2r(r+1)+1,
        //maskSize = ((2 * args.radius)*args.radius) + (2 * args.radius) + 1;
        maskSize = 1 + ((2 * maskRange ) * ( maskRange + 1));		
    }else{ 
       //Moore (2r + 1)^2
        maskSize = (2 * maskRange + 1) * (2 * maskRange + 1);
    }

    //maskSize = number of cells in neighborhood - 1 (the center cell);
    #ifdef PSKEL_INT
    Mask2D<int> mask(maskSize - 1,1);
    #else
    Mask2D<float> mask(maskSize - 1,1.0);
    #endif

    nAdd = nAdd  * (maskSize - 1);
    //nSub = 0; //atoi(argv[10]);
    nMult = nMult * (maskSize - 1);
   //Arguments args(maskType, maskRange, nAdd, nSub, nMult, nDiv, nPow, nSqrt, nFma);

    Arguments args(maskRange,nAdd, nMult);
    srand(1234);

    //cout<<"MASK VALUES"<<endl;
    if(maskType == 0){
        //Set mask for Neumann neighborhood
        int idx = 0;        
        int fim = 0;
        int ini = 0;
        int w = 0;
        int h;

        for (h = -maskRange; h <= 0; h++) {
            for(w = ini; w <= fim; w++){
                if(h != 0 || w !=0){
                    float weight = 0.1*(1+rand()%8);
                    #ifdef PSKEL_INT
                        weight += 1 + rand()%3;
                    #endif		
                    mask.set(idx, h, w, weight);

                    //cout<<"["<<idx<<"] = "<<h<<","<<w<<" "<<weight<<endl;
                //cout << idx <<", "<< h <<", "<< w <<"\n";
                idx++;
                }
            }

            ini --;
            fim ++;                
        }        
        ini+=2;
        fim-=2;
        
        for(h = 1; h <= maskRange; h++){
             for(w = ini; w <= fim; w++){
                float weight = 0.1*(1+rand()%8);
                    #ifdef PSKEL_INT
                        weight += 1 + rand()%3;
                    #endif		

                mask.set(idx, h, w, weight);
                //cout<<"["<<idx<<"] = "<<h<<","<<w<< " "<<weight<<endl;
                idx++;
            }
            ini++;
            fim--;
        }
    }
    else{ 
        //Set mask for Moore neighborhood
        int idx = 0;
        int h, w;

        for(h = -maskRange; h <= maskRange; h++){
            for(w = -maskRange; w <= maskRange; w ++){
                if(h != 0 || w != 0){
                    float weight = 0.1*(1+rand()%8);
                    #ifdef PSKEL_INT
                        weight += 1 + rand()%3;
                    #endif		
                    mask.set(idx, h, w, weight);
                    //cout<<"["<<idx<<"] = "<<h<<","<<w<< " "<<weight<<endl;
                    idx ++;
                }
            }
        }
    }
    	
    cout <<"\n";
    cout << "Width: " << width << "; Height: " << height << ";\n";
    cout << "Iterations: " << iterations << endl;	
    cout << "MaskType: " << maskType << endl;
    cout << "MaskRange: " << maskRange << endl;
    cout << "Neighbors: "	 << mask.size << endl;
    cout << "GPU Time: " << GPUTime << endl;
    cout << "GPU Block size: " << GPUBlockSize << endl;
    cout << "CPU Threads: " << numCPUThreads << endl;
    cout << "Num Add: " << args.numAdd << endl;
    //cout << "Num Sub: " << args.numSub << endl;
    cout << "Num Mult: " << args.numMult << endl;
    //cout << "Num Div: " << args.numDiv << endl;	
    //cout << "Num Pow: " << args.numPow << endl;
    //cout << "Num Sqrt: " << args.numSqrt << endl;
    //cout << "Num Fma: " << args.numFma << endl;
    cout <<"\n";
    
            
    #ifdef PSKEL_INT
    Stencil2D<Array2D<int>, Mask2D<int>, Arguments> synthetic(inputGrid, outputGrid, mask, args);
    #else
    Stencil2D<Array2D<float>, Mask2D<float>, Arguments> synthetic(inputGrid, outputGrid, mask, args);
    #endif

    #ifdef PSKEL_PAPI
        if(GPUTime < 1.0)
            PSkelPAPI::init(PSkelPAPI::CPU);
    #endif

    //hrt_stop(&timer_a);
    //cout << "Init time: " << hrt_elapsed_time(&timer_a) << endl;
    //cout << "Executing" << endl;
    
    hr_timer_t timer;
    //double t1,t2;
    //t1 = omp_get_wtime();
    hrt_start(&timer);

    if(GPUTime == 0.0){
        #ifdef PSKEL_PAPI
        for(unsigned int i=0;i<NUM_GROUPS_CPU;i++){
            //cout << "Running iteration " << i << endl;
	    PSkelPAPI::papi_start(PSkelPAPI::CPU,i);
            synthetic.runIterativeCPU(iterations, numCPUThreads);	
	    PSkelPAPI::papi_stop(PSkelPAPI::CPU,i);
        }
        #else
            //cout<<"Running Iterative CPU"<<endl;
            synthetic.runIterativeCPU(iterations, numCPUThreads);	
        #endif
    }

    else if(GPUTime == 1.0){
        synthetic.runIterativeGPU(iterations, GPUBlockSize,GPUBlockSize);
    }
    else{
        #ifdef PSKEL_PAPI
        for(unsigned int i=0;i<NUM_GROUPS_CPU;i++){
            synthetic.runIterativePartition(iterations, GPUTime, numCPUThreads,GPUBlockSize,i);
        }
        #else
            synthetic.runIterativePartition(iterations, GPUTime, numCPUThreads,GPUBlockSize,GPUBlockSize);
        #endif
    }
    //t2 = omp_get_wtime();
    hrt_stop(&timer);		

    #ifdef PSKEL_PAPI
        cudaDeviceReset();
        if(GPUTime < 1.0){
            PSkelPAPI::print_profile_values(PSkelPAPI::CPU);
            PSkelPAPI::shutdown();
        }
    #endif

    cout << "Exec_time\t" << hrt_elapsed_time(&timer) << endl;
    //cout << "Exec_time_omp\t" << t2-t1 << endl;

    if(writeToFile == 1){
        cout.precision(12);
        cout<<"INPUT"<<endl;
        for(int i=10; i<width;i+=10){
            cout<<"("<<i<<","<<i<<") = "<<inputGrid(i,i)<<"\t\t("<<width-i<<","<<height-i<<") = "<<inputGrid(width-i,height-i)<<endl;
        }
        cout<<endl;
        
        cout<<"OUTPUT"<<endl;
        
        for(int i=10; i<width;i+=10){
            cout<<"("<<i<<","<<i<<") = "<<outputGrid(i,i)<<"\t\t("<<width-i<<","<<height-i<<") = "<<outputGrid(width-i,height-i)<<endl;
        }
        cout<<endl;
    }

    return 0;
}
