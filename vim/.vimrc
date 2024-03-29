syntax on
filetype on

set clipboard^=unnamed,unnamedplus
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

" YAML
au BufNewFile,BufReadPost *.{yaml,yml} set filetype=yaml
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

let NERDTreeIgnore=['\.pyc$']
let NERDTreeMinimalUI=1
let NERDTreeDirArrows=1
let NERDTreeShowHidden=1

let g:go_disable_autoinstall=1
let g:go_fmt_autosave = 0

let g:ctrlp_custom_ignore = 'node_modules\|.bower\|static/dst\|static/dev\|.pyc'
let g:ctrlp_working_path_mode=0
let g:ctrlp_mruf_last_entered=1
let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --hidden
      \ --ignore .git
      \ --ignore .DS_Store
      \ --ignore "**/*.pyc"
      \ -g ""'
