syntax on

let mapleader=" "

inoremap jk <Esc>

nnoremap <SPACE> <Nop>
nnoremap <Esc> :noh<CR><CR>
nnoremap <C-D> <C-D>zz
nnoremap <C-U> <C-U>zz

nnoremap <leader>e :NERDTree<CR> 

xnoremap <SPACE> <Nop>
xnoremap p "_dP

map <Leader> <Plug>(easymotion-prefix)
map <leader>o <Action>(GotoFile) 
map <leader>r <Action>(ReplaceInPath) 
map <leader>bx <Action>(CloseAllEditors) 
map <leader>bd <Action>(CloseContent) 
map <leader>bo <Action>(CloseAllEditorsButActive) 
map L <Action>(NextTab) 
map H <Action>(PreviousTab) 
map <leader><leader> <Action>(SaveAll) 
map <leader>\ <Action>(SplitVertically) 

set scrolloff=5
set number
set relativenumber
set mouse=a
set noswapfile
set hlsearch
set incsearch
set backspace=indent,eol,start
set tabstop=2 shiftwidth=2 expandtab
set timeoutlen=300

colorscheme slate
if has("multi_byte")
  set encoding=utf-8
  setglobal fileencoding=utf-8
else
  echoerr "Sorry, this version of (g)vim was not compiled with +multi_byte"
endif

set sneak
Plug 'machakann/vim-highlightedyank'
Plug 'preservim/nerdtree'
Plug 'easymotion/vim-easymotion'
