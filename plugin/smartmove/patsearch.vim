" File:        plugin/smartmove/patsearch.vim
" Author:      sima (TwitterID: sima_fu)
" Namespace:   http://f-u.seesaa.net/

scriptencoding utf-8

if exists('g:loaded_smartmove_patsearch')
  finish
endif
let g:loaded_smartmove_patsearch = 1

let s:save_cpo = &cpo
set cpo&vim

let g:smartmove_patsearch_pats = get(g:, 'smartmove_patsearch_pats', {})
let g:smartmove_patsearch_keys = get(g:, 'smartmove_patsearch_keys', {})
let g:smartmove_patsearch_enable_default =
      \ extend(get(g:, 'smartmove_patsearch_enable_default', {}),
      \ {
      \   'braces': 1,
      \   'jabraces': 1,
      \   'codes': 1,
      \   'jacodes': 1,
      \}, 'keep')

function! s:extend(varname, dict) " {{{
  let g:smartmove_patsearch_{a:varname} =
        \ extend(g:smartmove_patsearch_{a:varname}, a:dict, 'keep')
endfunction " }}}
if g:smartmove_patsearch_enable_default.braces
  call s:extend('pats', {
  \ 'parens'  : ['(', ')'],
  \ 'brackets': ['{', '}'],
  \ 'braces'  : ['[', ']'],
  \ 'angles'  : ['<', '>']
  \})
  call s:extend('keys', {
  \ 'parens'  : ['b', '(', ')', '8', '9'],
  \ 'brackets': ['B', '{', '}'],
  \ 'braces'  : ['r', '[', ']'],
  \ 'angles'  : ['a', '<', '>']
  \})
endif
if g:smartmove_patsearch_enable_default.jabraces
  call s:extend('pats', {
  \ 'jabraces-parens'           : ['\[\uFF08]', '\[\uFF09]'],
  \ 'jabraces-brackets'         : ['\[\uFF5B]', '\[\uFF5D]'],
  \ 'jabraces-braces'           : ['\[\uFF3B]', '\[\uFF3D]'],
  \ 'jabraces-angles'           : ['\[\uFF1C]', '\[\uFF1E]'],
  \ 'jabraces-double-angles'    : ['\[\u226A]', '\[\u226B]'],
  \ 'jabraces-kakko'            : ['\[\u300C]', '\[\u300D]'],
  \ 'jabraces-double-kakko'     : ['\[\u300E]', '\[\u300F]'],
  \ 'jabraces-yama-kakko'       : ['\[\u3008]', '\[\u3009]'],
  \ 'jabraces-double-yama-kakko': ['\[\u300A]', '\[\u300B]'],
  \ 'jabraces-kikkou-kakko'     : ['\[\u3014]', '\[\u3015]'],
  \ 'jabraces-sumi-kakko'       : ['\[\u3010]', '\[\u3011]']
  \})
  call s:extend('keys', {
  \ 'jabraces-parens'           : ['jb', 'j(', 'j)'],
  \ 'jabraces-brackets'         : ['jB', 'j{', 'j}'],
  \ 'jabraces-braces'           : ['jr', 'j[', 'j]'],
  \ 'jabraces-angles'           : ['ja', 'j<', 'j>'],
  \ 'jabraces-double-angles'    : ['jA'],
  \ 'jabraces-kakko'            : ['jk'],
  \ 'jabraces-double-kakko'     : ['jK'],
  \ 'jabraces-yama-kakko'       : ['jy'],
  \ 'jabraces-double-yama-kakko': ['jY'],
  \ 'jabraces-kikkou-kakko'     : ['jt'],
  \ 'jabraces-sumi-kakko'       : ['js']
  \})
endif
if g:smartmove_patsearch_enable_default.codes
  call s:extend('pats', {
  \ 'spaces'           : [' '],
  \ 'tabs'             : ['\t'],
  \ 'blanks'           : ['\[ \t]'],
  \ 'double-quotes'    : ['\["\u201c\u201d]', '\["\u201c\u201d]'],
  \ 'single-quotes'    : ['\[''\u2018\u2019]', '\[''\u2018\u2019]'],
  \ 'back-quotes'      : ['`', '`'],
  \ 'commas'           : [','],
  \ 'periods'          : ['.'],
  \ 'puncts'           : [',.'],
  \ 'leaders'          : ['\%(\[\u2026]\|...\)'],
  \ 'colons'           : [':'],
  \ 'semicolons'       : [';'],
  \ 'pluses'           : ['+'],
  \ 'hyphenminuses'    : ['\[-\00ad\u2010-\u2015]'],
  \ 'equals'           : ['='],
  \ 'ampersands'       : ['&'],
  \ 'pipes'            : ['|'],
  \ 'question-marks'   : ['?'],
  \ 'exclamation-marks': ['!'],
  \ 'slashs'           : ['/', '/'],
  \ 'back-slashs'      : ['\\'],
  \ 'carets'           : ['^'],
  \ 'tildes'           : ['\[~\u2053]'],
  \ 'number-signs'     : ['#'],
  \ 'dollar-signs'     : ['$'],
  \ 'percent-signs'    : ['\[%\u2030\u2031]'],
  \ 'at-signs'         : ['@'],
  \ 'stars'            : ['*'],
  \ 'underscores'      : ['_']
  \})
  call s:extend('keys', {
  \ 'spaces'           : ['<Space>', 's'],
  \ 'tabs'             : ['<Tab>', 't'],
  \ 'blanks'           : ['S', 'T'],
  \ 'double-quotes'    : ['"', 'd', '2'],
  \ 'single-quotes'    : ["'", 'q', '7'],
  \ 'back-quotes'      : ['`'],
  \ 'commas'           : [',', 'c'],
  \ 'periods'          : ['.'],
  \ 'puncts'           : ['C'],
  \ 'leaders'          : ['l'],
  \ 'colons'           : [':'],
  \ 'semicolons'       : [';'],
  \ 'pluses'           : ['+'],
  \ 'hyphenminuses'    : ['-'],
  \ 'equals'           : ['=', 'e'],
  \ 'ampersands'       : ['&', '6'],
  \ 'pipes'            : ['<Bar>', 'p'],
  \ 'question-marks'   : ['?'],
  \ 'exclamation-marks': ['!', '1'],
  \ 'slashs'           : ['/'],
  \ 'back-slashs'      : ['\'],
  \ 'carets'           : ['^'],
  \ 'tildes'           : ['~'],
  \ 'number-signs'     : ['#', '3'],
  \ 'dollar-signs'     : ['$', '4'],
  \ 'at-signs'         : ['@'],
  \ 'percent-signs'    : ['%', '5'],
  \ 'stars'            : ['*'],
  \ 'underscores'      : ['_']
  \})
endif
if g:smartmove_patsearch_enable_default.jacodes
  call s:extend('pats', {
  \ 'jacodes'              : ['\[^\x01-\x7E]'],
  \ 'jacodes-digits'       : ['\[\uFF10-\uFF19]'],
  \ 'jacodes-alphas'       : ['\[\uFF21-\uFF5A]'],
  \ 'jacodes-spaces'       : ['\[\u3000\u2002\u2003\u2009]'],
  \ 'jacodes-blanks'       : ['\[\u3000\u2002\u2003\u2009\t]'],
  \ 'jacodes-commas'       : ['\[\u3001]'],
  \ 'jacodes-periods'      : ['\[\u3002]'],
  \ 'jacodes-puncts'       : ['\[\u3001\u3002]'],
  \ 'jacodes-leaders'      : ['\[\u2025\u2026]'],
  \ 'jacodes-double-quotes': ['\[\uFF02\u201C\u201D]', '\[\uFF02\u201C\u201D]'],
  \ 'jacodes-single-quotes': ['\[\uFF07\u2018\u2019]', '\[\uFF07\u2018\u2019]'],
  \ 'jacodes-slashs'       : ['\[\u2022\u25e6\uff0f\u30fb\uff65]']
  \})
  call s:extend('keys', {
  \ 'jacodes'              : ['zz'],
  \ 'jacodes-digits'       : ['zd'],
  \ 'jacodes-alphas'       : ['za'],
  \ 'jacodes-spaces'       : ['j<Space>'],
  \ 'jacodes-blanks'       : ['jS', 'jT'],
  \ 'jacodes-commas'       : ['j,', 'jc'],
  \ 'jacodes-periods'      : ['j.'],
  \ 'jacodes-puncts'       : ['jC'],
  \ 'jacodes-leaders'      : ['jl'],
  \ 'jacodes-double-quotes': ['j"', 'jd'],
  \ 'jacodes-single-quotes': ["j'", 'jq'],
  \ 'jacodes-slashs'       : ['j/']
  \})
endif

" mappings
nnoremap <silent> <Plug>(smartmove-patsearch) :<C-u>call smartmove#patsearch#map()<CR>

let &cpo = s:save_cpo
unlet s:save_cpo
