#include <utils.h>

void cudaDeviceInit()
{
    int devCount;
    cudaGetDeviceCount(&decCount);
    if(devCount == 0){
        printf("No CUDA capable dices detected.\n");
        exit(EXIT_FAILURE);
    }

    int device = 0;
    bool ok = false;
    while(device < devCount && !ok){
        cudaDeviceProp props;
        cudaGetDeviceProperties(&props, device);
        if(props.major > 1 || (props.major == 1 && props.minor > 2)){
            ok = true;
        }
        else{
            ++device;
        }
    }
    if(device == devCount){
        printf("No device above 1.2 compute capability detected.\n");
        exit(EXIT_FAILURE);
    }
    else{
        cudaSetDevice(device);
    }
}

__global__  void vecAdd(float* A, float* B, float* C)
{
    // threadIdx.x is a built-in variable provided by CUDA at runtime
    int i = blockIdx.x * blockDim.x + threadIdx.x;
    C[i] = A[i] + B[i];
}

void __cudaSafeCall(cudaError_t err, const char *file, int line)
{
    if ((err) != cudaSuccess)
    {
        fprintf(stderr, "CUDA error in file %s at line %i: %s.\n", file, line, cudaGetErrorString(err));
        exit(EXIT_FAILURE);
    }
}
