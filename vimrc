runtime! archlinux.vim

set nocompatible

filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

" http://vim-scripts.org/vim/scripts.html
Bundle 'vim-coffee-script'
Bundle 'xml.vim'

" Github
Bundle 'Shougo/neocomplcache'

filetype plugin indent on
syntax on

"set showcmd		" Show (partial) command in status line.
set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
set smartcase		" Do smart case matching
"set incsearch		" Incremental search
"set autowrite		" Automatically save before commands like :next and :make
set hidden       " Hide buffers when they are abandoned
set mouse=a      " Enable mouse usage (all modes) in terminals

colorscheme mydesert

"set background=dark

let mapleader = ","

" Scroll the viewport faster by 3 lines
nnoremap <C-e> <C-e><C-e><C-e>
nnoremap <C-y> <C-y><C-y><C-y>

" Highlight search terms
"set hlsearch
"set incsearch

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

"shortcut to toggle whitespace display
nmap <leader>l :set list!<CR>
set listchars=tab:▸\ ,eol:¬

" shortcuts for working with buffers and files
map <Leader>t :CommandT<Return>
map <Leader>n :bprev<Return>
map <Leader>s :bnext<Return>
map <Leader>d :bd<Return>
" the space at the end is needed/wanted
map <Leader>f :b 

" Typing 'jj' fast enough switches from insert to command mode
inoremap jj <Esc>

" neocomplcache plugin
let g:acp_enableAtStartup = 0
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
let g:neocomplcache_enable_auto_select = 1

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
    \ }

" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
  let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

inoremap <expr> <C-g> neocomplcache#undo_completion()
inoremap <expr> <C-l> neocomplcache#complete_common_string()
inoremap <expr> <CR> pumvisible() ? neocomplcache#close_popup() : "\<CR>"
"inoremap <expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr> <C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr> <BS> neocomplcache#smart_close_popup()."\<C-h>"
"inoremap <expr> <C-y>  neocomplcache#close_popup()
inoremap <expr> <C-e>  neocomplcache#cancel_popup()

autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.c = '\%(\.\|->\)\h\w*'
let g:neocomplcache_omni_patterns.cpp = '\h\w*\%(\.\|->\)\h\w*\|\h\w*::'

