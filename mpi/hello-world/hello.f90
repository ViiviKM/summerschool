program hello
  use mpi
  implicit none

  integer :: rc
  integer :: rank, size
  
  call MPI_Init(rc)

  call Mpi_Comm_rank(MPI_COMM_WORLD, rank, rc)
  
  write(*,*) 'Hello world'
  write(*,*) rank

  ! printing number of processes
  if (rank == 0) then
     call MPI_Comm_size(MPI_COMM_WORLD, size, rc)
     write(*,*) size
  end if

  call MPI_Finalize(rc)

end program hello
