runtime! archlinux.vim

set nocompatible

filetype off

"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=~/.dein/repos/github.com/Shougo/dein.vim

" Required:
call dein#begin('~/.dein')

" Let dein manage dein
" Required:
call dein#add('Shougo/dein.vim')

call dein#add('othree/xml.vim')
call dein#add('eagletmt/ghcmod-vim')
call dein#add('eagletmt/neco-ghc')
call dein#add('ctrlpvim/ctrlp.vim')
call dein#add('plasticboy/vim-markdown')
call dein#add('scrooloose/nerdtree')
call dein#add('scrooloose/syntastic')
call dein#add('Shougo/vimproc.vim', {'build': 'make'})
call dein#add('tpope/vim-fireplace')
call dein#add('tpope/vim-fugitive')
call dein#add('leafgarland/typescript-vim')
call dein#add('KabbAmine/zeavim.vim')

" You can specify revision/branch/tag.
"call dein#add('Shougo/vimshell', { 'rev': '3787e5' })

" Required:
call dein#end()

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
"if dein#check_install()
"  call dein#install()
"endif

"End dein Scripts-------------------------

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

set background=dark

let mapleader = " "

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
autocmd FileType * set expandtab
set smarttab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set smartindent

autocmd FileType bib,erb,groovy,haskell,ruby,scala,tex,xml setlocal sts=2 ts=2 sw=2
autocmd FileType typescript setlocal sts=4 ts=4 sw=4
autocmd FileType make setlocal noexpandtab sts=4 ts=4 sw=4

" treat html files as xml (i.e. indentation and ftplugins)
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

" Shortcuts for moving between windows
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
nnoremap <C-S> <C-W><C-W>
nnoremap <C-N> <C-W>W

:nmap \e :NERDTreeToggle<CR>

" Typing 'jj' fast enough switches from insert to command mode
inoremap jj <Esc>

" Fugitive configuration
" Always split vertically
"set diffopt+=vertical
" Jump to next change with C-j
"nnoremap <expr> <C-j> &diff ? ']c' : '<C-W>j'
" Jump to previous change with C-k
"nnoremap <expr> <C-k> &diff ? '[c' : '<C-W>k'
" Use change from right side and update diff colors
"nnoremap <expr> <C-h> &diff ? ':diffget //3<CR>:diffupdate<CR>' : 'h'
" Use change from left side and update diff colors
"nnoremap <expr> <C-l> &diff ? ':diffget //2<CR>:diffupdate<CR>' : 'l'

let g:ctrlp_custom_ignore = {
  \ 'dir': '\.cabal-sandbox$',
  \ 'file': '\v.(dyn_hi|dyn_o|hi|o|p_hi|p_o|pyc)$',
  \ }

" Recommended Syntastic defaults
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

map <silent> te :GhcModCheck<CR>
map <silent> ts :GhcModSplitFunCase<CR>
map <silent> tt :GhcModType<CR>
map <silent> tc :GhcModTypeClear<CR>
map <silent> ti :GhcModTypeInsert<CR>

