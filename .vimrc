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
Plug 'vim-airline/vim-airline-themes'
Plug 'flazz/vim-colorschemes'
Plug 'chriskempson/base16-vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'LnL7/vim-nix'
call plug#end()

filetype plugin indent on
set t_Co=256
syntax on
let base16colorspace=256  " Access colors present in 256 colorspace
"colo base16-tomorrow-night
colo Tomorrow-Night
set background=dark

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
" sudo write file
command FW execute ":w !sudo tee %"

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

"smartcase
set ignorecase
set smartcase

"mac delete problem
set backspace=2
set laststatus=2

" airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='base16_tomorrow'
let g:airline_powerline_fonts = 1

"set cscope database
"cs add cscope.out

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
    if hostname() == "tldr.local"
        let g:python3_host_prog = '/usr/local/bin/python3'
        let g:python2_host_prog = '/usr/local/bin/python2'
    elseif hostname() == "vaio"
        let g:python3_host_prog = '/run/current-system/sw/bin/nvim-python3'
    endif
    """ terminal buffer
    tnoremap <C-\><C-\> <C-\><C-n>
    "tnoremap <Esc> <C-\><C-n>

    """ deoplete
    let g:deoplete#enable_at_startup = 1
    """ %s/foo/bar live view
    set inccommand=nosplit
    """ unify clipboard
    set clipboard+=unnamedplus
    """
    set termguicolors

endif

"crontab
au FileType crontab setlocal bkc=yes

" json
autocmd BufNewFile,BufRead *.json set ft=javascript
nmap =j :%!python -m json.tool<CR>

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
highlight Search ctermfg=Black ctermbg=DarkCyan cterm=NONE
set smartcase

"completion color
":highlight Pmenu ctermbg=233 ctermfg=111 gui=bol
hi Pmenu        cterm=none ctermfg=White     ctermbg=DarkGrey
hi PmenuSel     cterm=none ctermfg=Black     ctermbg=37
"hi PmenuSbar    cterm=none ctermfg=none      ctermbg=Green
"hi PmenuThumb   cterm=none ctermfg=DarkGreen ctermbg=DarkGreen

" cursor shape on insert/normal mode
:set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor
" parentheses
hi MatchParen cterm=bold ctermbg=none ctermfg=magenta
