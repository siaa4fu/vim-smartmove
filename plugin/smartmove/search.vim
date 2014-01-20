" File:        plugin/smartmove/search.vim
" Author:      sima (TwitterID: sima_fu)
" Namespace:   http://f-u.seesaa.net/
" Last Change: 2014-01-21.

scriptencoding utf-8

if exists('g:loaded_smartmove_search')
  finish
endif
let g:loaded_smartmove_search = 1

let s:save_cpo = &cpo
set cpo&vim

let s:do_mappings = get(g:, 'smartmove_search_do_mappings', {})
for kind in ['hlsearch', 'braces', 'jabraces', 'codes', 'jacodes', 'specialpats']
  if ! has_key(s:do_mappings, kind) || s:do_mappings[kind] != 0
    let s:do_mappings[kind] = 1
  endif
endfor
let g:smartmove_search_leader_key = get(g:, 'smartmove_search_leader_key', '')

if s:do_mappings.hlsearch
  call smartmove#search#init_hlsearch_mapping()
endif

call smartmove#search#init_mappings(s:do_mappings.braces, {
\ 'parens'  : ['b', '(', ')'],
\ 'brackets': ['B', '{', '}'],
\ 'braces'  : ['r', '[', ']'],
\ 'angles'  : ['a', '<', '>'],
\})

call smartmove#search#init_mappings(s:do_mappings.jabraces, {
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
\ 'jabraces-sumi-kakko'       : ['js'],
\})

call smartmove#search#init_mappings(s:do_mappings.codes, {
\ 'spaces'           : ['<Space>', 's'],
\ 'tabs'             : ['<Tab>', 't'],
\ 'blanks'           : ['S', 'T'],
\ 'double-quotes'    : ['"', 'd'],
\ 'single-quotes'    : ["'", 'q'],
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
\ 'ampersands'       : ['&', 'A'],
\ 'pipes'            : ['<Bar>', 'p'],
\ 'question-marks'   : ['?'],
\ 'exclamation-marks': ['!'],
\ 'slashs'           : ['/'],
\ 'back-slashs'      : ['\'],
\ 'carets'           : ['^'],
\ 'tildes'           : ['~'],
\ 'number-signs'     : ['#'],
\ 'dollar-signs'     : ['$'],
\ 'at-signs'         : ['@'],
\ 'percent-signs'    : ['%'],
\ 'stars'            : ['*'],
\ 'underscores'      : ['_'],
\})

call smartmove#search#init_mappings(s:do_mappings.jacodes, {
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
\ 'jacodes-slashs'       : ['j/'],
\})

call smartmove#search#init_mappings(s:do_mappings.specialpats, {
\ 'ordered-lists': ['o'],
\})

let &cpo = s:save_cpo
unlet s:save_cpo
