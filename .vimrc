""" Configure vim-plug
set nocompatible
filetype off
"let g:powerline_pycmd = 'py3'

" Begin vim-plug plugin loading
call plug#begin('~/.local/share/nvim/plugged')

" General
Plug 'airblade/vim-rooter'
Plug 'tpope/vim-repeat'
Plug 'vim-syntastic/syntastic'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-eunuch'
Plug 'terryma/vim-multiple-cursors'
if executable('git')
    Plug 'tpope/vim-fugitive'
    Plug 'airblade/vim-gitgutter'
endif

" Editor layout
Plug 'drmingdrmer/vim-tabbar'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdtree'
if executable('git')
    Plug 'Xuyuanp/nerdtree-git-plugin'
endif

" Jumping
" TODO: take a look at skim
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'yangmillstheory/vim-snipe'

" Formatting
Plug 'FooSoft/vim-argwrap'
Plug 'machakann/vim-sandwich'
Plug 'tpope/vim-commentary'
Plug 'editorconfig/editorconfig-vim'
Plug 'mattn/emmet-vim'

" Appearance
Plug 'chriskempson/base16-vim'

" Visual enhancers
Plug 'haya14busa/incsearch.vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'machakann/vim-highlightedyank'
Plug 'RRethy/vim-illuminate'

" File types
Plug 'cespare/vim-toml'
Plug 'maralla/vim-toml-enhance'
Plug 'dag/vim-fish'
Plug 'ekalinin/Dockerfile.vim'
Plug 'lervag/vimtex'
Plug 'plasticboy/vim-markdown'
Plug 'posva/vim-vue'
Plug 'tpope/vim-git'
Plug 'StanAngeloff/php.vim'

" Laravel related
" TODO: organize these plugins
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-projectionist'
Plug 'noahfrederick/vim-composer'
Plug 'noahfrederick/vim-laravel'
Plug 'jwalton512/vim-blade'

" Languages
Plug 'rust-lang/rust.vim', {'do': 'rustup component add rls rust-analysis rust-src rustfmt'}
if executable('cargo')
    Plug 'racer-rust/vim-racer', {'do': 'cargo +nightly install racer -f'}
endif
if executable('php') && executable('composer')
    Plug 'phpactor/phpactor', {'do': 'composer install', 'for': 'php'}
endif

" Linting/Completion
if has('nvim')
    Plug 'w0rp/ale'
    Plug 'autozimu/LanguageClient-neovim', {
        \ 'branch': 'next',
        \ 'do': 'bash install.sh',
        \ }

    Plug 'ncm2/ncm2'
    Plug 'roxma/nvim-yarp'

    " Completion enhancements
    Plug 'ncm2/ncm2-bufword'
    Plug 'ncm2/ncm2-tmux'
    Plug 'ncm2/ncm2-path'
    Plug 'ncm2/ncm2-github'
    if executable('cargo')
        Plug 'ncm2/ncm2-racer'
    endif
    Plug 'ncm2/ncm2-vim'
    if executable('php') && executable('composer')
        Plug 'phpactor/ncm2-phpactor'
    endif
    if executable('npm')
        Plug 'ncm2/ncm2-tern', {'do': 'npm install'}
    endif
    Plug 'Shougo/echodoc.vim'
endif

" End vim-plug plugin loading
call plug#end()



""" General
" We're using Vim, not Vi
set nocompatible

" We've a fast terminal
set ttyfast

" Use lazy redrawing to improve macOS performance
set lazyredraw

" We're using UTF-8 as file/script encoding
scriptencoding utf-8
set encoding=utf-8

" Detect file types and specific indents/settings
filetype on
filetype indent on
filetype plugin on

" Enable use of other .vimrc files in working directories
set exrc

" Use bash as shell (solve compatibility issues)
set shell=/bin/bash

" Set maximum map and key delays
set timeoutlen=500
set ttimeoutlen=0



""" Appearance
" Syntax highlighting
syntax enable

" Enable 256-color mode for terminals
if !has('gui_running')
    set t_Co=256
endif

" Colors
if (match($TERM, "-256color") != -1) && (match($TERM, "screen-256color") == -1)
  silent! set termguicolors
endif
set background=dark
let base16colorspace=256
silent! colorscheme base16-bright
hi Normal ctermbg=NONE

" Concealing
set conceallevel=2

" Airline theme
let g:airline_theme='base16'

" Relative line numbers
set relativenumber
set number

" Line number on the bar
set ruler

" Highlight the cursor line
set cursorline

" Highlight yanks for half a second
let g:highlightedyank_highlight_duration = 500

" Display tabs and trailing spaces visually
set list listchars=tab:\ \ ,trail:·

" Color rows that have lines longer than 81 columns, lines shouldn't be that
" long
"highlight ColorColumn ctermbg=magenta
"call matchadd('ColorColumn', '\v%81v', 100)
set colorcolumn=120
highlight ColorColumn ctermbg=234 guibg=#1C1C1C

" Highlight TODO
augroup HiglightTodo
    autocmd!
    autocmd WinEnter,VimEnter * :silent! call matchadd('Todo', 'TODO', -1)
    autocmd WinEnter,VimEnter * :silent! call matchadd('Todo', '@todo', -1)
augroup END

" Highlight matching brackets
set showmatch

" No text wrapping
set nowrap

" Disable code folding in Markdown
let g:vim_markdown_folding_disabled=1

" Show 8 rows, 16 columns around the cursor when scrolling, scroll by 1 column
set scrolloff=8
set sidescrolloff=16
set sidescroll=1

" Show commans being typed
set showcmd

" Two lines for the command line
set cmdheight=2

" Always show the status line
set laststatus=2

" Red underline for spelling errors
hi clear SpellBad
hi SpellBad cterm=underline ctermfg=009 guifg=#ff0000

" Matching bracket color
hi MatchParen cterm=bold ctermbg=none ctermfg=magenta

" Define the default Goyo size
let g:goyo_width=82



""" Editing
" Make backspace behaviour consistent, like other programs
set backspace=indent,eol,start

" Smart indents
set autoindent smartindent
set smarttab

" Integrate with system clipboard (not on macOS due to problems)
if has('unix') && !has('mac')
    set clipboard=unnamedplus,unnamed
endif



""" Code style
" Tab formatting with 4 spaces
set autoindent
set tabstop=4
set softtabstop=4
set expandtab
set fileformat=unix

" Shift 4 columns (rounded to nearest multiple)
set shiftwidth=4
set shiftround

" Lines should not be longer than 80 characters
set textwidth=80

" File specific configurations
autocmd FileType ansible,json,markdown,yaml setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType go setlocal shiftwidth=8 tabstop=8 softtabstop=8

" File specific commenting styles
autocmd FileType php setlocal comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/*,mb:*,ex:*/,://
autocmd FileType php,rust setlocal commentstring=//\ %s

" Arg wrap styles
autocmd FileType * unlet! argwrap_tail_comma
autocmd FileType javascript,rust let argwrap_tail_comma=1

" JavaScript highlighting workaround for Vue files
autocmd FileType vue syntax sync fromstart

" Trailing spaces warnings from airline
autocmd FileType * unlet! g:airline#extensions#whitespace#checks
autocmd FileType markdown let g:airline#extensions#whitespace#checks=['indent']

" Proper CSS completion
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS noci



""" Language
" English and Dutch spelling
set spelllang=en,nl

" Disable spell checking, enable for some files
set nospell
autocmd FileType markdown,txt,tex,bib,gitcommit setlocal spell



""" Other utilities and behaviour
" Ignore case sensitivity, unless there's a capital character
set ignorecase
set smartcase

" Wrap searching around
set wrapscan

" Highlight while searching, not after
set nohlsearch
set incsearch

" Live substitutions
if has('nvim')
    set inccommand=split
endif

" Store lots of history
set history=1000

" Find recursively in directories
set path+=**

" Show a bigger 'wildmenu' for things like tab completion
set wildmenu

" Split directions
set splitbelow
set splitright

" Always split fugitive diffs vertical
set diffopt+=vertical



""" Custom keybindings
" Enable the mouse
set mouse=a

" Map space and \ as leader keys
let mapleader=" "
let maplocalleader="\\"

" Use <space><space> to toggle to the last buffer
nnoremap <leader><leader> <c-^>

" Incsearch
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

" fzf/skim bindings
nnoremap <silent> <leader>o :Files<CR>
nnoremap <silent> <leader>O :Buffers<CR>
nnoremap <silent> <leader>A :Windows<CR>
nnoremap <leader>r :Rg 
nnoremap <silent> <leader>; :BLines<CR>
nnoremap <silent> <leader>: :History:<CR>
nnoremap <silent> <leader>? :History<CR>
nnoremap <silent> <leader>/ :History/<CR>
nnoremap <silent> <leader>gl :Commits<CR>
nnoremap <silent> <leader>ga :BCommits<CR>
nnoremap <silent> <leader>ft :Filetypes<CR>
nnoremap <silent> <leader>h :Helptags<CR>
"nnoremap <leader>/ :Ag 
"nnoremap <silent> <leader>o :BTags<CR>
"nnoremap <silent> <leader>O :Tags<CR>

" Vim multiple cursors
let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_start_word_key      = '<C-i>'
let g:multi_cursor_select_all_word_key = '<A-i>'
let g:multi_cursor_start_key           = 'g<C-i>'
let g:multi_cursor_select_all_key      = 'g<A-i>'
let g:multi_cursor_next_key            = '<C-i>'
let g:multi_cursor_prev_key            = '<C-k>'
let g:multi_cursor_skip_key            = '<C-x>'
let g:multi_cursor_quit_key            = '<Esc>'

" Use tab to complete
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Arg wrap
nnoremap <silent> <leader>a :ArgWrap<CR>

" Easy commenting
map // :Commentary<CR>

" Save
inoremap <C-s> <esc>:w<cr>
nnoremap <C-s> :w<cr>

" Auto expanding
inoremap (; (<CR>);<C-c>O
inoremap (, (<CR>),<C-c>O
inoremap {; {<CR>};<C-c>O
inoremap {, {<CR>},<C-c>O
inoremap [; [<CR>];<C-c>O
inoremap [, [<CR>],<C-c>O

" Split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Formatting paragraph with Q
vmap Q gq
nmap Q gqap

" " Vim snipe
map <leader>F <Plug>(snipe-F)
map <leader>f <Plug>(snipe-f)
map <leader>T <Plug>(snipe-T)

map <leader>w <Plug>(snipe-w)
map <leader>W <Plug>(snipe-W)
map <leader>e <Plug>(snipe-e)
map <leader>E <Plug>(snipe-E)
map <leader>b <Plug>(snipe-b)
map <leader>B <Plug>(snipe-B)
map <leader>ge <Plug>(snipe-ge)
map <leader>gE <Plug>(snipe-gE)

" Goyo toggle
nmap <silent> <leader>v :Goyo<CR>
xmap <silent> <leader>v :Goyo<CR>

" Limelight toggle
nmap <silent> <leader>l :Limelight!!<CR>
xmap <silent> <leader>l :Limelight!!<CR>

" Cursor column toggle
nmap <silent> <leader>c :set cursorcolumn!<CR>
xmap <silent> <leader>c :set cursorcolumn!<CR>

" NERDTree toggle and find
map <silent> <C-n> :NERDTreeToggle<CR>
map <silent> <leader><C-n> :NERDTreeFind<CR>

" Common typos
nnoremap q: :q
cnoreabbrev W w
cnoreabbrev Wq wq
cnoreabbrev WQ wq

" Fugitive shortcuts
cnoreabbrev Gc Gcommit
cnoreabbrev Gp Gpush
cnoreabbrev Gs Gstatus



""" Plugins
" fzf/skim
let g:fzf_nvim_statusline = 0

" Dragvisuals plugin
runtime plugin/dragvisuals.vim
vmap <expr> <LEFT>  DVB_Drag('left')
vmap <expr> <RIGHT> DVB_Drag('right')
vmap <expr> <DOWN>  DVB_Drag('down')
vmap <expr> <UP>    DVB_Drag('up')
vmap <expr> D       DVB_Duplicate()

" NCM2 if installed
if exists('ncm2#enable_for_buffer')
    " Enable NCM2 for all buffers
    autocmd BufEnter * call ncm2#enable_for_buffer()

    " Important tweaks for showing completion popups
    set completeopt=noinsert,menuone,noselect
endif

" NERDtree
" Open NERDtree when run with no arguments
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Properly close NERDTree
autocmd bufenter * if (winnr("$") == 1
    \ && exists("b:NERDTree")
    \ && b:NERDTree.isTabTree()) | q | endif

" Show hidden files by default, but hide Vim swap files
let NERDTreeShowHidden=1
let NERDTreeIgnore = ['\..*\.sw[pom]$']

" Toggle Limelight with Goyo
function! s:goyo_enter()
    " Enable Limelight
    Limelight
endfunction

function! s:goyo_leave()
    " Disable Limelight
    Limelight!
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

set shortmess=a
set cmdheight=2
set tw=120
set cc=120


" vimtex
" Set the vimtex PDF viewer to use
let g:vimtex_view_method="zathura"

let g:rustfmt_autosave = 1

map <leader>b :! cargo build --tests<CR>
map <leader>br :! cargo build --release<CR>

