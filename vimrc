call plug#begin('~/.vim/plugged')
if !has("nvim")
    Plug 'Shougo/neocomplete.vim'
endif
if has("nvim")
    "Plug 'neocomplcache.vim'
    Plug 'benekastah/neomake'
    Plug 'Shougo/deoplete.nvim'
endif
Plug 'bling/vim-airline'
Plug 'rstacruz/vim-closer'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'derekwyatt/vim-scala'
"Plug 'ensime/ensime-vim'
Plug 'fatih/vim-go'
"Plug 'scrooloose/syntastic'
call plug#end()

filetype plugin indent on
set t_Co=256
colo desert
syntax on

" save when leave insert mode
"autocmd InsertLeave * write

"indents
filetype indent on
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

"disable .viminfo
set viminfo=

command! WQ wq
command! Wq wq
command! W w
command! Q q

"save
nnoremap <Esc>w :w<CR>
"window split movement
noremap <C-H> <C-W>h
noremap <C-J> <C-W>j
noremap <C-K> <C-W>k
noremap <C-L> <C-W>l

""" press tab to complete
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <C-@> <c-x><c-o>
""" onmin completion
"set omnifunc=syntaxcomplete#Complete
"set completeopt=longest,menuone

""" NerdTree
noremap <C-n> :NERDTreeToggle<CR>
""" buffer
noremap <leader>[ :bprev<CR>
noremap <leader>] :bnext<CR>
noremap <leader>w :bd<CR>
noremap Q :q<CR>
""" fzf
noremap <leader>ff :FZF

" pane
" map <C-w> :q<CR>
" set screen split char to space
set fillchars-=vert:\| | set fillchars+=vert:\ 
highlight VertSplit cterm=reverse ctermfg=darkgrey

"tab cycle
set wildmode=longest,list,full
set wildmenu

"split windows the way i like
set splitbelow
set splitright

"set line number
set number
set rnu
"spell check
set spelllang=en_gb

"mac delete problem
set backspace=2
set laststatus=2

" airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline_left_sep=''
let g:airline_right_sep=''

"set cscope database
cs add cscope.out

"for crontab to work
if $VIM_CRONTAB == "true"
    set nobackup
    set nowritebackup
endif

" vim only
if !has("nvim")
    "neocomplete, lua not supported by neovim
    let g:neocomplete#enable_at_startup = 1
    let g:neocomplete#enable_smart_case = 1
    let g:neocomplete#sources#syntax#min_keyword_length = 3
    let g:neocomplete#enable_auto_close_preview = 1
    " <CR>: close popup and save indent.
    inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
    function! s:my_cr_function()
        "return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
        " For no inserting <CR> key.
        return pumvisible() ? "\<C-y>" : "\<CR>"
    endfunction
endif

" neovim only
if has("nvim")
    let g:python3_host_prog = '/usr/local/bin/python3'
    let g:python_host_prog = '/usr/local/bin/python3'
    """ terminal buffer
    tnoremap <Esc> <C-\><C-n>

    """ deoplete
    let g:deoplete#enable_at_startup = 1
    "let g:deoplete#omni_patterns = {}
   	"let g:deoplete#omni_patterns.scala = '[^. *\t]\.\w\{3,}'
    ""let g:deoplete#omni#input_patterns = {}
    ""let g:deoplete#omni#input_patterns.scala = '[^. *\t]\.\w*'
    "let g:deoplete#sources = {}
    "let g:deoplete#sources._=['omni', 'buffer', 'member', 'tag', 'ultisnips', 'file']

    """" Neomake
    function! s:getfile()
        let fext = expand("%:t")
        let f = "a.out"
        if len(fext) > 2
            let f = split(fext, '\.')[0]
        endif
        return f
    endfunction

    function! s:run()
        execute "!./" . s:getfile()
    endfunction


    "autocmd! BufWritePost * Neomake
    nnoremap <Esc>f :w<CR>:Neomake<CR>
    nnoremap <Esc>e :Neomake!<CR>
    nnoremap <Esc>r :call <SID>run()<CR>

    let g:neomake_c_clang_maker = {
    \ 'exe': 'clang',
    \ 'args': ['-std=c99', '-Wall', '-ggdb', '-o', s:getfile()],
    \ 'errorformat': '%f:%l:%c: %m',
    \ }

    let g:neomake_cpp_clang_maker = {
    \ 'exe': 'clang++',
    \ 'args': ['-std=c++11', '-Wall', '-ggdb', '-o', s:getfile()],
    \ 'errorformat': '%f:%l:%c: %m',
    \ }

endif

"crontab
au FileType crontab setlocal bkc=yes

" scala
au FileType scala nnoremap <localleader>t :EnType<CR>
au FileType scala nnoremap <localleader>tt :EnTypeCheck<CR>
au FileType scala nnoremap <localleader>ds :EnDeclaration<CR>
au FileType scala nnoremap <localleader>dv :EnDeclaration v<CR>
au FileType scala nnoremap <localleader>sd :EnDocBrowse<CR>

" go
au FileType go nnoremap <leader>r <Plug>(go-run)
au FileType go nnoremap <leader>b <Plug>(go-build)
au FileType go nnoremap <leader>t <Plug>(go-test)
au FileType go nnoremap <leader>c <Plug>(go-coverage)
au FileType go nnoremap <leader>rt <Plug>(go-run-tab)
au FileType go nnoremap <Leader>rs <Plug>(go-run-split)
au FileType go nnoremap <Leader>rv <Plug>(go-run-vertical)
au FileType go nnoremap <Leader>ds <Plug>(go-def-split)
au FileType go nnoremap <Leader>dv <Plug>(go-def-vertical)
au FileType go nnoremap <Leader>dt <Plug>(go-def-tab)
au FileType go nnoremap <Leader>gd <Plug>(go-doc)
au FileType go nnoremap <Leader>gv <Plug>(go-doc-vertical)
au FileType go nnoremap <Leader>s <Plug>(go-implements)
au FileType go nnoremap <Leader>i <Plug>(go-info)

"Synastic
let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = ' -std=c++11 -stdlib=libc++'
let g:syntastic_cpp_check_header = 1

"""""" HIGHLIGHTS 

"set line number to grey
highlight LineNr ctermfg=darkgrey

"hightlight current line number
set cursorline
highlight CursorLine cterm=None

"highlight search
" \ q for rm highlight
set hlsearch
nnoremap <silent> <leader>q :nohlsearch<CR>
highlight Search ctermfg=Black ctermbg=yellow cterm=NONE

"completion color
":highlight Pmenu ctermbg=233 ctermfg=111 gui=bol
hi Pmenu        cterm=none ctermfg=White     ctermbg=DarkGrey
hi PmenuSel     cterm=none ctermfg=Black     ctermbg=37
"hi PmenuSbar    cterm=none ctermfg=none      ctermbg=Green
"hi PmenuThumb   cterm=none ctermfg=DarkGreen ctermbg=DarkGreen

" cursor shape on insert/normal mode
:let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
" parentheses
hi MatchParen cterm=bold ctermbg=none ctermfg=magenta

"blue ~
":hi NonText ctermfg=Black

