syntax on
set number

syntax enable
set showcmd
set shiftwidth=2
set tabstop=2
set expandtab

set autoindent 

set nowrap

:map <F2> :set autoindent! <CR>
:map <F3> :set number! <CR>
:map <F4> :NERDTree <CR>
:map <tab> <C-W>w
:map <S-tab> <C-W>h
colorscheme zellner


autocmd VimEnter * NERDTree
autocmd VimEnter * wincmd p
