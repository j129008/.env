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
<F11>: undo tree
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

### Plug 'junegunn/gv.vim'
```
:GV  : show branch tree
:GV! : show current file git log
```

### Plug 'tpope/vim-fugitive'
```
:Gw : git add
:Gc : git commit
:Gp : git push
:Gblame : git blame
:[n lines]Gclog : watch n lines git change log from current line
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
<leader>d : goto python definition
```

### Plug 'justinmk/vim-sneak'
```
s[two alphabets] : jump to [two alphabets] position
```

### Plug 'prabirshrestha/vim-lsp', lsp_lang
* conflict with jedi-vim
```
" setting lsp support language
let lsp_lang = {'for': ['vim', 'sh', 'php']}
" php go definition
autocmd FileType php noremap <leader>d :LspDefinition<CR>
autocmd FileType php inoremap <leader>d<ESc> :LspDefinition<CR>
```
