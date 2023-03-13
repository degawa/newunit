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

        opened = .true.; stat = -1
        do while (opened .or. stat /= 0)
            unit_number = random_like_positive_number_int32()

            if (any([unit_number <= 0, &
                     unit_number == input_unit, &
                     unit_number == output_unit, &
                     unit_number == error_unit])) &
                cycle

            inquire (unit=unit_number, opened=opened, iostat=stat)
            ! retry if unit_number have already been opened or inquire failed
        end do
    contains
        function random_like_positive_number_int32() result(num)
            integer(int32) :: num
                !! pseudorandom-like number

            block
                real(real64) :: rand
                call random_number(rand)

                ! converting upper 32 bits of 64-bit floating-point number to an integer
                num = transfer(rand, mold=unit_number)
            end block

            block
                integer(int32) :: sign_bit
                sign_bit = bit_size(num) - 1 ! 0-origin

                ! set the sign bit to zero for converting to a positive value.
                ! the abs() is not used because the absolute value cannot obtain
                ! when unit_number = -2147483648.
                num = ibclr(i=num, pos=sign_bit)
            end block
        end function random_like_positive_number_int32
    end function get_newunit_number
end module newunit
