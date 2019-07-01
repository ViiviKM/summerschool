program hello
  use omp_lib
  use mpi
  implicit none
  integer :: my_id, tid, rc
  integer :: provided, required=MPI_THREAD_FUNNELED
  integer :: omp_rank

  ! TODO: Initialize MPI with thread support. 
  call mpi_init_thread(required, provided, rc)

  
  ! TODO: Find out the MPI rank and thread ID of each thread and print
  !       out the results.
  !$omp parallel private(omp_rank)
  call mpi_comm_rank(mpi_comm_world, my_id, rc)
  omp_rank = omp_get_thread_num()
  
  print *, 'Hello world! by thread ', omp_rank, &
       ' process: ', my_id
  

  ! TODO: Investigate the provided thread support level.

  !$omp end parallel
  call MPI_Finalize(rc)
  
end program hello
