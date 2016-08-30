" set leader
let mapleader=","

" auto reload .vimrc when save
autocmd BufWritePost $MYVIMRC source $MYVIMRC

" pathogen
execute pathogen#infect()

" always open status line
set laststatus=2

" enable backspace
set bs=2

" hightlight search
set hls

" set auto indent
set ai!

" can see ^M 
set binary

" add linenumber
set nu

" set encoding
set encoding=utf-8 

" close start message 
set shortmess=atI

" add cursur ( cuc: vertical, cursorline: horizon )
set cuc
set cursorline

" don't wrap line
set nowrap

" use space instead tab
set expandtab
set tabstop=3

" set indent width
set shiftwidth=3

" indent style ( cindent: for C/java, autoindent: simplist way to indent, smartindent: detect # at head to decide using cindent or autoindent )
set smartindent

" scroll remain 3 line to bottom/top
set scrolloff=3

" set buff switch
nmap <F1> :bp<ENTER>
nmap <F2> :bn<ENTER>
nmap <F3> :bd<ENTER>
set hidden

" set paste mode
set pastetoggle=<F12>

" set color theme ( put ansi_blows.vim in ~/.vim/color )
colorscheme solarized

let g:solarized_termcolors=256
let g:solarized_termtrans=1
let g:solarized_contrast="normal"
let g:solarized_visibility="normal"
set background=dark                                                                                      
set t_Co=256

" open syntax hightlight
syntax on



" ======================  Vundle  =========================
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
   
   " for close bracket
   Plugin 'jiangmiao/auto-pairs'
   Plugin 'tpope/vim-surround'

   Plugin 'altercation/vim-colors-solarized'
   Plugin 'tpope/vim-pathogen'
   Plugin 'Shougo/neocomplete.vim'
   Plugin 'airblade/vim-gitgutter'
   Plugin 'easymotion/vim-easymotion'

   " for web dev
   Plugin 'tmhedberg/matchit'

   Plugin 'thinca/vim-quickrun'
		let g:quickrun_config = {
		\   "_" : {
		\       "outputter" : "message",
		\   },
		\}

		let g:quickrun_no_default_key_mappings = 1
		map <F9> :QuickRun<CR>
		imap <F9> :QuickRun<CR>


call vundle#end()            
filetype plugin indent on
" ======================  Vundle  =========================


"Note: This option must be set in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

" AutoComplPop like behavior.
let g:neocomplete#enable_auto_select = 0
let g:jedi#popup_select_first=0
let g:jedi#auto_vim_configuration = 0
set completeopt=longest,menuone
let g:jedi#popup_on_dot = 0

if !exists('g:neocomplete#force_omni_input_patterns')
   let g:neocomplete#force_omni_input_patterns = {}
endif

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=jedi#completions
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
