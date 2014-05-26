set nocompatible

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle "ekalinin/Dockerfile.vim"
Bundle 'ciaranm/detectindent'
Bundle 'flazz/vim-colorschemes'
Bundle 'gmarik/vundle'
Bundle 'itchyny/lightline.vim'
Bundle 'jwhitley/vim-matchit'
Bundle 'kchmck/vim-coffee-script'
Bundle 'kien/ctrlp.vim'
Bundle 'kien/rainbow_parentheses.vim'
Bundle 'lokaltog/vim-easymotion'
Bundle 'mileszs/ack.vim'
Bundle 'mitsuhiko/vim-jinja'
Bundle 'myusuf3/numbers.vim'
Bundle 'nvie/vim-flake8'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/syntastic'
Bundle 'tpope/vim-commentary'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-markdown'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-sensible'
Bundle 'tpope/vim-surround'
Bundle 'wellle/targets.vim'
Bundle 'yegappan/mru'

syntax on
filetype on
filetype plugin on

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
