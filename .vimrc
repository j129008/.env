"{{{ key mapping
let mapleader="," " set leader
map <F9> :call AutoRun()<CR>
imap <F9> :call AutoRun()<CR>
map <F10> :call ToggleHighlight()<CR>

imap <F8> <ESC>:FixWhitespace<CR>i
map <F8> :FixWhitespace<CR>
map <leader>) ysiW)

" set paste mode
set pastetoggle=<F12>
map <leader>v :e ~/.vimrc<CR> " quick edit vimrc

" close bell
set belloff=all

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

"{{{ Vundle
set nocompatible              " be iMproved, required
filetype off                  " required
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
    Plugin 'VundleVim/Vundle.vim'
    " comment helper
    Plugin 'scrooloose/nerdcommenter'
        let g:NERDSpaceDelims = 1
        let g:NERDCompactSexyComs = 1

    " for git user
    Plugin 'tpope/vim-fugitive'

    Plugin 'scrooloose/nerdtree'
        map <C-e> :NERDTreeToggle<CR>
        let g:NERDTreeWinPos = "right"

    Plugin 'vim-airline/vim-airline'
    Plugin 'vim-airline/vim-airline-themes'
    Plugin 'powerline/fonts'
        let g:airline#extensions#tabline#enabled = 1

    " move line with C-j, C-k
    Plugin 'matze/vim-move'
        let g:move_key_modifier = 'C'

    Plugin 'MattesGroeger/vim-bookmarks'
        let g:bookmark_sign = '$'

    " for python
    Plugin 'davidhalter/jedi-vim'
    Plugin 'vim-scripts/indentpython.vim'

    " for C++
    Plugin 'xavierd/clang_complete'
        let g:clang_library_path='/usr/lib/llvm-6.0/lib/'
        let g:AutoPairsMapCR = 0
        imap <silent><CR> <CR><Plug>AutoPairsReturn
        autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
        autocmd InsertLeave * if pumvisible() == 0|pclose|endif

    " for close bracket
    Plugin 'jiangmiao/auto-pairs'
    Plugin 'tpope/vim-surround'

    Plugin 'dietsche/vim-lastplace'
    Plugin 'altercation/vim-colors-solarized'
    Plugin 'airblade/vim-gitgutter'
        set updatetime=250

    Plugin 'easymotion/vim-easymotion'
    Plugin 'bronson/vim-trailing-whitespace'
    Plugin 'kien/ctrlp.vim'
    Plugin 'godlygeek/tabular'
    Plugin 'nathanaelkane/vim-indent-guides'
        let g:indent_guides_start_level = 2
        let g:indent_guides_guide_size = 1
        let g:indent_guides_enable_on_vim_startup = 1

    " for web dev
    Plugin 'tmhedberg/matchit'
    Plugin 'othree/html5.vim'
    Plugin 's3rvac/AutoFenc'
    Plugin 'jiangmiao/simple-javascript-indenter'

    Plugin 'nelstrom/vim-visual-star-search'
    Plugin 'gabrielelana/vim-markdown'
call vundle#end()
filetype plugin indent on
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
      execute 'set makeprg=python3\ %'
      silent execute 'make|copen|redraw!'
   elseif &filetype == "cpp"
      silent execute 'set makeprg=g++\ %'
      silent execute 'make'
      execute '!./a.out; mv ./a.out /tmp'
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
set modelines=1 " folding setting in this file at first or last line
"}}}

" vim:foldmethod=marker:foldlevel=0
