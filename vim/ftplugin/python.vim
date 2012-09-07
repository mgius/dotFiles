"set omnifunc=pythoncomplete#Complete
"let g:SuperTabDefaultCompletionType = "context"
let g:pydiction_location = '/home/mgius/.vim/bundle/pydiction/complete-dict'

set completeopt=menuone,longest,preview

hi SpellBad term=standout ctermbg=1 ctermfg=15 gui=undercurl guisp=Red

" PEP8
set tabstop=4
set shiftwidth=4
set softtabstop=4

" Pylint magic
set makeprg=pylint\ --rcfile=~/.pylintrc\ --reports=n\ --output-format=parseable\ %:p
set errorformat=%f:%l:\ %m
"autocmd BufWritePost *.py make
map <leader>wf :w<CR>:make<CR>:cw<CR>
