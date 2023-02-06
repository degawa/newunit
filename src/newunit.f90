module newunit
    use, intrinsic :: iso_fortran_env
    implicit none
    private
    public :: get_newunit_number

contains
    !>Returns a positive and an unopened unit number.
    function get_newunit_number() result(unit_number)
        implicit none
        integer(int32) :: unit_number
            !! new unit number

        integer(int32) :: stat
        logical :: opened
        real(real64) :: rand

        opened = .true.; stat = -1
        do while (opened .or. stat /= 0)
            call random_number(rand)

            ! converting upper 32 bits of 64-bit floating-point number to an integer
            unit_number = abs(transfer(rand, mold=unit_number))

            if (any([unit_number <= 0, & ! consider unit_number = -2147483648
                     unit_number == input_unit, &
                     unit_number == output_unit, &
                     unit_number == error_unit])) &
                cycle

            inquire (unit=unit_number, opened=opened, iostat=stat)
            ! retry if unit_number have already been opened or inquire failed
        end do
    end function get_newunit_number
end module newunit
