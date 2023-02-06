program demo
    use, intrinsic :: iso_fortran_env
    use :: newunit
    implicit none

    integer(int32) :: unit_number

    unit_number = get_newunit_number()
    open (unit=unit_number, status="scratch")
    close (unit_number)
end program demo
