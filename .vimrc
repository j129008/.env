"{{{ key mapping
let mapleader="," " set leader
map <F9> :call AutoRun()<CR>
map <F11> :shell<CR>
map <F10> :call ToggleHighlight()<CR>

imap <F8> <ESC>:FixWhitespace<CR>i
map <F8> :FixWhitespace<CR>

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
set tabstop=3

set softtabstop=3 " delete tab with 3 space
set shiftwidth=3 " set indent width
set smartindent " indent style ( cindent: for C/java, autoindent: simplist way to indent, smartindent: detect # at head to decide using cindent or autoindent )
autocmd FileType make setlocal noexpandtab " make file use tab not space
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

   " for close bracket
   Plugin 'jiangmiao/auto-pairs'
   Plugin 'tpope/vim-surround'

   Plugin 'dietsche/vim-lastplace'
   Plugin 'altercation/vim-colors-solarized'
   Plugin 'Shougo/neocomplete.vim'
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

" {{{ neocomplete setting
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
inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

" AutoComplPop like behavior.
let g:neocomplete#enable_auto_select = 0
let g:jedi#popup_select_first=0
let g:jedi#auto_vim_configuration = 0
set completeopt=longest,menuone
let g:jedi#popup_on_dot = 0
let g:jedi#show_call_signatures = "0" " close arg hint ( will not close properly )

if !exists('g:neocomplete#force_omni_input_patterns')
   let g:neocomplete#force_omni_input_patterns = {}
endif

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
" let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'"{{{
let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'"}}}
let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'"{{{
let g:neocomplete#force_omni_input_patterns.python = '\h\w*\|[^. \t]\.\w*'"}}}
" }}}

set modelines=1 " folding setting in this file at first or last line
" vim:foldmethod=marker:foldlevel=0
