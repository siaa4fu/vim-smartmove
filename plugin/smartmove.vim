" File:        plugin/smartmove.vim
" Author:      sima (TwitterID: sima_fu)
" Namespace:   http://f-u.seesaa.net/
" Last Change: 2013-10-23.

scriptencoding utf-8

if exists('g:loaded_smartmove')
  finish
endif
let g:loaded_smartmove = 1

let s:save_cpo = &cpo
set cpo&vim

" motions are used instead of w, b, e, ge, n and N commands
"   *, #, g* and g# commands use n command
let g:smartmove_motions = get(g:, 'smartmove_motions', {})
" make *, #, g* and g# commands stay on a current word
let g:smartmove_no_jump_search = get(g:, 'smartmove_no_jump_search', 0)

" word-motions {{{
nnoremap <silent> <Plug>(smartmove-word-w)       :<C-u>call smartmove#word('w' ,'n')<CR>
nnoremap <silent> <Plug>(smartmove-word-b)       :<C-u>call smartmove#word('b' ,'n')<CR>
nnoremap <silent> <Plug>(smartmove-word-e)       :<C-u>call smartmove#word('e' ,'n')<CR>
nnoremap <silent> <Plug>(smartmove-word-ge)      :<C-u>call smartmove#word('ge','n')<CR>
xnoremap <silent> <Plug>(smartmove-word-w)       :<C-u>call smartmove#word('w' ,'x')<CR>
xnoremap <silent> <Plug>(smartmove-word-b)       :<C-u>call smartmove#word('b' ,'x')<CR>
xnoremap <silent> <Plug>(smartmove-word-e)       :<C-u>call smartmove#word('e' ,'x')<CR>
xnoremap <silent> <Plug>(smartmove-word-ge)      :<C-u>call smartmove#word('ge','x')<CR>
onoremap <silent> <Plug>(smartmove-word-w)       :<C-u>call smartmove#word('w' ,'o')<CR>
onoremap <silent> <Plug>(smartmove-word-b)       :<C-u>call smartmove#word('b' ,'o')<CR>
onoremap <silent> <Plug>(smartmove-word-e)       :<C-u>call smartmove#word('e' ,'o')<CR>
onoremap <silent> <Plug>(smartmove-word-ge)      :<C-u>call smartmove#word('ge','o')<CR>
inoremap <silent> <Plug>(smartmove-word-w)  <C-o>:<C-u>call smartmove#word('w' ,'i')<CR>
inoremap <silent> <Plug>(smartmove-word-b)  <C-o>:<C-u>call smartmove#word('b' ,'i')<CR>
inoremap <silent> <Plug>(smartmove-word-e)  <C-o>:<C-u>call smartmove#word('e' ,'i')<CR>
inoremap <silent> <Plug>(smartmove-word-ge) <C-o>:<C-u>call smartmove#word('ge','i')<CR>
" }}}

" left-right-motions {{{
nnoremap <silent> <Plug>(smartmove-home)      :<C-u>call smartmove#homeend(1,'n')<CR>
nnoremap <silent> <Plug>(smartmove-end)       :<C-u>call smartmove#homeend(0,'n')<CR>
xnoremap <silent> <Plug>(smartmove-home)      :<C-u>call smartmove#homeend(1,'x')<CR>
xnoremap <silent> <Plug>(smartmove-end)       :<C-u>call smartmove#homeend(0,'x')<CR>
onoremap <silent> <Plug>(smartmove-home)      :<C-u>call smartmove#homeend(1,'o')<CR>
onoremap <silent> <Plug>(smartmove-end)       :<C-u>call smartmove#homeend(0,'o')<CR>
inoremap <silent> <Plug>(smartmove-home) <C-o>:<C-u>call smartmove#homeend(1,'i')<CR>
inoremap <silent> <Plug>(smartmove-end)  <C-o>:<C-u>call smartmove#homeend(0,'i')<CR>
" }}}

" up-down-motions {{{
nnoremap <silent> <Plug>(smartmove-smoothscroll-f)      :<C-u>call smartmove#smoothscroll('down',2,'n',2)<CR>
nnoremap <silent> <Plug>(smartmove-smoothscroll-b)      :<C-u>call smartmove#smoothscroll('up'  ,2,'n',2)<CR>
nnoremap <silent> <Plug>(smartmove-smoothscroll-d)      :<C-u>call smartmove#smoothscroll('down',1,'n',2)<CR>
nnoremap <silent> <Plug>(smartmove-smoothscroll-u)      :<C-u>call smartmove#smoothscroll('up'  ,1,'n',2)<CR>
xnoremap <silent> <Plug>(smartmove-smoothscroll-f)      :<C-u>call smartmove#smoothscroll('down',2,'x',2)<CR>
xnoremap <silent> <Plug>(smartmove-smoothscroll-b)      :<C-u>call smartmove#smoothscroll('up'  ,2,'x',2)<CR>
xnoremap <silent> <Plug>(smartmove-smoothscroll-d)      :<C-u>call smartmove#smoothscroll('down',1,'x',2)<CR>
xnoremap <silent> <Plug>(smartmove-smoothscroll-u)      :<C-u>call smartmove#smoothscroll('up'  ,1,'x',2)<CR>
inoremap <silent> <Plug>(smartmove-smoothscroll-f) <C-o>:<C-u>call smartmove#smoothscroll('down',2,'i',2)<CR>
inoremap <silent> <Plug>(smartmove-smoothscroll-b) <C-o>:<C-u>call smartmove#smoothscroll('up'  ,2,'i',2)<CR>
inoremap <silent> <Plug>(smartmove-smoothscroll-d) <C-o>:<C-u>call smartmove#smoothscroll('down',1,'i',2)<CR>
inoremap <silent> <Plug>(smartmove-smoothscroll-u) <C-o>:<C-u>call smartmove#smoothscroll('up'  ,1,'i',2)<CR>
" }}}

" search-motions {{{
nnoremap <silent> <Plug>(smartmove-searchjump-n)       :<C-u>let &hlsearch = smartmove#searchjump('n' ,'n')<CR>
nnoremap <silent> <Plug>(smartmove-searchjump-N)       :<C-u>let &hlsearch = smartmove#searchjump('N' ,'n')<CR>
xnoremap <silent> <Plug>(smartmove-searchjump-n)       :<C-u>let &hlsearch = smartmove#searchjump('n' ,'x')<CR>
xnoremap <silent> <Plug>(smartmove-searchjump-N)       :<C-u>let &hlsearch = smartmove#searchjump('N' ,'x')<CR>
onoremap <silent> <Plug>(smartmove-searchjump-n)       :<C-u>let &hlsearch = smartmove#searchjump('n' ,'o')<CR>
onoremap <silent> <Plug>(smartmove-searchjump-N)       :<C-u>let &hlsearch = smartmove#searchjump('N' ,'o')<CR>
inoremap <silent> <Plug>(smartmove-searchjump-n)  <C-o>:<C-u>let &hlsearch = smartmove#searchjump('n' ,'i')<CR>
inoremap <silent> <Plug>(smartmove-searchjump-N)  <C-o>:<C-u>let &hlsearch = smartmove#searchjump('N' ,'i')<CR>
nnoremap <silent> <Plug>(smartmove-searchjump-*)       :<C-u>let v:searchforward = smartmove#starsearch('*' ,'n')<CR>
nnoremap <silent> <Plug>(smartmove-searchjump-#)       :<C-u>let v:searchforward = smartmove#starsearch('#' ,'n')<CR>
nnoremap <silent> <Plug>(smartmove-searchjump-g*)      :<C-u>let v:searchforward = smartmove#starsearch('g*','n')<CR>
nnoremap <silent> <Plug>(smartmove-searchjump-g#)      :<C-u>let v:searchforward = smartmove#starsearch('g#','n')<CR>
xnoremap <silent> <Plug>(smartmove-searchjump-*)       :<C-u>let v:searchforward = smartmove#starsearch('*' ,'x')<CR>
xnoremap <silent> <Plug>(smartmove-searchjump-#)       :<C-u>let v:searchforward = smartmove#starsearch('#' ,'x')<CR>
xnoremap <silent> <Plug>(smartmove-searchjump-g*)      :<C-u>let v:searchforward = smartmove#starsearch('g*','x')<CR>
xnoremap <silent> <Plug>(smartmove-searchjump-g#)      :<C-u>let v:searchforward = smartmove#starsearch('g#','x')<CR>
" }}}

let &cpo = s:save_cpo
unlet s:save_cpo
