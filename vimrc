" Vundle required settings
set nocompatible    " Disable Vi-compatibility settings
set rtp+=~/.vim/bundle/Vundle.vim
filetype off
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

Plugin 'Yggdroot/indentLine'
call vundle#end()
filetype plugin indent on

" Enable powerline
set rtp+=$HOME/.local/lib/python2.7/site-packages/powerline/bindings/vim/
set laststatus=2

set number          " Show line numbers
set wrap            " Wrap lines
set linebreak       " Break line on word
set hlsearch        " Highlight search term in text
set incsearch       " Show search matches as you type
set wrapscan        " Automatically wrap search when hitting bottom
set autoindent      " Enable autoindenting
set history=1000    " Command history
set undolevels=500  " Levels of undo
set tabstop=4       " Tab size
set expandtab       " Spaces instead of tabs
set softtabstop=4   " Treat n spaces as a tab
set shiftwidth=4    " Tab size for automatic indentation
set mouse=a         " Allow using mouse to change cursor position
set t_Co=256        " Enable 256 colors
set textwidth=80    " Maximum width in characters
set synmaxcol=150   " Limit syntax highlight parsing to first 150 columns
set cursorline      " Highlight current line
set backspace=indent,eol,start " Allow full functionality of backspace
set scrolloff=4     " Keep cursor 4 rows above the bottom when scrolling

syntax enable
filetype indent on  " Enable filetype-specific indentation
filetype plugin on  " Enable filetype-specific plugins
colorscheme default " Set default colors

" Autocompletion settings
set completeopt=longest,menuone,preview

" Command line completion settings
set wildmode=longest,list,full
set wildmenu

" Invis chars
set listchars=eol:⏎,tab:>-,trail:~,extends:>,precedes:<
set list

" Indent Line
let g:indentLine_color_term=239
let g:indentLine_char='|'
let g:indentLine_leadingSpaceChar='.'
let g:indentLine_leadingSpaceEnabled=1
let g:indentLine_enabled=1

