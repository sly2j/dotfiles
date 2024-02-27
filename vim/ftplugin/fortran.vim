let s:extfname = expand("%:e")
if s:extfname ==? "f90"
  let fortran_free_source=1
  unlet! fortran_fixed_source
else
  let fortran_fixed_source=1
  unlet! fortran_free_source
endif

setlocal tabstop=2
setlocal softtabstop=2
setlocal shiftwidth=2
setlocal textwidth=72
setlocal smarttab
setlocal expandtab
setlocal smartindent
setlocal autoindent

let fortran_do_enddo=1
let fortran_more_precise=1
let fortran_have_tabs=1
