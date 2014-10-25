set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'ciaranm/detectindent'
Plugin 'ekalinin/Dockerfile.vim'
Plugin 'fatih/vim-go'
Plugin 'flazz/vim-colorschemes'
Plugin 'gmarik/vundle'
Plugin 'itchyny/lightline.vim'
Plugin 'jwhitley/vim-matchit'
Plugin 'kchmck/vim-coffee-script'
Plugin 'kien/ctrlp.vim'
Plugin 'kien/rainbow_parentheses.vim'
Plugin 'lokaltog/vim-easymotion'
Plugin 'mileszs/ack.vim'
Plugin 'mitsuhiko/vim-jinja'
Plugin 'myusuf3/numbers.vim'
Plugin 'nvie/vim-flake8'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-markdown'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-surround'
Plugin 'wellle/targets.vim'
Plugin 'yegappan/mru'

call vundle#end()            " required
filetype plugin indent on    " required

syntax on
filetype on

colorscheme smyck

set cursorline
set expandtab shiftwidth=4
set exrc " enable per-directory .vimrc files
set hidden
set hlsearch incsearch ignorecase smartcase showmatch
set nobackup nowritebackup noswapfile
set number
set scrolloff=3
set secure " disable unsafe commands in local .vimrc files                  

set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.pyc/*

let mapleader=","

nmap <leader>q :nohlsearch<CR>
nmap <leader>t :NERDTreeToggle<CR>
nmap <space><space> :w<cr>
nmap <F8> :TagbarToggle<CR>

nmap j gj
nmap k gk

nnoremap <leader>p :CtrlP<CR>
nnoremap <leader>b :CtrlPBuffer<CR>

noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" https://mug.im/save-a-file-as-root-in-vim/
cmap w!! w !sudo tee % >/dev/null

:iabbrev pdb # XXX BREAKPOINT XXX <cr>import pdb; pdb.set_trace()

au BufNewFile,BufRead *.html,*.mail setlocal ft=htmljinja
au BufRead,BufNewFile *.md set filetype=markdown
au BufRead,BufNewFile TODO,*.TODO,*.todo set filetype=todo

let NERDTreeIgnore=['\.pyc$']
let NERDTreeMinimalUI=1
let NERDTreeDirArrows=1
let NERDTreeShowHidden=1

let g:go_disable_autoinstall=1
let g:go_fmt_autosave = 0

let g:ctrlp_custom_ignore = 'node_modules\|.bower\|static/dst\|static/dev\|.pyc'
let g:ctrlp_working_path_mode=0
let g:ctrlp_mruf_last_entered=1

let g:ackhighlight=1

let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component': {
      \   'readonly': '%{&filetype=="help"?"":&readonly?"⭤":""}',
      \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
      \   'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}'
      \ },
      \ 'component_visible_condition': {
      \   'readonly': '(&filetype!="help"&& &readonly)',
      \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
      \   'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '|', 'right': '|' }
      \ }
