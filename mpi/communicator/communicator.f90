program communicator
  use mpi
  implicit none

  ! definitions
  integer :: ierr, ntasks, rank, color
  integer, parameter :: length = 8
  integer, dimension(length) :: sendbuf, recvbuf
  integer, dimension(length**2) :: printbuf
  integer :: newcomm
  
  call mpi_init(ierr)
  call mpi_comm_size(mpi_comm_world, ntasks, ierr)
  call mpi_comm_rank(MPI_COMM_WORLD, rank, ierr)
  
  call initialise
  
  ! divide ranks 0, 1 into one group, 2, 3 into one group
  if (rank < 2) then
     color = 1
  else
     color = 2
  end if
  
  call mpi_comm_split(MPI_COMM_WORLD, color, rank, newcomm, ierr)

  call mpi_reduce(sendbuf, recvbuf, length, MPI_INTEGER, MPI_SUM, &
       0, newcomm, ierr)
  
  call print_buffers(recvbuf)
  
  call mpi_finalize(ierr)

  
contains
  
  subroutine initialise
    implicit none
    integer :: i
    ! initialises the buffers to 0 to 31 or -1
    do i=1, length
       sendbuf(i) = i +length*rank -1
       recvbuf(i) = -1
    end do
  end subroutine initialise

  subroutine print_buffers(buffer)
    implicit none
    integer, dimension(:), intent(in) :: buffer
    integer, parameter :: bufsize = length
    integer :: i
    character(len=40) :: pformat
    ! prints the buffer
    write(pformat,'(A,I3,A)') '(A4,I2,":",', bufsize, 'I3)'
    
    call mpi_gather(buffer, bufsize, MPI_INTEGER, &
         & printbuf, bufsize, MPI_INTEGER, &
         & 0, MPI_COMM_WORLD, ierr)
    
    if (rank == 0) then
       do i = 1, ntasks
          write(*,pformat) 'Task', i - 1, printbuf((i-1)*bufsize+1:i*bufsize)
       end do
       print *
    end if 
      
  end subroutine print_buffers

end program communicator
