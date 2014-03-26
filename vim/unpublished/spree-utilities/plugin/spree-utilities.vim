" Spree Utilities plugin
" Maintainer: Jim Garvin <jim@thegarvin.com>

" TODO: conditionally load based on spree detection.

function! CopySpreeViewToApp()
  let sourceFile = expand("%")
  let targetDir  = "app/views/" . system("dirname " . sourceFile . " | sed 's,.*/app/views/,,'")
  call system("cp " . sourceFile . " " . targetDir)
  echo "Spree view copied!"
endfunction

command! CopySpreeViewToApp :call CopySpreeViewToApp()

