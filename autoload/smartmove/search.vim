" File:        autoload/search/search.vim
" Author:      sima (TwitterID: sima_fu)
" Namespace:   http://f-u.seesaa.net/
" Last Change: 2013-09-25.

scriptencoding utf-8

let s:save_cpo = &cpo
set cpo&vim

" braces, jabraces, codes, jacodes, specific patterns
let s:pats = {
\ 'parens'                     : [ '('         , ')'                   , 1 ],
\ 'brackets'                   : [ '{'         , '}'                   , 1 ],
\ 'braces'                     : [ '['         , ']'                   , 1 ],
\ 'angles'                     : [ '<'         , '>'                   , 1 ],
\ 
\ 'jabraces-parens'            : [ '\[\uFF08]' , '\[\uFF09]'           , 1 ],
\ 'jabraces-brackets'          : [ '\[\uFF5B]' , '\[\uFF5D]'           , 1 ],
\ 'jabraces-braces'            : [ '\[\uFF3B]' , '\[\uFF3D]'           , 1 ],
\ 'jabraces-angles'            : [ '\[\uFF1C]' , '\[\uFF1E]'           , 1 ],
\ 'jabraces-double-angles'     : [ '\[\u226A]' , '\[\u226B]'           , 1 ],
\ 'jabraces-kakko'             : [ '\[\u300C]' , '\[\u300D]'           , 1 ],
\ 'jabraces-double-kakko'      : [ '\[\u300E]' , '\[\u300F]'           , 1 ],
\ 'jabraces-yama-kakko'        : [ '\[\u3008]' , '\[\u3009]'           , 1 ],
\ 'jabraces-double-yama-kakko' : [ '\[\u300A]' , '\[\u300B]'           , 1 ],
\ 'jabraces-kikkou-kakko'      : [ '\[\u3014]' , '\[\u3015]'           , 1 ],
\ 'jabraces-sumi-kakko'        : [ '\[\u3010]' , '\[\u3011]'           , 1 ],
\ 
\ 'spaces'                     : [ ' '                                 , 0 ],
\ 'tabs'                       : [ '\t'                                , 0 ],
\ 'blanks'                     : [ '\[ \t]'                            , 0 ],
\ 'double-quotes'              : [ '\["\u201c\u201d]'                  , 1 ],
\ 'single-quotes'              : [ '\[''\u2018\u2019]'                 , 1 ],
\ 'back-quotes'                : [ '`'                                 , 1 ],
\ 'commas'                     : [ ','                                 , 0 ],
\ 'periods'                    : [ '.'                                 , 0 ],
\ 'puncts'                     : [ ',.'                                , 0 ],
\ 'leaders'                    : [ '\%(\[\u2026]\<Bar>...\)'           , 0 ],
\ 'colons'                     : [ ':'                                 , 0 ],
\ 'semicolons'                 : [ ';'                                 , 0 ],
\ 'pluses'                     : [ '+'                                 , 0 ],
\ 'hyphenminuses'              : [ '\[-\00ad\u2010-\u2015]'            , 0 ],
\ 'equals'                     : [ '='                                 , 0 ],
\ 'ampersands'                 : [ '&'                                 , 0 ],
\ 'pipes'                      : [ '<Bar>'                             , 0 ],
\ 'question-marks'             : [ '?'                                 , 0 ],
\ 'exclamation-marks'          : [ '!'                                 , 0 ],
\ 'slashs'                     : [ '/'                                 , 1 ],
\ 'back-slashs'                : [ '\\'                                , 0 ],
\ 'carets'                     : [ '^'                                 , 0 ],
\ 'tildes'                     : [ '\[~\u2053]'                        , 0 ],
\ 'number-signs'               : [ '#'                                 , 0 ],
\ 'dollar-signs'               : [ '$'                                 , 0 ],
\ 'percent-signs'              : [ '\[%\u2030\u2031]'                  , 0 ],
\ 'at-signs'                   : [ '@'                                 , 0 ],
\ 'stars'                      : [ '*'                                 , 0 ],
\ 'underscores'                : [ '_'                                 , 0 ],
\ 
\ 'jacodes'                    : [ '\[^\x01-\x7E]'                     , 0 ],
\ 'jacodes-digits'             : [ '\[\uFF10-\uFF19]'                  , 0 ],
\ 'jacodes-alphas'             : [ '\[\uFF21-\uFF5A]'                  , 0 ],
\ 'jacodes-spaces'             : [ '\[\u3000\u2002\u2003\u2009]'       , 0 ],
\ 'jacodes-blanks'             : [ '\[\u3000\u2002\u2003\u2009\t]'     , 0 ],
\ 'jacodes-commas'             : [ '\[\u3001]'                         , 0 ],
\ 'jacodes-periods'            : [ '\[\u3002]'                         , 0 ],
\ 'jacodes-puncts'             : [ '\[\u3001\u3002]'                   , 0 ],
\ 'jacodes-leaders'            : [ '\[\u2025\u2026]'                   , 0 ],
\ 'jacodes-double-quotes'      : [ '\[\uFF02\u201C\u201D]'             , 1 ],
\ 'jacodes-single-quotes'      : [ '\[\uFF07\u2018\u2019]'             , 1 ],
\ 'jacodes-slashs'             : [ '\[\u2022\u25e6\uff0f\u30fb\uff65]' , 0 ],
\ 
\ 'ordered-lists'              : [ '\^\d\+\[.\uff0e] \?'               , 0 ],
\}

let g:smartmove_search_prefix_key = get(g:, 'smartmove_search_prefix_key', '')

function! smartmove#search#map(name, ...)
  if !has_key(s:pats, a:name) | return | endif
  let isSurrounded = s:pats[a:name][-1]
  let pat = [
  \ s:pats[a:name][0],
  \ len(s:pats[a:name]) > 2 ? s:pats[a:name][1] : s:pats[a:name][0]
  \]
  let pats = [
  \ substitute('\V\%(' . (pat[0] ==# pat[1] ? pat[0] : '\%(' . pat[0] . '\<Bar>' . pat[1] . '\)') . '\)\+', "'", "''", 'g'),
  \ substitute('\V' . pat[0] . '\%(\%(' . pat[1] . '\)\@!\.\)\*' . pat[1], "'", "''", 'g'),
  \ substitute('\V' . pat[0] . '\zs\%(\%(' . pat[1] . '\)\@!\.\)\*\ze' . pat[1], "'", "''", 'g'),
  \]
  for lhs in a:000
    execute 'nnoremap <silent>' g:smartmove_search_prefix_key . lhs
          \  ':<C-u>call smartmove#patsearch(''' . pats[0] . ''')<CR>'
    if isSurrounded
      execute 'nnoremap <silent>' g:smartmove_search_prefix_key . 'a' . lhs
            \  ':<C-u>call smartmove#patsearch(''' . pats[1] . ''')<CR>'
      execute 'nnoremap <silent>' g:smartmove_search_prefix_key . 'i' . lhs
            \  ':<C-u>call smartmove#patsearch(''' . pats[2] . ''')<CR>'
    endif
  endfor
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
