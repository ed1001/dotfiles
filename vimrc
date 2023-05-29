syntax on

let mapleader=" "

nnoremap <SPACE> <Nop>
nnoremap <CR> :noh<CR><CR>
nnoremap <C-D> <C-D>zz
nnoremap <C-U> <C-U>zz

xnoremap <SPACE> <Nop>
xnoremap p "_dP
xnoremap <C-j> <Esc>

inoremap <C-j> <Esc>

set number
set relativenumber
set mouse=a
set noswapfile
set hlsearch
set ignorecase
set incsearch
set backspace=indent,eol,start
set tabstop=2 shiftwidth=2 expandtab
set timeoutlen=30

colorscheme slate
if has("multi_byte")
  set encoding=utf-8
  setglobal fileencoding=utf-8
else
  echoerr "Sorry, this version of (g)vim was not compiled with +multi_byte"
endif
