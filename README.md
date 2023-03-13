# newunit - a toy Fortran function to get a positive and an unopened unit number

Fortran's `newunit` feature returns a negative unit number.
This causes an error, so-called "out-of-range unit number," for some compilers, NAG Fortran and NEC Fortran, in my experience.

This module provides a function that returns a **positive** unit number not including `input_unit,` `output_unit,` and `error_unit` defined in the `iso_fortran_env` module.

This module is created primarily for avoiding and modifying errors locally during `get_getline.f90` in [stdlib](https://github.com/fortran-lang/stdlib) and `close_scratch_file` in [VTKFortran](https://github.com/szaghi/VTKFortran).

## usage
use the `newunit` module and call `get_newunit_number()` to get a unit number before opening a unit.

```Fortran
    use :: newunit
    implicit none

    integer(int32) :: unit_number

    unit_number = get_newunit_number()
    open (unit=unit_number, status="scratch")
    close (unit_number)
```

## get the code
To get the code, execute the following commnad:

```console
git clone https://github.com/degawa/newunit.git
cd newunit
```

or specifying the git repository as a dependency in `fpm.toml`.

```toml
[dependencies]
newunit = {git = "https://github.com/degawa/newunit.git"}
```
