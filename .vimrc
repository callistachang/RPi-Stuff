runtime! debian.vim

"""""""""""""""""""""""""
" Vundle package manager and downloaded plugins
" To download new plugins, type :PluginInstall
"""""""""""""""""""""""""

" Turn filetype detection off to be safe when using Vundle
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

" Color scheme
Plugin 'morhetz/gruvbox'
" Status bar
Plugin 'itchyny/lightline.vim'

call vundle#end()

""""""""""""""""""""""""
" Mappings
""""""""""""""""""""""""

" Maps the Esc key to jj in Insert mode
inoremap jj <esc>

""""""""""""""""""""""""
" Line
""""""""""""""""""""""""

" Show a line beneath the current line you are on
set cursorline

" Avoid wrapping a line in the middle of a word
set linebreak

" Enable line wrapping
set wrap

" Keeps 1 line above and below the cursor
set scrolloff=1

" Show relative line numbers 
set relativenumber     

" Show current line number
set number

""""""""""""""""""""""""
" File
"""""""""""""""""""""""

" Set default encoding to support unicode
set encoding=utf-8

" Set the window's title to look like VIM: /path/to/file
set title
set titlestring=VIM:\ %-25.55F\ %a%r%m titlelen=70

" Enable indentation rules and plugins according to the detected filetype
filetype plugin indent on

" Show matching brackets
set showmatch

""""""""""""""""""""""""
" Aesthetic
""""""""""""""""""""""""

" Syntax highlighting
syntax on

" Because I am using a dark background for the editing area
set background=dark

" Enable 256 colors in Vim
set t_Co=256

" Set color scheme
colorscheme gruvbox

"""""""""""""""""""""""""
" Status bar
"""""""""""""""""""""""""

set laststatus=2
set noshowmode

"""""""""""""""""""""""""
" Search
"""""""""""""""""""""""""

" Ignore case when searching
set ignorecase

" Highlight search results after pressing the Enter key
set hlsearch

" Show all pattern matches while typing the pattern
set showmatch
