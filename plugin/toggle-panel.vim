command! TogglePanelQuickfixList call <SID>ToggleQuickfixList()
command! TogglePanelLocationList call <SID>ToggleLocationList()

function! s:ToggleQuickfixList()
	let num_windows = winnr("$")
	cclose
	if (winnr("$") == num_windows)
		copen
	endif
endfunction

function! s:ToggleLocationList()
	let is_location_list_focused = s:GetBufferTitle(bufnr('%')) == "[Location List]"
	if is_location_list_focused
		bdelete
		lclose
		return
	endif
	let num_windows = winnr("$")
	lclose
	if (winnr("$") == num_windows)
		silent! lopen
	endif
endfunction

function! s:GetBufferTitle(buffer_id)
	redir => output
	silent ls
	redir end
	for line in split(output, '\n')
		let is_active_buffer = (match(line, '\v^\s*' . a:buffer_id) != -1)
		if is_active_buffer
			return matchstr(line, '\v.*"\zs.*\ze"')
		endif
	endfor
	return ''
endfunction
