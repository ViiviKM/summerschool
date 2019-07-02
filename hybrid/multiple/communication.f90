program communication
  use mpi
  use omp_lib
  implicit none
  integer :: rc, tid, tidtag, i, msg
  integer :: provided, ntasks, my_id

  call mpi_init_thread(mpi_thread_multiple, provided, rc)

  call mpi_comm_size(mpi_comm_world, ntasks, rc)
  call mpi_comm_rank(mpi_comm_world, my_id, rc)
  
  !$omp parallel default(shared) private(msg,tid, tidtag, i)

  tid = omp_get_thread_num()
  tidtag = 1000+tid

  ! rank 0 all threads send to other rank's threads

  if (my_id == 0) then
     do i = 1, ntasks-1
        call mpi_send(tid, 1, mpi_integer, i, tidtag, mpi_comm_world, rc)
     end do
  
  ! other ranks threads receive the thread id of the corresponding ranks threads
  else
     call mpi_recv(msg, 1, mpi_integer, 0, tidtag, mpi_comm_world, &
          mpi_status_ignore, rc)
     write(*,'(A,I3,A,I3,A,I3)') 'Rank=', my_id, ' thread=', tid, &
          & ' received ', msg
  end if
  
  !$omp end parallel
  call mpi_finalize(rc)

end program communication
