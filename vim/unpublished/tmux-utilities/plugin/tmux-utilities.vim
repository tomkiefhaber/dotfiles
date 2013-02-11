" Tmux Utilities plugin
" Maintainer: Jim Garvin <jim@thegarvin.com>

if !exists("g:TmuxTargetSession")
  echohl ErrorMsg | echomsg "Tmux Utilities: g:TmuxTargetSession must be set."
endif

if !exists("g:TmuxTargetPane")
  echohl ErrorMsg | echomsg "Tmux Utilities: g:TmuxTargetPane must be set."
endif

if !exists("g:TmuxRspecCmd")
  let g:TmuxRspecCmd  = "bundle exec spec"
endif

if !exists("g:TmuxRspecOpts")
  let g:TmuxRspecOpts = "--drb"
endif

function! TmuxSendKeys(string)
  call system("tmux -S " . g:TmuxTargetSession . " send-keys -t " . g:TmuxTargetPane . " " . a:string)
  redraw!
endfunction

function! TmuxRunCommand(string)
  call TmuxSendKeys("\"" . a:string . "\" Enter &")
endfunction

function! TmuxClearAndRunCommand(string)
  call TmuxRunCommand("clear; tmux clear-history; " . a:string)
endfunction

function! TmuxRunSpec(...)
  if a:0 > 0
    let specfile = a:1
  else
    let specfile = expand("%")
  endif

  let cmd = g:TmuxRspecCmd . " " . g:TmuxRspecOpts . " " . specfile
  call TmuxClearAndRunCommand(cmd)
endfunction

function! TmuxRunSpecLine(...)
  if a:0 > 0
    let specfile = a:1
  else
    let specfile = expand("%")
  endif

  if a:0 > 1
    let specline = a:2
  else
    let specline = getpos(".")[1]
  endif

  call TmuxRunSpec(specfile . ":" . specline)
endfunction

command! TmuxRunSpec :call TmuxRunSpec()
command! TmuxRunSpecLine :call TmuxRunSpecLine()

nmap <Leader>RR :TmuxRunSpec<cr>
nmap <Leader>RL :TmuxRunSpecLine<cr>
