" ====================
" General Settings
" ====================
let mapleader=","
set tags=tags;
set belloff=all
set noswapfile
set autowrite
autocmd bufwritepost .vimrc source $MYVIMRC

" ====================
" UI Settings
" ====================
syntax on
set t_Co=256
set background=dark
set encoding=utf-8
set laststatus=2
set nu
set relativenumber
set scrolloff=3
set nowrap
set shortmess=atI
set cursorline
set cuc
set list
set listchars=tab:›\ ,trail:•,extends:#,nbsp:.

" ====================
" UX Settings
" ====================
set hidden
set ignorecase smartcase
set incsearch
set hlsearch
set ttimeoutlen=10
set confirm
set splitbelow
set splitright
set bs=2
set wildmenu
set wildmode=list:longest,full
set clipboard=unnamed
set nowritebackup
set nobackup
set noundofile
set directory=/tmp//
autocmd BufEnter * silent! lcd %:p:h
nnoremap <silent> <Esc><Esc> :nohlsearch<CR>
cmap w!! w !sudo tee % >/dev/null

" ====================
" Indent Settings
" ====================
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set smartindent
set ai!
autocmd FileType make setlocal noexpandtab
autocmd FileType markdown setlocal noexpandtab
autocmd FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab

" ====================
" Folding Settings
" ====================
set foldmarker={{{,}}}
set foldlevel=0
set foldnestmax=1
autocmd FileType vim setlocal foldmethod=marker
autocmd FileType json setlocal foldmethod=syntax foldnestmax=5
" vim-json conceals quotes by default, which makes JSON hard to read and edit
autocmd FileType json setlocal conceallevel=0

" ====================
" Key Mappings - Function Keys
" ====================
" F1/F2/F3: Buffer navigation
noremap <F1> :bp<CR>
inoremap <F1> <C-o>:bp<CR>
noremap <F2> :bn<CR>
inoremap <F2> <C-o>:bn<CR>
noremap <F3> :bd<CR>
inoremap <F3> <C-o>:bd<CR>

" F5: Toggle ALE
noremap <F5> :ALEToggle<CR>
inoremap <F5> <C-o>:ALEToggle<CR>

" F6: Jump history
noremap <F6> :call GotoJump()<CR>
inoremap <F6> <C-o>:call GotoJump()<CR>

" F7: Remove trailing whitespace
noremap <F7> :FixWhitespace<CR>
inoremap <F7> <C-o>:FixWhitespace<CR>

" F8: Toggle Tagbar
noremap <F8> :TagbarToggle<CR>
inoremap <F8> <C-o>:TagbarToggle<CR>

" F9: Run Python
noremap <F9> :call RunPython()<CR>
inoremap <F9> <C-o>:call RunPython()<CR>

" F11: Toggle Undotree
noremap <F11> :UndotreeToggle<CR>
inoremap <F11> <C-o>:UndotreeToggle<CR>

" F12: Toggle paste mode
set pastetoggle=<F12>

" ====================
" Key Mappings - Leader
" ====================
map <leader>v :e ~/.vimrc<CR>
map <leader>h :e ~/.vim_guide.md<CR>
nnoremap <Leader>f :PRg<CR>

" Tabularize
nmap <Leader>a= :Tabularize /^[^=]*\zs=<CR>
vmap <Leader>a= :Tabularize /^[^=]*\zs=<CR>
nmap <Leader>a: :Tabularize /:<CR>
vmap <Leader>a: :Tabularize /:<CR>
nmap <Leader>a, :Tabularize /,<CR>
vmap <Leader>a, :Tabularize /,<CR>
nmap <Leader>a<Bar> :Tabularize /<Bar><CR>
vmap <Leader>a<Bar> :Tabularize /<Bar><CR>

" ====================
" Vim-plug
" ====================
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" --- UI ---
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
    let g:airline#extensions#tabline#enabled = 1
Plug 'Yggdroot/indentLine'
    " indentLine sets conceallevel=2, which re-hides JSON quotes; exclude it
    let g:indentLine_fileTypeExclude = ['json']
Plug 'altercation/vim-colors-solarized'

" --- File Navigation ---
Plug 'scrooloose/nerdtree'
    map <C-e> :NERDTreeToggle<CR>
    let g:NERDTreeWinPos = "right"
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
    nnoremap <C-p> :Files<CR>
    nnoremap <M-p> :BTags<CR>
    execute "set <M-p>=\ep"
    command! -bang -nargs=* PRg
      \ call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, fzf#vim#with_preview({'dir': system('git rev-parse --show-toplevel 2> /dev/null')[:-2]}), <bang>0)

" --- Git ---
Plug 'tpope/vim-fugitive'
Plug 'rbong/vim-flog'
Plug 'airblade/vim-gitgutter'
    set updatetime=250

" --- Editing ---
Plug 'scrooloose/nerdcommenter'
    let g:NERDSpaceDelims = 1
    let g:NERDCompactSexyComs = 1
Plug 'tpope/vim-surround'
Plug 'jiangmiao/auto-pairs'
    let g:AutoPairsShortcutToggle = 0
Plug 'ervandew/supertab'
    let g:SuperTabDefaultCompletionType = "<C-X><C-O>"
Plug 'matze/vim-move'
    let g:move_key_modifier = 'C'
Plug 'godlygeek/tabular'
Plug 'bronson/vim-trailing-whitespace'
Plug 'justinmk/vim-sneak'

" --- Utilities ---
Plug 'mbbill/undotree'
Plug 'majutsushi/tagbar'
    let g:tagbar_type_python = {
        \ 'kinds' : [
            \ 'i:modules:1:0',
            \ 'c:classes',
            \ 'f:functions',
            \ 'm:members',
            \ 'v:variables',
        \ ],
    \ }
Plug 'nelstrom/vim-visual-star-search'
Plug 'djoshea/vim-autoread'
Plug 'milkypostman/vim-togglelist'
    let g:toggle_list_copen_command="Copen"
Plug 's3rvac/AutoFenc'
Plug 'farmergreg/vim-lastplace'
Plug 'junegunn/vim-peekaboo'
Plug 'tpope/vim-dispatch'
Plug 'MattesGroeger/vim-bookmarks'
    let g:bookmark_sign = '$'

" --- Syntax Highlighting ---
Plug 'luochen1990/rainbow'
    let g:rainbow_active = 1
Plug 'mechatroner/rainbow_csv'
Plug 'gabrielelana/vim-markdown'
Plug 'mtdl9/vim-log-highlighting'

" --- Linting (ALE) ---
Plug 'dense-analysis/ale'
    let g:ale_linters = { 'python': ['ruff', 'mypy'] }
    let g:ale_fixers = {
        \ 'python': ['ruff', 'ruff_format'],
        \ '*': ['remove_trailing_lines', 'trim_whitespace'],
    \ }
    let g:ale_fix_on_save = 0
    execute "set <M-j>=\ej"
    execute "set <M-k>=\ek"
    nmap <silent> <M-k> <Plug>(ale_previous_wrap)
    nmap <silent> <M-j> <Plug>(ale_next_wrap)

" --- Python ---
Plug 'davidhalter/jedi-vim'
    let g:jedi#popup_on_dot = 0
    let g:jedi#popup_select_first = 0
    let g:jedi#show_call_signatures = "0"
    autocmd FileType python setlocal completeopt-=preview
Plug 'vim-scripts/indentpython.vim'
Plug 'aliev/vim-compiler-python'
Plug 'jpalardy/vim-slime'
    let g:slime_target = "tmux"
    let g:slime_default_config = {"socket_name": "default", "target_pane": "{right-of}"}
    let g:slime_dont_ask_default = 1
    let g:slime_python_ipython = 1
    let g:slime_no_mappings = 1
    xmap <leader>k <Plug>SlimeRegionSend
    nmap <leader>k <Plug>SlimeParagraphSend
Plug 'tmhedberg/SimpylFold'

call plug#end()

" ====================
" Color Theme
" ====================
let g:solarized_termcolors=256
let g:solarized_termtrans=1
let g:solarized_contrast="normal"
let g:solarized_visibility="normal"
silent! colorscheme solarized
highlight clear SignColumn
highlight clear LineNr

" ====================
" Hotfix
" ====================
let g:omni_sql_no_default_maps = 1

" ====================
" Functions
" ====================
function! RunPython()
    if &filetype == "python"
        execute 'compiler python'
        execute 'set makeprg=python3\ %'
        silent execute 'Make'
    else
        echom "Not a Python file"
    endif
endfunction

function! GotoJump()
    jumps
    let j = input("Please select your jump: ")
    if j != ''
        let pattern = '\v\c^\+'
        if j =~ pattern
            let j = substitute(j, pattern, '', 'g')
            execute "normal " . j . "\<c-i>"
        else
            execute "normal " . j . "\<c-o>"
        endif
    endif
endfunction
