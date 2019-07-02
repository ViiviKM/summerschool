program communication
  use mpi
  use omp_lib
  implicit none
  integer :: rc, tid, tidtag, i
  integer :: required, mpi_thread_multiple

  call mpi_init_thread(required, mpi_thread_multiple, rc)
  
  !$omp parallel private(tid, tidtag, rc)

  tid = omp_get_thread_num()
  tidtag = 2**10+tid

  ! task 0 sends to others

  !$omp task single
  call mpi_send(tid, 1, mpi_real, )
  !$omp end task
  
  ! other tasks receive the thread id of the corresponding

  !$omp end parallel
  call mpi_finalize(rc)

end program communication
