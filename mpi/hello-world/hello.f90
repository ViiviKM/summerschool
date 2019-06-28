program hello
  use mpi
  implicit none

  integer :: rc
  call MPI_Init(rc)

  write(*,*) 'Hello world'

  call MPI_Finalize(rc)

end program hello
