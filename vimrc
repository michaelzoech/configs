runtime! archlinux.vim

set nocompatible

filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#begin()

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

" http://vim-scripts.org/vim/scripts.html
Bundle 'xml.vim'

" Github
Bundle 'kien/ctrlp.vim'
Bundle 'plasticboy/vim-markdown'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/syntastic'
Bundle 'tpope/vim-fugitive'

call vundle#end()

filetype plugin indent on
syntax on

"set showcmd		" Show (partial) command in status line.
set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
set smartcase		" Do smart case matching
"set hlsearch       " Highlight current search
"set incsearch      " Highlight as you type a search expression
"set autowrite		" Automatically save before commands like :next and :make
set hidden       " Hide buffers when they are abandoned
set mouse=a      " Enable mouse usage (all modes) in terminals

colorscheme railscasts

"set background=dark

let mapleader = ","

set matchpairs+=<:>

" Scroll the viewport faster by 3 lines
nnoremap <C-e> <C-e><C-e><C-e>
nnoremap <C-y> <C-y><C-y><C-y>

" Scroll buffer if cursor hits less than x lines on border
set scrolloff=3

" Show ↪ at the beginning of wrapped lines
let &sbr = nr2char(8618).' '

set visualbell

" default tab settings
autocmd FileType * set noexpandtab
set smarttab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set smartindent

autocmd FileType groovy,scala,ruby,haskell,tex,bib,xml,erb setlocal sts=2 ts=2 sw=2 expandtab
"autocmd FileType tex set textwidth=70

" treat html files as xml (i.e. indentation and ftplugins)
autocmd BufNewFile,BufRead *.html,*.htm set filetype=xml
autocmd BufNewFile,BufRead *.gradle set filetype=groovy

set ruler

" show trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$\| \+\ze\t/

" remove trailing whitespace and those ^M
function Trimws()
	%s/[ \t\r]\+$//eg
endfunction

set pastetoggle=<F12>

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif

"set grepprg=grep\ -nH\ $*
"let g:tex_flavor = "latex"

" Moving up/down per displayed line instead "real" line
:nmap j gj
:nmap k gk

"shortcut to toggle whitespace display
nmap <leader>l :set list!<CR>
set listchars=tab:▸\ ,eol:¬

" shortcuts for working with buffers and files
map <Leader>t :CtrlP<Return>
map <Leader>n :bprev<Return>
map <Leader>s :bnext<Return>
map <Leader>d :bd<Return>
" the space at the end is needed/wanted
map <Leader>f :b 

:nmap \e :NERDTreeToggle<CR>

" Typing 'jj' fast enough switches from insert to command mode
inoremap jj <Esc>

" Fugitive configuration
" Always split vertically
set diffopt+=vertical
" Jump to next change with C-j
nnoremap <expr> <C-j> &diff ? ']c' : '<C-W>j'
" Jump to previous change with C-k
nnoremap <expr> <C-k> &diff ? '[c' : '<C-W>k'
" Use change from right side and update diff colors
nnoremap <expr> <C-h> &diff ? ':diffget //3<CR>:diffupdate<CR>' : 'h'
" Use change from left side and update diff colors
nnoremap <expr> <C-l> &diff ? ':diffget //2<CR>:diffupdate<CR>' : 'l'

