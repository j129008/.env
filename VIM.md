# vim shortcut note

## General setting
### F1 ~ F12
```
<F1> : left buffer
<F2> : right buffer
<F3> : close buffer
<F4> :
<F5> : toggle ALE
<F6> : jump file history
<F7> : remove trailing whitespace
<F8> : toggle tagbar
<F9> : auto run
<F10>: toggle highlight
<F11>: undo tree  # not work in Mac
<F12>: toggle paste mode
```

### Leader key
```
<leader> : ,
```

### Edit vimrc
```
<leader>v
```

## MacOS setting
```
# for plugin ctrlp-funky search function
execute "set <M-p>=ð"

# for plugin auto-pairs
execute "set <M-e>=ª"

# for ALE jump
nmap <silent> α <Plug>(ale_next_wrap)"}}}
nmap <silent> β <Plug>(ale_previous_wrap)
```

## Basic shortcuts
### folding
```
zi    : toggle fold
zo    : open fold
zc    : close fold
zx    : close all fold except current position
zf/zF : create fold mark
```

### go forward/previous location
```
<C-i> : go forward
<C-o> : go previous
```

### auto complete
```
<C-p> : text complete
```

### goto file in cursor
```
gf
```

### go forward/previous function
```
[m : go previous member function
]m : go forward member function
[[ : go previous class
]] : go forward class
```

### word move/select/delete
```
viw : select a word
diw : delete a word
b   : go to previous word
w   : go to next word
```

## ctags/cscope setting
```
# create cscope db
cscope -Rbqk **/*.py
<leader>fc    : function call search

# create ctags db
ctags **/*.py
<ctrl>]      : goto definition
:ts          : possible definition list
```


## Plugin setting
### Plug 'scrooloose/nerdtree'
```
<ctrl>e : toggle nerdtree
```

### Plug 'scrooloose/nerdcommenter'
```
<leader>ci : toggle comment
```

### Plug 'kien/ctrlp.vim'
```
<ctrl>p : fuzzy git repo file
```

### Plug 'tacahiroy/ctrlp-funky'
```
<alt>p : fuzzy search function
```

### Plug 'tpope/vim-fugitive'
```
:Gw      : git add
:Gcommit : git commit
:Gpush   : git push
:Gblame  : git blame
:[n lines]Gclog : watch n lines git change log from current line
```

### Plug 'rbong/vim-flog'
```
:GFlog   : view git log
a        : show all branch (in GFlog)
```

### Plug 'airblade/vim-gitgutter'
#### Hunk jumping
```
]c : jump to the next [count] hunk.
[c : jump to the previous [count] hunk.
```

### Plug 'dense-analysis/ale'
```
<alt> j : jump to next error
<alt> k : jump to previous error
```

### Plug 'MattesGroeger/vim-bookmarks'
```
mm : toggle bookmark
mc : clear bookmark
mx : clear all bookmark
mn : jump to next bookmark
mp : jump to previous bookmark
ma : show all bookmark
```

### Plug 'jpalardy/vim-slime'
* split tmux window
* open ipython3 on right window
* open python3 file on left window
```
<leader>k : excute python code
```

### Plug 'davidhalter/jedi-vim'
```
<leader>d : goto definition
<leader>g : goto assignment
<leader>r : renaming
<leader>n : show usage
<leader>K : show pyDoc
```

### Plug 'justinmk/vim-sneak'
```
s[two alphabets] : jump to [two alphabets] position
```

### Plug 'prabirshrestha/vim-lsp'
conflict with jedi-vim, so I add lsp_lang setting to avoid run it on same time
```
" setting lsp support language
let lsp_lang = {'for': ['vim', 'sh', 'php']}
" php go definition
autocmd FileType php noremap <leader>d :LspDefinition<CR>
autocmd FileType php inoremap <leader>d<ESc> :LspDefinition<CR>
```

### Plug 'matze/vim-move'
```
<ctrl>k : move line up
<ctrl>j : move line down
<ctrl>h : move char left
<ctrl>l : move char right
```

### Plug 'junegunn/fzf.vim'
```
:BCommits : search current buffer commits (epic!)
:Commits  : search commits
<leader>f : search string in current git repo
:Commands : search vim commands
:Lines    : search current file lines
:Colors   : search vim themes
```

### Plug 'jiangmiao/auto-pairs'
```
<alt>e : move bracket to next block
```

### Plug 'junegunn/vim-peekaboo'
```
# in normal mode
"    : show vim register
"3yy : yank to register @3
"3p  : paste register @3
```
