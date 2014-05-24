" File:        plugin/smartmove.vim
" Author:      sima (TwitterID: sima_fu)
" Namespace:   http://f-u.seesaa.net/

scriptencoding utf-8

if exists('g:loaded_smartmove')
  finish
endif
let g:loaded_smartmove = 1

let s:save_cpo = &cpo
set cpo&vim

" motions are used instead of w, b, e, ge, n and N commands
" *, #, g* and g# commands use n command
let g:smartmove_motions = get(g:, 'smartmove_motions', {})
" scroll speed (non-negative integer)
let g:smartmove_scroll_speed = get(g:, 'smartmove_scroll_speed', 1)
" make *, #, g* and g# commands stay on a current word
let g:smartmove_no_jump_search = get(g:, 'smartmove_no_jump_search', 0)

" word-motions {{{
nnoremap <silent> <Plug>(smartmove-word-w)  :<C-u>call smartmove#word('w', 'n')<CR>
nnoremap <silent> <Plug>(smartmove-word-b)  :<C-u>call smartmove#word('b', 'n')<CR>
nnoremap <silent> <Plug>(smartmove-word-e)  :<C-u>call smartmove#word('e', 'n')<CR>
nnoremap <silent> <Plug>(smartmove-word-ge) :<C-u>call smartmove#word('ge', 'n')<CR>
xnoremap <silent> <Plug>(smartmove-word-w)  :<C-u>call smartmove#word('w', 'x')<CR>
xnoremap <silent> <Plug>(smartmove-word-b)  :<C-u>call smartmove#word('b', 'x')<CR>
xnoremap <silent> <Plug>(smartmove-word-e)  :<C-u>call smartmove#word('e', 'x')<CR>
xnoremap <silent> <Plug>(smartmove-word-ge) :<C-u>call smartmove#word('ge', 'x')<CR>
onoremap <silent> <Plug>(smartmove-word-w)  :<C-u>call smartmove#word('w', 'o')<CR>
onoremap <silent> <Plug>(smartmove-word-b)  :<C-u>call smartmove#word('b', 'o')<CR>
onoremap <silent> <Plug>(smartmove-word-e)  :<C-u>call smartmove#word('e', 'o')<CR>
onoremap <silent> <Plug>(smartmove-word-ge) :<C-u>call smartmove#word('ge', 'o')<CR>
inoremap <silent> <Plug>(smartmove-word-w)  <C-o>:<C-u>call smartmove#word('w', 'i')<CR>
inoremap <silent> <Plug>(smartmove-word-b)  <C-o>:<C-u>call smartmove#word('b', 'i')<CR>
inoremap <silent> <Plug>(smartmove-word-e)  <C-o>:<C-u>call smartmove#word('e', 'i')<CR>
inoremap <silent> <Plug>(smartmove-word-ge) <C-o>:<C-u>call smartmove#word('ge', 'i')<CR>
" }}}

" wiw-motions {{{
nnoremap <silent> <Plug>(smartmove-wiw-w)  :<C-u>call smartmove#wiw('w', 'n')<CR>
nnoremap <silent> <Plug>(smartmove-wiw-b)  :<C-u>call smartmove#wiw('b', 'n')<CR>
nnoremap <silent> <Plug>(smartmove-wiw-e)  :<C-u>call smartmove#wiw('e', 'n')<CR>
nnoremap <silent> <Plug>(smartmove-wiw-ge) :<C-u>call smartmove#wiw('ge', 'n')<CR>
xnoremap <silent> <Plug>(smartmove-wiw-w)  :<C-u>call smartmove#wiw('w', 'x')<CR>
xnoremap <silent> <Plug>(smartmove-wiw-b)  :<C-u>call smartmove#wiw('b', 'x')<CR>
xnoremap <silent> <Plug>(smartmove-wiw-e)  :<C-u>call smartmove#wiw('e', 'x')<CR>
xnoremap <silent> <Plug>(smartmove-wiw-ge) :<C-u>call smartmove#wiw('ge', 'x')<CR>
onoremap <silent> <Plug>(smartmove-wiw-w)  :<C-u>call smartmove#wiw('w', 'o')<CR>
onoremap <silent> <Plug>(smartmove-wiw-b)  :<C-u>call smartmove#wiw('b', 'o')<CR>
onoremap <silent> <Plug>(smartmove-wiw-e)  :<C-u>call smartmove#wiw('e', 'o')<CR>
onoremap <silent> <Plug>(smartmove-wiw-ge) :<C-u>call smartmove#wiw('ge', 'o')<CR>
inoremap <silent> <Plug>(smartmove-wiw-w)  <C-o>:<C-u>call smartmove#wiw('w', 'i')<CR>
inoremap <silent> <Plug>(smartmove-wiw-b)  <C-o>:<C-u>call smartmove#wiw('b', 'i')<CR>
inoremap <silent> <Plug>(smartmove-wiw-e)  <C-o>:<C-u>call smartmove#wiw('e', 'i')<CR>
inoremap <silent> <Plug>(smartmove-wiw-ge) <C-o>:<C-u>call smartmove#wiw('ge', 'i')<CR>
" }}}

" left-right-motions {{{
nnoremap <silent> <Plug>(smartmove-home) :<C-u>call smartmove#home('n')<CR>
nnoremap <silent> <Plug>(smartmove-end)  :<C-u>call smartmove#end('n')<CR>
xnoremap <silent> <Plug>(smartmove-home) :<C-u>call smartmove#home('x')<CR>
xnoremap <silent> <Plug>(smartmove-end)  :<C-u>call smartmove#end('x')<CR>
onoremap <silent> <Plug>(smartmove-home) :<C-u>call smartmove#home('o')<CR>
onoremap <silent> <Plug>(smartmove-end)  :<C-u>call smartmove#end('o')<CR>
inoremap <silent> <Plug>(smartmove-home) <C-o>:<C-u>call smartmove#home('i')<CR>
inoremap <silent> <Plug>(smartmove-end)  <C-o>:<C-u>call smartmove#end('i')<CR>
" }}}

" up-down-motions {{{
nnoremap <silent> <Plug>(smartmove-smoothscroll-f) :<C-u>call smartmove#smoothscroll('f', 'n')<CR>
nnoremap <silent> <Plug>(smartmove-smoothscroll-b) :<C-u>call smartmove#smoothscroll('b', 'n')<CR>
nnoremap <silent> <Plug>(smartmove-smoothscroll-d) :<C-u>call smartmove#smoothscroll('d', 'n')<CR>
nnoremap <silent> <Plug>(smartmove-smoothscroll-u) :<C-u>call smartmove#smoothscroll('u', 'n')<CR>
xnoremap <silent> <Plug>(smartmove-smoothscroll-f) :<C-u>call smartmove#smoothscroll('f', 'x')<CR>
xnoremap <silent> <Plug>(smartmove-smoothscroll-b) :<C-u>call smartmove#smoothscroll('b', 'x')<CR>
xnoremap <silent> <Plug>(smartmove-smoothscroll-d) :<C-u>call smartmove#smoothscroll('d', 'x')<CR>
xnoremap <silent> <Plug>(smartmove-smoothscroll-u) :<C-u>call smartmove#smoothscroll('u', 'x')<CR>
inoremap <silent> <Plug>(smartmove-smoothscroll-f) <C-o>:<C-u>call smartmove#smoothscroll('f', 'i')<CR>
inoremap <silent> <Plug>(smartmove-smoothscroll-b) <C-o>:<C-u>call smartmove#smoothscroll('b', 'i')<CR>
inoremap <silent> <Plug>(smartmove-smoothscroll-d) <C-o>:<C-u>call smartmove#smoothscroll('d', 'i')<CR>
inoremap <silent> <Plug>(smartmove-smoothscroll-u) <C-o>:<C-u>call smartmove#smoothscroll('u', 'i')<CR>
" }}}

" search-motions {{{
nnoremap <silent> <Plug>(smartmove-searchjump-n)  :<C-u>call smartmove#searchjump('n', 'n')<CR>
nnoremap <silent> <Plug>(smartmove-searchjump-N)  :<C-u>call smartmove#searchjump('N', 'n')<CR>
xnoremap <silent> <Plug>(smartmove-searchjump-n)  :<C-u>call smartmove#searchjump('n', 'x')<CR>
xnoremap <silent> <Plug>(smartmove-searchjump-N)  :<C-u>call smartmove#searchjump('N', 'x')<CR>
onoremap <silent> <Plug>(smartmove-searchjump-n)  :<C-u>call smartmove#searchjump('n', 'o')<CR>
onoremap <silent> <Plug>(smartmove-searchjump-N)  :<C-u>call smartmove#searchjump('N', 'o')<CR>
inoremap <silent> <Plug>(smartmove-searchjump-n)  <C-o>:<C-u>call smartmove#searchjump('n', 'i')<CR>
inoremap <silent> <Plug>(smartmove-searchjump-N)  <C-o>:<C-u>call smartmove#searchjump('N', 'i')<CR>
nnoremap <silent> <Plug>(smartmove-searchjump-*)  :<C-u>call smartmove#starsearch('*' , 'n')<CR>
nnoremap <silent> <Plug>(smartmove-searchjump-#)  :<C-u>call smartmove#starsearch('#' , 'n')<CR>
nnoremap <silent> <Plug>(smartmove-searchjump-g*) :<C-u>call smartmove#starsearch('g*', 'n')<CR>
nnoremap <silent> <Plug>(smartmove-searchjump-g#) :<C-u>call smartmove#starsearch('g#', 'n')<CR>
xnoremap <silent> <Plug>(smartmove-searchjump-*)  :<C-u>call smartmove#starsearch('*' , 'x')<CR>
xnoremap <silent> <Plug>(smartmove-searchjump-#)  :<C-u>call smartmove#starsearch('#' , 'x')<CR>
xnoremap <silent> <Plug>(smartmove-searchjump-g*) :<C-u>call smartmove#starsearch('g*', 'x')<CR>
xnoremap <silent> <Plug>(smartmove-searchjump-g#) :<C-u>call smartmove#starsearch('g#', 'x')<CR>
" }}}

let &cpo = s:save_cpo
unlet s:save_cpo
