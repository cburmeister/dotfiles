runtime bundle/pathogen/autoload/pathogen.vim
execute pathogen#infect()

set nocompatible

syntax on
filetype on
filetype plugin on
filetype indent on

set exrc " enable per-directory .vimrc files
set secure " disable unsafe commands in local .vimrc files                  

set expandtab
set shiftwidth=4
set tabstop=4
set smarttab

set ai
set nosmartindent
set wrap linebreak

set encoding=utf-8 fileencoding=utf-8
set nobackup nowritebackup noswapfile autoread
set number hlsearch incsearch ignorecase smartcase

set ignorecase incsearch smartcase showmatch showcmd hidden

set mouse=a

au BufNewFile,BufRead *.html setlocal ft=htmljinja
au BufRead,BufNewFile *.md set filetype=markdown
au BufRead,BufNewFile TODO,*.TODO,*.todo set filetype=todo

set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,.pyc

let g:ctrlp_custom_ignore = 'node_modules\|.bower\|static/dst\|static/dev\|.pyc'
let g:ctrlp_working_path_mode=0
let g:ctrlp_mruf_last_entered=1

:iabbrev @@ burmeister.corey@gmail.com
:iabbrev pdb # XXX BREAKPOINT XXX <cr>import pdb; pdb.set_trace()
:iabbrev ppython #!/usr/bin/env python <cr>#-*- coding: utf-8 -*-

let mapleader=","
nnoremap <leader>p :CtrlP<CR>
nnoremap <leader>b :CtrlPBuffer<CR>
nmap <space><space> :w<cr>

set background=dark
set term=xterm-256color
let g:solarized_termtrans=1
let g:solarized_termcolors=256
let g:solarized_contrast="high"
let g:solarized_visibility="high"
colorscheme solarized

set clipboard=unnamed

let g:ackhighlight=1

set colorcolumn=81
set cursorline

set laststatus=2

hi User1 ctermfg=234 ctermbg=33
hi User2 ctermfg=254 ctermbg=235
hi User3 ctermfg=125 ctermbg=235
hi User4 ctermfg=136 ctermbg=234

set statusline=
set statusline+=%1*[%n]
set statusline+=%2*\ %<%F
set statusline+=%3*\ %{fugitive#statusline()}
set statusline+=%4*\%m
set statusline+=%=
set statusline+=%2*[%c]
set statusline+=%2*[%l/%L]
