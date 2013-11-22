""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" .vimrc -- the way it ought to be: Ha. It rhymes!
" Forked from Nat Welch
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

filetype off
call pathogen#helptags()
call pathogen#infect()

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
"set foldmethod=indent
"set foldlevel=99

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
set statusline=%<%f\%{fugitive#statusline()}%m\ %h%r%=%b\ 0x%B\ \ %l,%c%V\ %P\ of\ %L

" Highlights long lines (Turned off...)
highlight OverLength term=standout cterm=bold ctermfg=1
match ErrorMsg '\%>79v.\+'

" Change folded lines to be a little less painful
highlight Folded term=standout ctermfg=4 ctermbg=8 guifg=DarkBlue guibg=DarkGrey

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

" Tex Files
au BufRead,BufNewFile *.tex highlight clear OverLength
au BufRead,BufNewFile *.bib highlight clear OverLength

" double Ctrl-N to invert numbers
:nnoremap <C-N><C-N> :set invnumber<CR>

" double Ctrl-w to invert wrap
:nnoremap <C-w><C-w> :set invwrap<CR>

" double Ctrl-p to invert paste
:nnoremap <C-p><C-p> :set invpaste<CR>

" Clear search buffer with Ctrl+l
:nnoremap <silent> <c-l> :nohls<cr><c-l>

" Show PEP8 violations.  Requires pep8 binary in PATH
autocmd FileType python map <buffer> <leader>8 :call Pep8()<CR>

" Activate File Browser
map <leader>n :NERDTreeToggle<CR>

" ctags awesomeness
" nnoremap <silent> <c-i> :TlistToggle<CR>
" let Tlist_Close_On_Select = 1
" let Tlist_Use_Right_Window = 1

" Buffer left/right. ^[ (C-V C-[) is a gnome-terminal specific hack.  
" Gnome-terminal sends ESC-KEY on Alt and Meta keypresses.
" See :help map-alt-keys for why
"map h :bN<CR>
"map l :bn<CR>
" Less hacky version
map bh :bN<CR>
map bl :bn<CR>
map bN :bN<CR>
map bn :bn<CR>


"" NERDTree Configuration
let NERDTreeIgnore=['\~$','\.pyc$']


"" syntastic configuration
let g:syntastic_python_checkers=['pep8', 'pylint']
let g:syntastic_always_populate_loc_list=1
" Syntastic output navigation shortcuts
map cn :lnext<CR>
map cN :lprev<CR>


"" Minibufexpl.vim configuration
" Colors
hi MBENormal               ctermfg=Green
hi MBEChanged              ctermfg=Red
hi MBEVisibleNormal        ctermfg=Green
hi MBEVisibleChanged       ctermfg=Red
hi MBEVisibleActiveNormal  ctermfg=Green        ctermbg=DarkGrey
hi MBEVisibleActiveChanged ctermfg=Red          ctermbg=DarkGrey


"" jedi-vim
" I'm a buffer man
" I would prefer not to have preview pane
autocmd FileType python setlocal completeopt-=preview
" I already use leader-n for nerdtree
let g:jedi#usages_command = "<leader>N"
let g:jedi#use_tabs_not_buffers = 0


"" supertab
let g:SuperTabDefaultCompletionType = "<c-n>"

"" command-t
let g:CommandTWildIgnore = "*venv,*.pyc,debian/*"
