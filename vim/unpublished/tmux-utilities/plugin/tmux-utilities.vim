" Tmux Utilities plugin
" Maintainer: Jim Garvin <jim@thegarvin.com>

let g:TmuxRspecSession = "/tmp/side"
let g:TmuxRspecPane    = "1.3"
let g:TmuxRspecCmd     = "bundle exec spec"
let g:TmuxRspecOpts    = "--drb"

function! TmuxSendKeys(sessionSocket, targetPane, string)
  call system("tmux -S " . a:sessionSocket . " send-keys -t " . a:targetPane . " " . a:string)
  redraw!
endfunction

function! TmuxRunCommand(sessionSocket, targetPane, string)
  call TmuxSendKeys(a:sessionSocket, a:targetPane, "\"" . a:string . "\" Enter &")
endfunction

function! TmuxClearAndRunCommand(sessionSocket, targetPane, string)
  call TmuxRunCommand(a:sessionSocket, a:targetPane, "clear; tmux clear-history; " . a:string)
endfunction

function! TmuxRunSpec(...)
  if a:0 > 0
    let specfile = a:1
  else
    let specfile = expand("%")
  endif

  let cmd = g:TmuxRspecCmd . " " . g:TmuxRspecOpts . " " . specfile
  call TmuxClearAndRunCommand(g:TmuxRspecSession, g:TmuxRspecPane, cmd)
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
