program hello
  use omp_lib
  use mpi
  implicit none
  integer :: my_id, tid, rc
  integer :: provided, required=MPI_THREAD_FUNNELED
  integer :: omp_rank

  call MPI_init(rc)
  
  !$omp parallel private(omp_rank)
  omp_rank = omp_get_thread_num()
  print *, 'Hello world! by thread ', omp_rank



  ! TODO: Initialize MPI with thread support. 
  ! TODO: Find out the MPI rank and thread ID of each thread and print
  !       out the results.

  ! TODO: Investigate the provided thread support level.

  !$omp end parallel
  call MPI_Finalize(rc)
  
end program hello
