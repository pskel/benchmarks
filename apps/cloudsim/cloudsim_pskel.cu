//#define PSKEL_OMP 1
//#define PSKEL_TBB 1
#define PSKEL_CUDA 1
#define CLOUDSIM_KERNEL

#include <stdio.h>
#include <omp.h>
#include <iostream>
#include <time.h>
#include <stdlib.h>
#include <math.h>
#include <fstream>
#include <string>
#include <sys/stat.h>
#include <algorithm>

#include "../../pskel/include/PSkel.h"
#include "../../pskel/include/hr_time.h"

using namespace std;
using namespace PSkel;

#define WIND_X_BASE	15
#define WIND_Y_BASE	12
#define DISTURB		0.1f
#define CELL_LENGTH	0.1f
#define K           0.0243f
#define DELTAPO     0.5f
#define TAM_VETOR_FILENAME  200

struct Cloud{	
	//Args2D<double> wind_x, wind_y;
	Array2D<double> wind_x;
	Array2D<double> wind_y;
	double deltaT;
	
	Cloud(){};
	
	Cloud(int linha, int coluna){		
		//new (&wind_x) Args2D<double>(linha, coluna);
		//new (&wind_y) Args2D<double>(linha, coluna);
		new (&wind_x) Array2D<double>(linha, coluna);
		new (&wind_y) Array2D<double>(linha, coluna);
	}
};

namespace PSkel{	
__parallel__ void stencilKernel(Array2D<double> input,Array2D<double> output,Mask2D<double> mask,Cloud cloud,size_t i, size_t j){
	int numNeighbor = 0.25f;
	double sum;
	double inValue = input(i,j);
           
        double xwind = cloud.wind_x(i,j);
        double ywind = cloud.wind_y(i,j);
        int xfactor = (xwind>0)?1:-1;
        int yfactor = (ywind>0)?1:-1;
	
        sum =   (inValue - input(i-1,j) ) + (inValue - input(i,j-1) ) +
                (inValue - input(i,j+1) ) + (inValue - input(i+1,j) );
       	//sum = 4 * inValue - ( input(i-1,j) + input(i+1,j) + input(i,j+1) + input(i,j-1) );
         
        double temperaturaNeighborX = input(i,(j+xfactor));
       	double temperaturaNeighborY = input((i+yfactor),j);
        
        double componenteVentoY = yfactor * ywind;
     	double componenteVentoX = xfactor * xwind;
        
        double temp_wind = (-componenteVentoX * ((inValue - temperaturaNeighborX)*10.0f)) -
                          ( componenteVentoY * ((inValue - temperaturaNeighborY)*10.0f));
        	
		/*
		double temp_wind = 0.0f;
		int height=input.getHeight();
        int width=input.getWidth();
        if ( (j == 0) && (i == 0) ) {
            sum = (inValue - input(i+1,j) ) +
                  (inValue - input(i,j+1) );
            numNeighbor = 2;
        }	//	Corner 2	
        else if ((j == 0) && (i == width-1)) {
            sum = (inValue - input(i-1,j) ) +
                  (inValue - input(i,j+1) );
            numNeighbor = 2;
        }	//	Corner 3	
        else if ((j == height-1) && (i == width-1)) {
            sum = (inValue - input(i-1,j) ) +
                  (inValue - input(i,j-1) );
            numNeighbor = 2;
        }	//	Corner 4	
        else if ((j == height-1) && (i == 0)) {
            sum = (inValue - input(i,j-1) ) +
                  (inValue - input(i+1,j) );
            numNeighbor = 2;
        }	//	Edge 1	
        else if (j == 0) {
            sum = (inValue - input(i-1,j) ) +
                  (inValue - input(i+1,j) ) +
                  (inValue - input(i,j+1) );
            numNeighbor = 3;
        }	//	Edge 2	
        else if (i == width-1) {
            sum = (inValue - input(i-1,j) ) +
                  (inValue - input(i,j-1) ) +
                  (inValue - input(i,j+1) );
            numNeighbor = 3;
        }	//	Edge 3	
        else if (j == height-1) {
            sum = (inValue - input(i-1,j) ) +
                  (inValue - input(i,j-1) ) +
                  (inValue - input(i+1,j) );
            numNeighbor = 3;
        }	//	Edge 4	
        else if (i == 0) {
            sum = (inValue - input(i,j-1) ) +
                  (inValue - input(i,j+1) ) +
                  (inValue - input(i+1,j) );
            numNeighbor = 3;
        }	//	Inside the cloud  
        else {
            sum = (inValue - input(i-1,j) ) +
                  (inValue - input(i,j-1) ) +
                  (inValue - input(i,j+1) ) +
                  (inValue - input(i+1,j) );
            numNeighbor = 4;
            
            double xwind = cloud.wind_x(i,j);
            double ywind = cloud.wind_y(i,j);
            int xfactor = (xwind>0)?1:-1;
            int yfactor = (ywind>0)?1:-1;

            double temperaturaNeighborX = input(i,(j+xfactor));
            double componenteVentoX = xfactor * xwind;
            double temperaturaNeighborY = input((i+yfactor),j);
            double componenteVentoY = yfactor * ywind;
        
            temp_wind = (-componenteVentoX * ((inValue - temperaturaNeighborX)/CELL_LENGTH)) -
                        ( componenteVentoY * ((inValue - temperaturaNeighborY)/CELL_LENGTH));
            
        }*/
        double temperatura_conducao = -K*(sum * numNeighbor) * cloud.deltaT;
        double result = inValue + temperatura_conducao;
        output(i,j) = result + temp_wind * cloud.deltaT;

		/*
        	for( int m = 0; m < mask.size ; m++ ){
			double temperatura_vizinho = mask.get(m,input,i,j);
			int factor = (temperatura_vizinho==0)?0:1;
			sum += factor*(inValue - temperatura_vizinho);
			numNeighbor += factor;
		}
		
        		
		double temperatura_conducao = -K*(sum / numNeighbor)*cloud.deltaT;
		
		double result = inValue + temperatura_conducao;
		
		double xwind = cloud.wind_x(i,j);
		double ywind = cloud.wind_y(i,j);
		int xfactor = (xwind>0)?3:1;
		int yfactor = (ywind>0)?2:0;

		double temperaturaNeighborX = mask.get(xfactor,input,i,j);
		double componenteVentoX = (xfactor-2)*xwind;
		double temperaturaNeighborY = mask.get(yfactor,input,i,j);
		double componenteVentoY = (yfactor-1)*ywind;
		
		double temp_wind = (-componenteVentoX * ((inValue - temperaturaNeighborX)/CELL_LENGTH)) -(componenteVentoY * ((inValue - temperaturaNeighborY)/CELL_LENGTH));
		
		output(i,j) = result + ((numNeighbor==4)?(temp_wind*cloud.deltaT):0.0f);
        */
	}	
}

/* Convert Celsius to Kelvin */
double Convert_Celsius_To_Kelvin(double number_celsius)
{
	double number_kelvin;
	number_kelvin = number_celsius + 273.15f;
	return number_kelvin;
}

/* Convert Pressure(hPa) to Pressure(mmHg) */
double Convert_hPa_To_mmHg(double number_hpa)
{
	double number_mmHg;
	number_mmHg = number_hpa * 0.750062f;

	return number_mmHg;
}

/* Convert Pressure Millibars to mmHg */
double Convert_milibars_To_mmHg(double number_milibars)
{
	double number_mmHg;
	number_mmHg = number_milibars * 0.750062f;

	return number_mmHg;
}

/* Calculate RPV */
double CalculateRPV(double temperature_Kelvin, double pressure_mmHg)
{
	double realPressureVapor; //e
	double PsychrometricConstant = 6.7f * powf(10,-4); //A
	double PsychrometricDepression = 1.2f; //(t - tu) in ºC
	double esu = pow(10, ((-2937.4f / temperature_Kelvin) - 4.9283f * log10(temperature_Kelvin) + 23.5470f)); //10 ^ (-2937,4 / t - 4,9283 log t + 23,5470)
	realPressureVapor = Convert_milibars_To_mmHg(esu) - (PsychrometricConstant * pressure_mmHg * PsychrometricDepression);

	return realPressureVapor;
}

/* Calculate Dew Point */
double CalculateDewPoint(double temperature_Kelvin, double pressure_mmHg)
{
	double dewPoint; //TD
	double realPressureVapor = CalculateRPV(temperature_Kelvin, pressure_mmHg); //e
	dewPoint = (186.4905f - 237.3f * log10(realPressureVapor)) / (log10(realPressureVapor) -8.2859f);

	return dewPoint;
}

int main(int argc, char **argv){
	int linha, coluna, i, j, timeTileSize,numero_iteracoes, raio_nuvem, menu_option, GPUBlockSizeX, GPUBlockSizeY, numCPUThreads;
	double temperaturaAtmosferica, pressaoAtmosferica, pontoOrvalho, limInfPO, limSupPO, deltaT, GPUTime;
	//double alturaNuvem;
    //int write_step;
	if (argc != 10){
		printf ("Wrong number of parameters.\n");
		//printf ("Usage: cloudsim Numero_Iteraoes Linha Coluna Raio_Nuvem Temperatura_Atmosferica Altura_Nuvem Pressao_Atmosferica Delta_T GPUTIME GPUBLOCKS CPUTHREADS Menu_Option Write_Step\n");
		printf ("Usage: cloudsim WIDTH HEIGHT ITERATIONS TIME_TILE_SIZE GPUTIME GPUBLOCK_X GPU_BLOCK_Y CPUTHREADS OUTPUT_WRITE_FLAG\n");
		exit (-1);
	}
	//20 -3 5.0 700.0 0.001 1.0 32 12 0 10
	
	coluna = atoi(argv[1]);
	linha = atoi(argv[2]);
	numero_iteracoes = atoi(argv[3]);
	timeTileSize = atoi(argv[4]);
	GPUTime = atof(argv[5]);
	GPUBlockSizeX = atoi(argv[6]);
	GPUBlockSizeY = atoi(argv[7]);
	numCPUThreads = atoi(argv[8]);
	menu_option = atoi(argv[9]);
	
	raio_nuvem = 20; 				//atoi(argv[4]);
	temperaturaAtmosferica = -3.0f; 	//atof(argv[5]);
	//alturaNuvem = 5.0; 				//atof(argv[6]);
	pressaoAtmosferica =  700.0f;		//atof(argv[7]);
	deltaT = 0.01f;					//atof(argv[8]);
	
	//numThreads = numCPUThreads;
	//write_step = 10;				//atoi(argv[13]);
	
	//global_write_step = write_step;
	pontoOrvalho = CalculateDewPoint(Convert_Celsius_To_Kelvin(temperaturaAtmosferica), Convert_hPa_To_mmHg(pressaoAtmosferica));
	limInfPO = pontoOrvalho - DELTAPO;
	limSupPO = pontoOrvalho + DELTAPO;
	//char maindir[30];
	//char dirname[TAM_VETOR_FILENAME];
	//char dirMatrix_temp[TAM_VETOR_FILENAME];
	//char dirMatrix_stat[TAM_VETOR_FILENAME];
	//char dirMatrix_windX[TAM_VETOR_FILENAME];
	//char dirMatrix_windY[TAM_VETOR_FILENAME];
	//double start_time = 0;
	//double end_time = 0;
		
	Array2D<double> inputGrid(coluna, linha);
	Array2D<double> outputGrid(coluna, linha);
	Mask2D<double> mask(4);
	
	mask.set(0,0,1);
	mask.set(1,1,0);
	mask.set(2,0,-1);
	mask.set(3,-1,0);
	
	Cloud cloud(linha,coluna);
	cloud.deltaT = deltaT;
	
	//omp_set_num_threads(numCPUThreads);

	/* Inicialização da matriz de entrada com a temperatura ambiente */
	//#pragma omp parallel for private (i,j)
	for (i = 0; i < linha; i++){		
		for (j = 0; j < coluna; j++){
			inputGrid(i,j) = temperaturaAtmosferica;
			//outputGrid(i,j) = temperaturaAtmosferica;
		}
	}	
	/* Inicialização dos ventos Latitudinal(Wind_X) e Longitudinal(Wind_Y) */
    	srand(1234);
	for( i = 0; i < linha; i++ ){
		for(j = 0; j < coluna; j++ ){			
			cloud.wind_x(i,j) = (WIND_X_BASE - DISTURB) + (double)rand()/RAND_MAX * 2 * DISTURB;
			cloud.wind_y(i,j) = (WIND_Y_BASE - DISTURB) + (double)rand()/RAND_MAX * 2 * DISTURB;		
		}
	}
	
	//Forcing copy
	if(GPUTime > 0){
		cloud.wind_x.deviceAlloc();
		cloud.wind_x.copyToDevice();
		cloud.wind_y.deviceAlloc();
		cloud.wind_y.copyToDevice();	
	}
					
	/* Inicialização de uma nuvem no centro da matriz de entrada */
	srand(1);
	int y, x0 = linha/2, y0 = coluna/2;
	for(i = x0 - raio_nuvem; i < x0 + raio_nuvem; i++){
		 // Equação da circunferencia: (x0 - x)² + (y0 - y)² = r²
		y = (int)((floor(sqrt(pow((double)raio_nuvem, 2.0) - pow(((double)x0 - (double)i), 2)) - y0) * -1));
		for(int j = y0 + (y0 - y); j >= y; j--){
			inputGrid(i,j) = limInfPO + (double)rand()/RAND_MAX * (limSupPO - limInfPO);
			//outputGrid(i,j) = limInfPO + (double)rand()/RAND_MAX * (limSupPO - limInfPO);
		}
	}
	
    #ifdef PSKEL_PAPI
		if(GPUTime < 1.0)
			PSkelPAPI::init(PSkelPAPI::CPU);
	#endif
    
    	hr_timer_t timer;
	hrt_start(&timer);
    
	Stencil2D<Array2D<double>, Mask2D<double>, Cloud> stencilCloud(inputGrid, outputGrid, mask, cloud);
	
	if(GPUTime == 0.0){
		//cout<<"Running Iterative CPU"<<endl;
		//if(numCPUThreads == 1)
		//	stencilCloud.runSequential();
		//else
		//	stencilCloud.runIterativeCPU(numero_iteracoes, numCPUThreads);
            
        #ifdef PSKEL_PAPI
            for(unsigned int i=0;i<NUM_GROUPS_CPU;i++){
			PSkelPAPI::papi_start(PSkelPAPI::CPU,i);
		#endif
			//stencilCloud.runIterativeCPU(numero_iteracoes, numCPUThreads);	
		#ifdef PSKEL_PAPI
			PSkelPAPI::papi_stop(PSkelPAPI::CPU,i);
            }
		#endif
	}
	else if(GPUTime == 1.0){
		//Forcing copy
		//cloud.wind_x.deviceAlloc();
		//cloud.wind_x.copyToDevice();
		//cloud.wind_y.deviceAlloc();
		//cloud.wind_y.copyToDevice();
        #ifdef PSKEL_SHARED	
            stencilCloud.runIterativeGPU(numero_iteracoes, timeTileSize,GPUBlockSizeX, GPUBlockSizeY);
        #else
            stencilCloud.runIterativeGPU(numero_iteracoes, GPUBlockSizeX, GPUBlockSizeY);
        #endif
	}
	else{
		//stencilCloud.runIterativePartition(numero_iteracoes, GPUTime, numCPUThreads,GPUBlockSizeX, GPUBlockSizeY);
	}
	
	hrt_stop(&timer);
    
	if(menu_option == 1){
		cout.precision(6);
		cout<<std::fixed;
		cout<<"INPUT"<<endl;
		for( i = 0; i < linha; i++ ){
                	for(j = 0; j < coluna; j++ ){
				cout<<inputGrid(i,j)<<"\t";
			}
			cout<<endl;
		}
	
	/*
		for(int i=10; i<coluna;i+=10){
			cout<<"("<<i<<","<<i<<") = "<<inputGrid(i,i)<<"\t\t("<<coluna-i<<","<<linha-i<<") = "<<inputGrid(coluna-i,linha-i)<<endl;
		}
		cout<<endl;
		
		cout<<"OUTPUT"<<endl;
		for(int i=10; i<coluna;i+=10){
			cout<<"("<<i<<","<<i<<") = "<<outputGrid(i,i)<<"\t\t("<<coluna-i<<","<<linha-i<<") = "<<outputGrid(coluna-i,linha-i)<<endl;
		}
		cout<<endl;
		*/
		cout<<"OUTPUT"<<endl;
		for(int h = 0; h < linha; ++h){		
			for(int w = 0; w < coluna; ++w){
				cout<<outputGrid(h,w)<<"\t";
			}
			cout<<endl;
		}
	}
	#ifdef PSKEL_PAPI
		if(GPUTime < 1.0){
			PSkelPAPI::print_profile_values(PSkelPAPI::CPU);
			PSkelPAPI::shutdown();
		}
	#endif
	cout << "Exec_time\t" << hrt_elapsed_time(&timer) << endl;
	
	return 0;
}

