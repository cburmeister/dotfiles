set nocompatible

syntax on
filetype on
filetype plugin on
filetype indent on

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-markdown'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-surround'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/nerdtree'
Bundle 'mileszs/ack.vim'
Bundle 'kien/ctrlp.vim'
Bundle 'myusuf3/numbers.vim'
Bundle 'nvie/vim-flake8'
Bundle 'mitsuhiko/vim-jinja'
Bundle 'terryma/vim-multiple-cursors'
Bundle 'flazz/vim-colorschemes'

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
set cursorline

au BufNewFile,BufRead *.html,*.mail setlocal ft=htmljinja
au BufRead,BufNewFile *.md set filetype=markdown
au BufRead,BufNewFile TODO,*.TODO,*.todo set filetype=todo

set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,.pyc

let NERDTreeIgnore=['\.pyc$']
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

let g:ctrlp_custom_ignore = 'node_modules\|.bower\|static/dst\|static/dev\|.pyc'
let g:ctrlp_working_path_mode=0
let g:ctrlp_mruf_last_entered=1

:iabbrev @@ burmeister.corey@gmail.com
:iabbrev pdb # XXX BREAKPOINT XXX <cr>import pdb; pdb.set_trace()
:iabbrev ppython #!/usr/bin/env python <cr>#-*- coding: utf-8 -*-

let mapleader=","
nmap <leader>q :nohlsearch<CR>
nmap <leader>t :NERDTreeToggle<CR>
nnoremap <leader>p :CtrlP<CR>
nnoremap <leader>b :CtrlPBuffer<CR>
nmap <space><space> :w<cr>

nmap j gj
nmap k gk

noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

set background=dark
set term=xterm-256color
let g:solarized_termtrans=1
let g:solarized_termcolors=256
let g:solarized_contrast="high"
let g:solarized_visibility="high"
colorscheme smyck

set clipboard=unnamed

let g:ackhighlight=1

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
