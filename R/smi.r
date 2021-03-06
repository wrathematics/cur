#' System Management Interface
#' 
#' A weak clone of the system utility \code{nvidia-smi}. Only uses the package's
#' public R interface. For a real \code{nvidia-smi}-like interface, see the
#' nvsmi package, which uses NVML.
#' 
#' @export
smi = function()
{
  count = cudaGetDeviceCount()
  if (count == 0)
    stop("no gpu's detected\n")
  
  old_gpu = cudaGetDevice()
  
  for (gpu in 0:(count-1L))
  {
    cudaSetDevice(gpu)
    mem = cudaMemGetInfo()
    used = (mem$total - mem$free) / (1024L*1024L)
    total = mem$total / (1024L*1024L)
    
    cat(sprintf("Device %2d", gpu))
    cat(sprintf(" (%.2f/%.2f MiB)", used, total))
    cat("\n")
  }
  
  cudaSetDevice(old_gpu)
  invisible()
}
