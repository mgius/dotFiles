""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" .vimrc -- the way it ought to be: Ha. It rhymes!
" Forked from Nat Welch
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

set encoding=utf-8
behave xterm
set nocompatible       " no compatibility with vi
filetype on            " recognize syntax by file extension
filetype plugin on     " Look at .vim/ftplugin
filetype indent on     " check for indent file
syntax on              " syntax highlighting

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

set ai " Auto indent
set si " smart indenting

set backspace=2        " allow <BS> to go past last insert
set gdefault           " assume :s uses /g
set ignorecase         " ignore case in search patterns
set smartcase          " searches are case-sensitive if caps used
set incsearch          " immediately highlight search matches
set noerrorbells       " no beeps on errors
set nomodeline         " prevent others from overriding this .vimrc
set number             " display line numbers
set ruler              " display row, column and % of document
set showcmd            " show partial commands in the status line
set showmatch          " show matching () {} etc.
set showmode           " show current mode

" Settings for autoindentation, comments, and what-have-you
"
set foldmethod=indent
set foldlevel=99

set expandtab          " expand tabs with spaces
set tabstop=3          " <Tab> move three characters
set shiftwidth=3       " >> and << shift 3 spaces
"set textwidth=79       " hard wrap at 79 characters
set modeline           " check for a modeline
set softtabstop=3      " see spaces as tabs
set scrolloff=5        " start scrolling when cursor is N lines from edge

" whoa... wtf?
set nowrap             " don't soft wrap
set wrap               " linewrap

" turns status line always on and configures it
set laststatus=2
set statusline=%<%f\ %{fugitive#statusline()}%m\ %h%r%=%b\ 0x%B\ \ %l,%c%V\ %P\ of\ %L

" Highlights long lines (Turned off...)
"highlight OverLength term=standout cterm=bold ctermfg=1
"match OverLength /\%91v.\+/

" Markdown
au BufRead,BufNewFile *.md set ft=markdown
au BufRead,BufNewFile *.markdown set ft=markdown

" Less
au BufRead,BufNewFile *.less set ft=less

" Makefiles
au BufRead,BufNewFile [Mm]akefile* set noet ts=8 sw=8 nocindent list lcs=tab:>-,trail:x

" F#
au BufRead,BufNewFile *.fs set ft=fs

" Text Files
au BufRead,BufNewFile *.txt highlight clear OverLength
"au BufRead,BufNewFile *.txt set textwidth=80

" God
au BufRead,BufNewFile *.god set filetype=ruby

" Tex Files
au BufRead,BufNewFile *.tex highlight clear OverLength
au BufRead,BufNewFile *.bib highlight clear OverLength

" Remove trailing spaces from lines: http://vim.wikia.com/wiki/Remove_unwanted_spaces
:nnoremap <silent> <F6> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

" Because we like our line numbers sometimes...
:nnoremap <C-N><C-N> :set invnumber<CR>

" But we don't always wanna wrap
:nnoremap <C-w><C-w> :set invwrap<CR>

" And all the cool kids need to paste
:nnoremap <C-p><C-p> :set invpaste<CR>

" Use the space key to open and close code folds
:vnoremap <space> zf<CR>
:nnoremap <space> zd<CR>

" Toggle spell checking.
:map <f7> :set spell!<cr>

" Clear search buffer with Ctrl+l
:noremap <silent> <c-l> :nohls<cr><c-l>

" Show PEP8 violations.  Requires pep8 binary in PATH
let g:pep8_map='<leader>8'

" Activate File Browser
map <leader>n :NERDTreeToggle<CR>
" And then pyflakes gets in the way
let g:pyflakes_use_quickfix = 0

" Buffer left/right. ^[ (C-V C-[) is a gnome-terminal specific hack.  
" Gnome-terminal sends ESC-KEY on Alt and Meta keypresses.
" See :help map-alt-keys for why
"map h :bN<CR>
"map l :bn<CR>
map bh :bN<CR>
map bl :bn<CR>

" The previous could cause issues in legimate ESC and movement keypresses.
" This delay should fix that.
":set timeout timeoutlen=1000 ttimeoutlen=40 

let NERDTreeIgnore=['\~$','\.pyc$']