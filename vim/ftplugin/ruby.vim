" Ruby helper
if exists('s:did_ruby_helper')
	finish
endif
let s:did_ruby_helper = 1

" Trigger def snippet using word as method name
imap <D-return> <Esc>"zdiwadef<Tab><Esc>ciw<C-r>z<Tab>

