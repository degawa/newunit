program check
    use, intrinsic :: iso_fortran_env
    use :: newunit
    implicit none

    integer(int32), parameter :: tries = 100
        !! number of tries

    integer(int32) :: unit_number
    logical :: opened, failed
    integer(int32) :: i

    failed = .false.
    do i = 1, tries
        unit_number = get_newunit_number()
        inquire (unit=unit_number, opened=opened)
        failed = failed .or. opened
    end do

    if (failed) then
        print *, "Failed: `get_newunit_number` returned already opened unit"
        error stop
    else
        print *, "Passed: `get_newunit_number` returned unopend unit number"
    end if
end program check
