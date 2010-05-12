runtime! archlinux.vim

syntax on

colorscheme mydesert

"set background=dark

"set showcmd		" Show (partial) command in status line.
set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
set smartcase		" Do smart case matching
"set incsearch		" Incremental search
"set autowrite		" Automatically save before commands like :next and :make
"set hidden             " Hide buffers when they are abandoned
set mouse=a		" Enable mouse usage (all modes) in terminals

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

" tikz files are latex files
au FileType tikz set filetype=latex

" tabs
autocmd FileType * set noexpandtab
set smarttab
set tabstop=4
set shiftwidth=4
set smartindent

" use 2 spaces for a tab
autocmd FileType haskell,rb,tex,bib,xml set expandtab softtabstop=2 tabstop=2 shiftwidth=2
autocmd FileType tex set textwidth=70

set ruler

" project plugin
let g:proj_flags="imstvg"
map <C-T> <Esc>:tabnew<CR><Plug>ToggleProject/
nmap <silent> <F3> <Plug>ToggleProject

" show trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$\| \+\ze\t/

" remove trailing whitespace and those ^M
function Trimws()
	%s/[ \t\r]\+$//eg
endfunction

let g:GetLatestVimScripts_allowautoinstall=1

set pastetoggle=<F12>

