" File: autoload/smartmove/patsearch.vim

scriptencoding utf-8

let s:save_cpo = &cpoptions
set cpoptions&vim

let s:mapprefix = '<SID>/'
function! s:SID_prefix() " {{{
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_prefix$')
endfunction " }}}
function! s:unescape(key) " {{{
  let key = split(a:key, '\(<[^<>]\+>\|.\)\zs')
  call map(key, 'v:val =~ "^<.*>$" ? eval(''"\'' . v:val . ''"'') : v:val')
  return join(key, '')
endfunction " }}}

function! s:buildTable() " {{{
  let s:table = {}
  try
    for [patname, keylist] in items(g:smartmove_patsearch_keys)
      if !has_key(g:smartmove_patsearch_pats, patname)
        throw 'The patname of "' . patname . '" is not found in g:smartmove_patsearch_pats.'
      endif
      for key in keylist
        let key = s:unescape(key)
        let _t = s:table
        let i = 0
        while i < strlen(key)
          let char = key[i]
          if char == "\<Esc>" || char == "\<C-c>"
            " <Esc> と <C-c> は入力を中止するために予約済み
            throw 'The chars of "<Esc>" and "<C-c>" are not available in g:smartmove_patsearch_keys.'
          endif
          let isLastchar = i == strlen(key) - 1
          if has_key(_t, char)
            if type(_t[char]) == type('') || isLastchar
              throw 'The key of "' . key . '" has overlapped in g:smartmove_patsearch_keys.'
            endif
          else
            if isLastchar
              " 設定して次のキーへ
              let _t[char] = patname
              break
            endif
            let _t[char] = {}
          endif
          let _t = _t[char]
          let i += 1
        endwhile
      endfor
    endfor
  catch
    unlet s:table
    throw v:exception
  endtry
endfunction " }}}

function! s:patsearch(patname, ...) " {{{
  let pat = g:smartmove_patsearch_pats[a:patname]
  let objectSelection = get(a:, 1, '')
  call smartmove#patsearch(
  \   objectSelection == 'a' ? '\V' . pat[0] . '\%(\%(' . pat[1] . '\)\@!\.\)\*' . pat[1]
  \ : objectSelection == 'i' ? '\V' . pat[0] . '\zs\%(\%(' . pat[1] . '\)\@!\.\)\*\ze' . pat[1]
  \ : '\V\%(' . (pat[0] ==# pat[-1] ? pat[0] : pat[0] . '\|' . pat[-1]) . '\)\+'
  \)
endfunction " }}}
function! s:defineMaps(_t, key) " {{{
  for [char, _pat] in items(a:_t)
    if type(_pat) == type('')
      let isSurrounded = len(g:smartmove_patsearch_pats[_pat]) > 1
      " escape lhs and rhs literal-string
      let key = substitute(a:key . char, '\ze\%(\s\||\)', "\<C-v>", 'g')
      let _pat = substitute(substitute(_pat, '\ze|', "\<C-v>", 'g'), "'", "''", 'g')
      execute 'nnoremap <silent>'
            \ s:mapprefix . key
            \ ':<C-u>call <SID>patsearch(''' . _pat . ''')<CR>'
      if isSurrounded
        execute 'nnoremap <silent>'
              \ s:mapprefix . 'a' . key
              \ ':<C-u>call <SID>patsearch(''' . _pat . ''', ''a'')<CR>'
        execute 'nnoremap <silent>'
              \ s:mapprefix . 'i' . key
              \ ':<C-u>call <SID>patsearch(''' . _pat . ''', ''i'')<CR>'
      endif
    else
      call s:defineMaps(_pat, a:key . char)
    endif
    unlet _pat
  endfor
endfunction " }}}
function! smartmove#patsearch#map() " {{{
  try
    if !exists('s:table')
      call s:buildTable()
      " init mappings
      execute 'nnoremap ' . s:mapprefix . ' <Nop>'
      execute 'nnoremap ' . s:mapprefix . 'a <Nop>'
      execute 'nnoremap ' . s:mapprefix . 'i <Nop>'
      " map <CR> to toggle the 'hlsearch' option
      execute 'nnoremap <silent> ' . s:mapprefix . '<CR> :<C-u>set hlsearch!<CR>'
      call s:defineMaps(s:table, '')
    endif
    call feedkeys(s:unescape(substitute(s:mapprefix, '<SID>', s:SID_prefix(), 'g')), 'm')
  catch
    echohl ErrorMsg | echomsg v:exception | echohl None
  endtry
endfunction " }}}

let &cpoptions = s:save_cpo
unlet s:save_cpo
