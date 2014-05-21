" File:        autoload/smartmove.vim
" Author:      sima (TwitterID: sima_fu)
" Namespace:   http://f-u.seesaa.net/

scriptencoding utf-8

let s:save_cpo = &cpo
set cpo&vim

function! s:precmd(mode, o_v) " {{{
  if a:mode ==# 'x'
    normal! gv
  elseif a:mode ==# 'o' && a:o_v
    normal! v
  endif
endfunction " }}}

function! s:skipClosedFold(moveForward) " {{{
  let l = line('.')
  if a:moveForward && foldclosedend(l) > -1
    " move forward to the last line in a closed fold
    let l = foldclosedend(l)
    call cursor(l, col([l, '$']))
    return 1
  elseif !a:moveForward && foldclosed(l) > -1
    " move backward to the first line in a closed fold
    let l = foldclosed(l)
    call cursor(l, 1)
    return 0
  endif
  return -1
endfunction " }}}

" ref. kana/vim-arpeggio
function! s:unescape_lhs(escaped_lhs) " {{{
  let keys = split(a:escaped_lhs, '\(<[^<>]\+>\|.\)\zs')
  call map(keys, 'v:val =~ "^<.*>$" ? eval(''"\'' . v:val . ''"'') : v:val')
  return join(keys, '')
endfunction " }}}

function! s:exeMotion(motion, mode) " {{{
  if has_key(g:smartmove_motions, a:motion)
  \ && !empty(maparg(g:smartmove_motions[a:motion], a:mode))
    execute 'normal' s:unescape_lhs(g:smartmove_motions[a:motion])
  else
    silent execute 'normal!' a:motion
  endif
endfunction " }}}

function! smartmove#word(motion, mode) " {{{
  let cnt = v:count1
  let moveForward =
        \   a:motion ==# 'w' || a:motion ==# 'e'  ? 1
        \ : a:motion ==# 'b' || a:motion ==# 'ge' ? 0
        \ : 1
  call s:precmd(a:mode,
        \ a:motion ==# 'e' || a:motion ==# 'ge')
  for i in range(cnt)
    let isEOL = s:skipClosedFold(moveForward)
    let l = line('.')
    if isEOL < 0
      " 現在の位置が行末かどうかを判定
      "   行がマルチバイト文字で終わるとき、 col('.') == col('$') - 1 では判定できない
      let c = col('.')
      normal! $
      let isEOL = col('.') == c
      call cursor(l, c)
    endif
    " 単語移動
    call s:exeMotion(a:motion, a:mode)
    let _l = line('.')
    let _c = col('.')
    if l == _l
      " 移動後も同じ行なので終了
    elseif moveForward
      if isEOL == 0
        " 同じ行の行末に移動
        call cursor(l, col([l, '$']))
      elseif _l - l > 1
        if nextnonblank(l + 1) < _l
          " 次の空行ではない行に移動 (w, e は、それぞれ行頭、行末)
          let l = nextnonblank(l + 1)
          call cursor(l, col([l, '$']))
          if a:motion ==# 'w'
            normal! ^
          endif
        else
          " 適した移動先が見付からなかったとき
          call cursor(_l, _c)
        endif
      endif
    elseif !moveForward
      if l - _l > 1
        if prevnonblank(l - 1) > _l
          " 前の空行ではない行に移動 (b, ge は、それぞれ行頭、行末)
          let l = prevnonblank(l - 1)
          call cursor(l, col([l, '$']))
          if a:motion ==# 'b'
            normal! ^
          endif
        else
          " 適した移動先が見付からなかったとき
          call cursor(_l, _c)
        endif
      endif
    endif
  endfor
endfunction " }}}

function! smartmove#wiw(motion, mode) " {{{
  let cnt = v:count1
  let moveForward =
        \   a:motion ==# 'w' || a:motion ==# 'e'  ? 1
        \ : a:motion ==# 'b' || a:motion ==# 'ge' ? 0
        \ : 1
  call s:precmd(a:mode,
        \ a:motion ==# 'e' || a:motion ==# 'ge')
  " rhysd/vim-textobj-wiw の regexp を参考
  let wiw_head = '\%(\(\<.\)\|\(\u\l\|\l\@<=\u\)\|\(\A\@<=\a\)\)'
  let wiw_tail = '\%(\(.\>\)\|\(\l\u\@=\|\u\%(\u\l\)\@=\)\|\(\a\A\@=\)\)'
  let pat =
        \   a:motion ==# 'w' || a:motion ==# 'b'  ? wiw_head
        \ : a:motion ==# 'e' || a:motion ==# 'ge' ? wiw_tail
        \ : wiw_head
  for i in range(cnt)
    let isMoved = search(pat, (moveForward ? '' : 'b') . 'W') > 0
    if !isMoved | break | endif
  endfor
endfunction " }}}

function! smartmove#home(mode) " {{{
  call s:precmd(a:mode, 1)
  let c = col('.')
  if c > 1
    silent execute 'normal! h' . (&wrap ? 'g^' : '^')
    if col('.') == c
      silent execute 'normal!' . (&wrap ? 'g0' : '0')
    endif
  else
    normal! ^
  endif
endfunction " }}}
function! smartmove#end(mode) " {{{
  call s:precmd(a:mode, 1)
  let c = col('.')
  if c < col('$') - 1
    silent execute 'normal! l' . (&wrap ? 'g$' : '$')
  else
    normal! g_
  endif
endfunction " }}}

function! smartmove#smoothscroll(motion, mode) " {{{
  let cnt = v:count1
  let scrollForward =
        \   a:motion ==# 'f' || a:motion ==# 'd' ? 1
        \ : a:motion ==# 'b' || a:motion ==# 'u' ? 0
        \ : 1
  let unit =
        \   a:motion ==# 'f' || a:motion ==# 'b' ? 2
        \ : a:motion ==# 'd' || a:motion ==# 'u' ? 1
        \ : 2
  call s:precmd(a:mode, 1)
  let n = (winheight(0) / 2) * cnt * unit
  if scrollForward
    let n = min([n, line('$') - line('w$')])
    let key = line('.') == line('w$') ? "\<C-e>j" : "j\<C-e>"
  else
    let n = min([n, line('w0') - 1])
    let key = line('.') == line('w0') ? "\<C-y>k" : "k\<C-y>"
  endif
  let i = cnt * unit * g:smartmove_scroll_speed
  while n > 0
    let n -= 1
    silent execute 'normal!' key
    if n % i == 0
      redraw
    endif
  endwhile
endfunction " }}}

function! smartmove#searchjump(motion, mode) " {{{
  let cnt = v:count1
  let moveForward =
        \ a:motion ==# (v:searchforward ? 'n' : 'N')
  call s:precmd(a:mode, 0)
  let startline = line('.')
  try
    for i in range(cnt)
      call s:skipClosedFold(moveForward)
      call s:exeMotion(a:motion, a:mode)
    endfor
  catch /^Vim\%((\a\+)\)\=:E486/
    echohl WarningMsg | echomsg split(v:exception, '^Vim\%((\a\+)\)\=:')[-1] | echohl None
    return &hlsearch
  endtry
  let endline = line('.')
  if ((moveForward && line('.') == line('w$'))
  \ || (!moveForward && line('.') == line('w0'))
  \ ) && startline != endline
    normal! zz
  endif
  return 1
endfunction " }}}

function! smartmove#patsearch(pat, ...) " {{{
  let @/ = a:pat
  call histadd('/', a:pat)
  let v:searchforward = get(a:, 1, 1)
  " if a mapping is still being executed, characters in feedkeys() come after them
  if g:smartmove_no_jump_search
    call feedkeys(":\<C-u>set hlsearch | echo\<CR>", 'n')
  else
    call feedkeys("\<Plug>(smartmove-searchjump-n)", 'm')
  endif
endfunction " }}}

function! s:getSelection() " {{{
  let save_regs = [
  \ [getreg('v', 1), getregtype('v')],
  \ [getreg('"', 1), getregtype('"')]
  \]
  try
    normal! gv"vy
    return @v
  finally
    call setreg('v', save_regs[0][0], save_regs[0][1])
    call setreg('"', save_regs[1][0], save_regs[1][1])
  endtry
endfunction " }}}

function! smartmove#starsearch(motion, mode) " {{{
  let pat = substitute(escape(
  \ a:mode == 'x' ? s:getSelection() : expand('<cword>'),
  \ '\'), '\n', '\\n', 'g')
  if a:motion ==# '*' || a:motion ==# '#'
    let pat = '\<' . pat . '\>'
  endif
  " v:searchforward is restored when returning from a function
  let v:searchforward =
        \   a:motion ==# '*' || a:motion ==# 'g*' ? 1
        \ : a:motion ==# '#' || a:motion ==# 'g#' ? 0
        \ : v:searchforward
  call smartmove#patsearch('\V' . pat, v:searchforward)
  return v:searchforward
endfunction " }}}

let &cpo = s:save_cpo
unlet s:save_cpo
