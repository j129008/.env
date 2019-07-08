"{{{ general setting
" set ctags
set tags=tags;

" set leader
let mapleader=","

" close bell
set belloff=all
"}}}

"{{{ key mapping
map <F9> :call AutoRun()<CR>
imap <F9> :call AutoRun()<CR>
map <F10> :call ToggleHighlight()<CR>

imap <F8> <ESC>:FixWhitespace<CR>i
map <F8> :FixWhitespace<CR>
map <leader>) ysiW)

" set paste mode
set pastetoggle=<F12>
map <leader>v :e ~/.vimrc<CR> " quick edit vimrc


"{{{ buff switch
nmap <F1> :bp<ENTER>
nmap <F1> :bp<ENTER>
nmap <F2> :bn<ENTER>
nmap <F3> :bd<ENTER>
imap <F1> <ESC>:bp<ENTER>
imap <F1> <ESC>:bp<ENTER>
imap <F2> <ESC>:bn<ENTER>
imap <F3> <ESC>:bd<ENTER>
set hidden " let buff can switch without save
"}}}

"{{{ Tabularize shortcuts
nmap <Leader>a& :Tabularize /&<CR>
vmap <Leader>a& :Tabularize /&<CR>
nmap <Leader>a= :Tabularize /^[^=]*\zs=<CR>
vmap <Leader>a= :Tabularize /^[^=]*\zs=<CR>
nmap <Leader>a=> :Tabularize /=><CR>
vmap <Leader>a=> :Tabularize /=><CR>
nmap <Leader>a: :Tabularize /:<CR>
vmap <Leader>a: :Tabularize /:<CR>
nmap <Leader>a:: :Tabularize /:\zs<CR>
vmap <Leader>a:: :Tabularize /:\zs<CR>
nmap <Leader>a, :Tabularize /,<CR>
vmap <Leader>a, :Tabularize /,<CR>
nmap <Leader>a,, :Tabularize /,\zs<CR>
vmap <Leader>a,, :Tabularize /,\zs<CR>
nmap <Leader>a<Bar> :Tabularize /<Bar><CR>
vmap <Leader>a<Bar> :Tabularize /<Bar><CR>
"}}}

"}}}

"{{{ UX setting
set ignorecase smartcase
set incsearch
set bs=2 " enable backspace

" command mode completion
set wildmenu                    " Show list instead of just completing
set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.

" For when you forget to sudo.. Really Write the file.
cmap w!! w !sudo tee % >/dev/null

" do not create a copy with "~" in tail
set nowritebackup
set nobackup

" share system clipboard
set clipboard=unnamed

" set no save undo rec
set noundofile
set directory=/tmp//
"}}}

"{{{ UI setting
syntax on " open syntax hightlight
set laststatus=2 " always open status line
set ai! " set auto indent
set encoding=utf-8 " set encoding
set shortmess=atI " close start message
set binary " can see ^M
set nu " add linenumber
set scrolloff=3 " scroll remain 3 line to bottom/top
set nowrap " don't wrap line

" add cursur ( cuc: vertical, cursorline: horizon )
set cuc
set cursorline

" Highlight problematic whitespace
set list
set listchars=tab:›\ ,trail:•,extends:#,nbsp:.
"}}}

"{{{ indent setting
set expandtab
set tabstop=4

set softtabstop=4 " delete tab with 3 space
set shiftwidth=4 " set indent width
set smartindent " indent style ( cindent: for C/java, autoindent: simplist way to indent, smartindent: detect # at head to decide using cindent or autoindent )
autocmd FileType make setlocal noexpandtab " make file use tab not space
autocmd FileType markdown setlocal noexpandtab " make file use tab not space
"}}}

"{{{ Vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin('~/.vim/plugged')
    " comment helper
    Plug 'scrooloose/nerdcommenter'
        let g:NERDSpaceDelims = 1
        let g:NERDCompactSexyComs = 1

    Plug 'zhou13/vim-easyescape'
        let g:easyescape_chars = { "j": 1, "k": 1  }
        let g:easyescape_timeout = 100
        cnoremap jk <ESC>
        cnoremap kj <ESC>


    Plug 'brookhong/cscope.vim'
        nnoremap <leader>fa :call CscopeFindInteractive(expand('<cword>'))<CR>
        nnoremap <leader>l :call ToggleLocationList()<CR>

    " for git user
    Plug 'tpope/vim-fugitive'

    Plug 'scrooloose/nerdtree'
        map <C-e> :NERDTreeToggle<CR>
        let g:NERDTreeWinPos = "right"

    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'powerline/fonts'
        let g:airline#extensions#tabline#enabled = 1

    " move line with C-j, C-k
    Plug 'matze/vim-move'
        let g:move_key_modifier = 'C'

    Plug 'MattesGroeger/vim-bookmarks'
        let g:bookmark_sign = '$'

    " for python
    Plug 'davidhalter/jedi-vim'
    Plug 'vim-scripts/indentpython.vim'
    Plug 'aliev/vim-compiler-python'
    Plug 'tmhedberg/SimpylFold'
    Plug 'tpope/vim-dispatch'
    Plug 'nvie/vim-flake8'
    Plug 'tell-k/vim-autopep8'
        autocmd FileType python noremap <buffer> <F6> :call Autopep8()<CR>

    " for php
    Plug 'rayburgemeestre/phpfolding.vim'
    Plug 'StanAngeloff/php.vim'

    " for C++
    Plug 'xavierd/clang_complete'
        let g:clang_library_path=$CLANG_LIBRARY
        let g:AutoPairsMapCR = 0
        imap <silent><CR> <CR><Plug>AutoPairsReturn
        autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
        autocmd InsertLeave * if pumvisible() == 0|pclose|endif
    Plug 'octol/vim-cpp-enhanced-highlight'

    " for close bracket
    Plug 'jiangmiao/auto-pairs'
    Plug 'tpope/vim-surround'

    Plug 'dietsche/vim-lastplace'
    Plug 'altercation/vim-colors-solarized'
    Plug 'airblade/vim-gitgutter'
        set updatetime=250

    Plug 'easymotion/vim-easymotion'
    Plug 'bronson/vim-trailing-whitespace'
    Plug 'kien/ctrlp.vim'
    Plug 'godlygeek/tabular'
    Plug 'Yggdroot/indentLine'

    " for web dev
    Plug 'tmhedberg/matchit'
    Plug 'othree/html5.vim'
    Plug 's3rvac/AutoFenc'
    Plug 'jiangmiao/simple-javascript-indenter'

    Plug 'nelstrom/vim-visual-star-search'
    Plug 'gabrielelana/vim-markdown'
    Plug 'milkypostman/vim-togglelist'
        let g:toggle_list_copen_command="Copen"
call plug#end()
"}}}

"{{{ color theme setting
" order is important
set t_Co=256
set background=dark
let g:solarized_termcolors=256
let g:solarized_termtrans=1
let g:solarized_contrast="normal"
let g:solarized_visibility="normal"
colorscheme solarized
color solarized
highlight clear SignColumn
highlight clear LineNr
"}}}

"{{{ AutoRun
" run without save file
set autowrite
function! AutoRun()
   if &filetype == "python"
      execute 'compiler python'
      execute 'set makeprg=python3\ %'
      silent execute 'Make'
   elseif &filetype == "cpp"
      silent execute 'set makeprg=clang++\ -Wall\ -g\ -std=c++11\ %'
      execute 'Make && ./a.out'
   elseif &filetype == "php"
      silent execute 'set makeprg=php\ %'
      silent execute 'Make'
   elseif &filetype == "text"
      if &wrap == 0
         set wrap
      else
         set nowrap
      endif
   else
      echom &filetype
   endif
endfunction
"}}}

"{{{ ToggleHighlight
function! ToggleHighlight()
   if &hlsearch
      set nohlsearch
   else
      set hlsearch
   endif
endfunction
"}}}

"folding setting"{{{
set foldmarker={{{,}}}
set foldmethod=marker
set foldlevel=0
"}}}
