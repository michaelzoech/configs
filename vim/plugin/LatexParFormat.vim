" ******************************************************
function! SingleLineLatexParEndings()
	" Creates the regexp that searches for single-line paragraph terminators
	let empty_s  = '^\s*'
	let empty_e  = '\s*$'
	let list  = [ '^\s*$'                   ] " an empty line
	let list += [ empty_s.'\$\$'.empty_e    ] " a line containing only '$$'
	let list += [ empty_s.'\\begin'         ] " a line starting with '\begin'
	let list += [ empty_s.'\\end'           ] " a line starting with '\end'
	let list += [ empty_s.'{'.empty_e       ] " a line containing only '{'
	let list += [ empty_s.'\\\a\+{'.empty_e ] " a line containing only '\anycommand{'
	let list += [ empty_s.'}'.empty_e       ] " a line containing only '}'
	let list += [ '.*%'                     ] " a line having a comment somewhere
	let list += [ empty_s.'\\\['.empty_e    ] " a line containing only '\['
	let list += [ empty_s.'\\\]'.empty_e    ] " a line containing only '\]'
	
	return join (list, '\|')
endfunction

" ******************************************************
function! MultiLineLatexParEndings()
	" Creates the regexp that searches for multi-line paragraph terminators,
	" i.e., terminators for which the text starts inlined after the terminator
	let empty_s  = '^\s*'
	let empty_e  = '\s*$'
	let list  = [ '^\s*$'                   ] " an empty line
	let list += [ empty_s.'\\item'          ] " a line starting with '\item'
	
	return join (list, '\|')
endfunction

" ******************************************************
" Position of the first occurrence before here (-1 if none)
function! SearchBackward(here, string, default)
	let savewrapscan = &wrapscan
	try

		set nowrapscan
		exe ":".(a:here+1)
		silent exe "?".a:string
		let str_occ = line(".")
	catch
		let str_occ = a:default
	endtry

	let &wrapscan = savewrapscan
	return str_occ
endfunction

" ******************************************************
" Position of the first occurrence after here (-1 if none)
function! SearchForward(here, string, default)
	let savewrapscan = &wrapscan
	try
		exe ":".(a:here-1)
		silent exe "/".a:string
		let str_occ = line(".")
	catch
		let str_occ = a:default
	endtry

	let &wrapscan = savewrapscan
	return str_occ
endfunction

" ******************************************************
" Beginning of the multiline comment (assuming current line is a comment)
" NB: a comment is a line that STARTS with %
function! CommentStart(here)
	return SearchBackward(a:here, '^[^%]\|^$', 0)+1
endfunction

" ******************************************************
" End of the multiline comment (assuming current line is a comment)
" NB: a comment is a line that STARTS with %
function! CommentEnd(here)
	return SearchForward(a:here, '^[^%]\|^$', line('$')+1)-1
endfunction

" ******************************************************
" Maximum among a set of positive numbers (negative numbers are not considered).
" If all numbers are negative, -1 is returned
function! Max(...)
	let max = -1
	let index = 1
	while index <= a:0
		exe "let cur=a:".index
		if cur > max
			let max = cur
		endif
		let index = index + 1
	endwhile
	return max
endfunction

" ******************************************************
" Minimum among a set of positive numbers (negative numbers are not considered).
" If all numbers are negative, -1 is returned
function! Min(...)
	let min = -1
	let index = 1
	while index <= a:0
		exe "let cur=a:".index
		if cur >= 0
			if cur < min || min == -1
				let min = cur
			endif
		endif
		let index = index + 1
	endwhile
	return min
endfunction
	
" ******************************************************
function! StandardParBegin(here)
	" Beginning of standard paragraph
	exe ":".a:here
	exe ':normal }'
	exe ":normal {"
	let pos = line(".")
	" Moves back to starting cursor position and exits
	exe ":".a:here
	return pos
endfunction

" ******************************************************
function! StandardParEnd(here)
	" Beginning of standard paragraph
	exe ":".a:here
	exe ':normal }'
	let pos = line(".")
	" Moves back to starting cursor position and exits
	exe ":".a:here
	return pos
endfunction

" ******************************************************
function! LatexParBegin(here)
	" Beginning of latex paragraph
	let slp = SearchBackward( a:here, SingleLineLatexParEndings(), 0) + 1
	let mlp = SearchBackward( a:here, MultiLineLatexParEndings(),  1)
	let pos = Min( a:here, Max ( slp, mlp ) )
	" Moves back to starting cursor position and exits
	exe ":".a:here
	return pos
endfunction

" ******************************************************
function! LatexParEnd(here)
	" Ending of latex paragraph
	let slp = SearchForward( a:here,   SingleLineLatexParEndings(), line('$')+1 ) - 1
	let mlp = SearchForward( a:here+1, MultiLineLatexParEndings(),  line('$')+1 ) - 1
	let pos = Max (a:here, Min (slp, mlp) )
	" Moves back to starting cursor position and exits
	exe ":".a:here
	return pos
endfunction

" ******************************************************
function! ParBegin(here)
	let tex_top = LatexParBegin(a:here)
	let par_top = StandardParBegin(a:here)
	let pos     = Max ( tex_top, par_top )
	" Moves back to starting cursor position and exits
	exe ":".a:here
	return pos
endfunction

" ******************************************************
function! ParEnd(here)
	let tex_bot = LatexParEnd(a:here)
	let par_bot = StandardParEnd(a:here)
	let pos     = Min( tex_bot, par_bot )
	" Moves back to starting cursor position and exits
	exe ":".a:here
	return pos
endfunction

" ******************************************************
function! FormatComment(here, lvl)
	" if we are on a comment, goes into the recursive mode
	let top   = CommentStart(a:here)
	let bot   = CommentEnd(a:here)

	let buf   = @%

	" copies the multiline comment, and cleans a bit around
	exe ':'.top.','.bot.'d'
	exe ':e '.buf.'.fmttmp'
	exe ':put!'
	" removes the comment
	exe ':%s/^%//'
	" goes at the right line
	exe ':'.(a:here-top+1)
	
	" recursive call of FormatLatexPar
	call FormatLatexPar(a:lvl+1)

	" remembers position in the file
	let next = line(".")
	" removes the empty line at the end
	exe ':normal G'
	if a:lvl==0
		" The undo can be joined only for the original buffer
		exe ':undojoin | d'
	else
		exe ':d'
	endif
	" puts back the comment character and copies the text into the register
	exe ':%s/^/%/'
	exe ':'.next
	exe ':%d'
	" deletes the temporary buffer
	exe ':bd!'
	" copies back the text in the original buffer
	exe ':b '.buf
	exe ':'.top-1
	if a:lvl==0
		" The undo can be joined only for the original buffer
		exe ':undojoin | put'
	else
		exe ':put'
	endif
	"goes at the next point
	return top + next - 1
endfunction

" ******************************************************
function! FormatLatexPar(lvl)
	" Remembers position (+1 because we are adding a starting line) 
	let here = line(".")

	" Stores window view
	if v:version >= 700 && a:lvl == 0
		let fmt_winview = winsaveview()
	endif

	" finds next comment (to see if we are upon a comment)
	let cmt   = SearchForward(here, '^%', -1)
	" first empty line
	let space = SearchForward(here, '^\s*$', -1)
	" finds next comment (to see if we the current line has a comment at some point)
	let cmt2  = SearchForward(here, '%', -1)
	
	if cmt == here
		" if we are on a comment, goes into the recursive mode
		let next = FormatComment(here,a:lvl)
	elseif cmt2 == here
		" We are on a line ending with a comment. Skip the line
		let next = here+1
	elseif space == here
		" if we are on an empty line, we merge possibly consecutive empty lines
		let next = here+1
	else
		" otherwise goes for the normal mode
	
		" Finds begin and end of paragraph
		let tex_top = LatexParBegin(here)
		let top     = ParBegin(here)
		let bot     = ParEnd(here)

		if top < tex_top
			" We are on top of a paragraph ending
			" We simply move to the following line (we don't want to
			" paragraph endings that are too long)
			let next = here+1
		else
			" We are in a standard paragraph
			
			" Formats the lines between top and bot
			silent exe ':'.top.','.bot.'!fmt'
	
			" Moves at the begin of the next paragraph
			exe ":".top
			exe ":".(ParEnd(here)+1)
			let next = line(".")
		endif
	endif

	" Restores window view
	if v:version >= 700 && a:lvl == 0
		call winrestview(fmt_winview)
	endif
	" Goes where it is supposed to go
	exe ':'.next
endfunction

" Maps FormatPar function to K
silent! unmap K
nnoremap <silent><buffer> K <ESC>:silent call FormatLatexPar(0)<CR>

