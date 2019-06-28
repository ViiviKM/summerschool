program communicator
  use mpi
  implicit none

  ! definitions
  integer :: ierr, ntasks, rank
  integer, parameter :: length = 8
  integer, dimension(length) :: sendbuf, recvbuf
  
  call mpi_init(ierr)
  call mpi_comm_size(mpi_comm_world, ierr)
  
  
  
  
  call mpi_finalize(ierr)

  
contains
  
  subroutine initialise(sendbuf, recvbuf)
    implicit none
    integer :: i

    do i=1, length
       sendbuf = i - 1 +length*rank
       recvbuf = -1
    end do
  end subroutine initialise
  

end program communicator
