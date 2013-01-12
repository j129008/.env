set hls
set bs=2
set shiftwidth=3
set tabstop=3
set softtabstop=3
set expandtab
retab!
set fileencodings=utf-8,big5
set encoding=utf8
set cindent shiftwidth=3
set nu
set t_Co=256
set cursorline
set nowrap
set ai!
colorscheme ansi_blows
syntax on


"cpp file
ab fcpp #include <iostream><Enter>using namespace std;<Enter><Enter>int main(int argc, char* argv[]){<Enter><Tab><Enter>}<Esc><up><up>

"c file
ab fc #include <stdio.h><Enter><Enter>int main(int argc, char* argv[]){<Enter><Tab><Enter>}<Esc><up><up>


set laststatus=2
set statusline=%4*%<\ %1*[%F]
set statusline+=%4*\ %5*[%{&encoding}, " encoding
set statusline+=%{&fileformat}%{\"\".((exists(\"+bomb\")\ &&\ &bomb)?\",BOM\":\"\").\"\"}]%m
set statusline+=%4*%=\ %6*%y%4*\ %3*%l%4*,\ %3*%c%4*\ \<\ %2*%P%4*\ \>
highlight User1 ctermfg=red
highlight User2 term=underline cterm=underline ctermfg=green
highlight User3 term=underline cterm=underline ctermfg=yellow
highlight User4 term=underline cterm=underline ctermfg=white
highlight User5 ctermfg=cyan
highlight User6 ctermfg=white



function ClosePair(char)
  if getline('.')[col('.') - 1] == a:char
     return "\<Right>"
  else
     return a:char
  endif
endf

function! HasError(qflist)
   for i in a:qflist
   if i.valid == 1
   return 1
   endif
   endfor
   return 0
endfunction

function! MakeAndRun()
   make "%:r"
if HasError( getqflist() )
   cl
   else
   !mv "%:r" a.out
   !./a.out
   endif
endfunction

map <F9> :w<CR>:call MakeAndRun()<CR>
imap <F9> <ESC><F9>
map <F4> :cl<CR>
imap <F4> <ESC><F4>
map <F5> :cn<CR><F4>
imap <F5> <ESC><F5>
map <F6> :cp<CR><F4>
imap <F6> <ESC><F6>
map <C-c> <ESC>:wq<CR>
imap <C-c> <ESC><C-c>
map <C-x> <ESC>gg=G<CR>:% s/[ ]*\n[ ]*{/{/<CR>
imap <C-x> <ESC><C-c>
