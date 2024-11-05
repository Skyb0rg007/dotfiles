" vim: ft=vim ts=2 sw=2 et
" Language: Algol 60
" Extensions: *.alg
" Last Change: 2023-12-18

if exists("b:current_syntax")
  finish
endif
let b:current_syntax = "algol"

syn case match

syn keyword algolBoolean     true false
syn keyword algolStatement   begin end goto procedure
syn match   algolStatement   "\<go to\>"
syn keyword algolLabel       label 
syn keyword algolConditional if then else
syn keyword algolRepeat      for step until do while
syn keyword algolType        array boolean Boolean integer real string
syn keyword algolStorage     own value
syn match   algolLabel       display "\<\I\i\s*:"

syn region algolString start=+"+ excludenl end=+"+ contains=algolStringEscape
syn match algolStringEscape contained '""'

syn region algolComment start="\<comment\>" end=";"

syn match algolNumber display "[0-9]*\(\.[0-9]\+\)\="

syn keyword algolTodo contained TODO FIXME XXX
syn cluster algolCommentGroup contains=algolTodo

hi def link algolString      String
hi def link algolBoolean     Boolean
hi def link algolNumber      Number
hi def link algolComment     Comment
hi def link algolConditional Conditional
hi def link algolRepeat      Repeat
hi def link algolStatement   Statement
hi def link algolStorage     StorageClass
hi def link algolTodo        Todo
hi def link algolType        Type
hi def link algolLabel       Label

" syn keyword algolKeyword begin code do else end false for goto if label own
" syn keyword algolKeyword procedure step switch then until value while
