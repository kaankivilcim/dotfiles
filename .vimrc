set nocompatible
filetype off

" Vundle setup and plugins
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'chriskempson/base16-vim'
call vundle#end()

" Enable syntax highlighting, auto-indentation, sensible tabs, etc.
filetype plugin indent on
syntax on

set autoindent
set wrap

set expandtab
set smarttab
set shiftwidth=4
set tabstop=4
set softtabstop=4

" Change indent based on file type
autocmd FileType sh setlocal shiftwidth=2 tabstop=2 softtabstop=2

" Reload files automatically if changed
set autoread

" Show at least 5 lines of vertical buffer, line numbers, ruler, etc.
set so=5
set number
set ruler

" Backspace over indentation, line breaks, start of insertion, etc.
set backspace=eol,start,indent

" Enable case-sensitive searching when needed, highlight search term, etc.
set ignorecase
set smartcase
set hlsearch
set incsearch

" <Ctrl-l> redraws the screen and removes any search highlighting
nnoremap <silent> <C-l> :nohl<CR><C-l>

" Disable all audio bells/beeps and visual alerts
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" File encodings
set encoding=utf8
set ffs=unix,dos,mac

" Disable temporary files
set nobackup
set nowb
set noswapfile

" Base16 color scheme support
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif
