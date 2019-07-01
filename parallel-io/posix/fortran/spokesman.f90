program pario
  use mpi
  use, intrinsic :: iso_fortran_env, only : error_unit, output_unit
  implicit none

  integer, parameter :: datasize = 64, writer_id = 0
  integer :: rc, my_id, ntasks, localsize, i
  integer, dimension(:), allocatable :: localvector
  integer, dimension(datasize) :: fullvector
  integer :: status(mpi_status_size, datasize)
  !character :: fname = 'data.dat'

  call mpi_init(rc)
  call mpi_comm_size(mpi_comm_world, ntasks, rc)
  call mpi_comm_rank(mpi_comm_world, my_id, rc)

  if (ntasks > 64) then
     write(error_unit, *) 'Maximum number of tasks is 64!'
     call mpi_abort(MPI_COMM_WORLD, -1, rc)
  end if

  if (mod(datasize, ntasks) /= 0) then
     write(error_unit,*) 'Datasize (64) should be divisible by number of tasks'
     call mpi_abort(MPI_COMM_WORLD, -1, rc)
  end if

  localsize = datasize / ntasks
  allocate(localvector(localsize))

  localvector = [(i + my_id * localsize, i=1,localsize)]

  call single_writer()

  deallocate(localvector)
  call mpi_finalize(rc)

contains

  subroutine single_writer()
    implicit none

    ! TODO: Implement a function that writers the whole array of elements
    !       to a file so that single process is responsible for the file io
    
    
    
    if (my_id == writer_id) then
       do i = 1, ntasks -1
          call mpi_recv(fullvector(i*localvector), localsize, mpi_integer, i, &
           1, mpi_comm_world, status, rc)
       end do
       
       open(10, file="data.dat", status='replace', &
            form='unformatted', access="stream")
       write(10, pos=1) fullvector
       close(10)
       write(output_unit,'(A,I0,A)') 'Wrote ', size(fullvector), &
            & ' elements to file singlewriter.dat'

    else
       call mpi_send(localvector, localsize, mpi_integer, 0, &
            1, mpi_comm_world, rc)
    end if
    
  end subroutine single_writer

end program pario
