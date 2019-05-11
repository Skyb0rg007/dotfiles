" Vim syntax file
" Language: Alien
" Maintainer: Skye Soss
" Latest Revision: 11 June 2018

au BufRead,BufNewFile *.al set filetype=al

if exists("b:current_syntax")
    finish
endif

syn keyword alMacro REFER LOAD

syn keyword alKeyword if else elif fi for while fn endfn end var
syn keyword alFunction print println printf assert type

syn keyword alBoolean true false

syn match alOperator '\*\{1,2}'
syn match alOperator '+\{1,2}'
syn match alOperator '/\{1,2}'
syn match alOperator '-\{1,2}'
syn match alOperator '^\{1,2}'

syn match alNumber '[-+]\=\d*\.\=\d\+B\='

syn keyword alTodo contained TODO NOTE
syn match alComment '</.\{-}\(/>\|$\)' contains=alTodo
syn region alComment start=/<\/\/\// end=/\/\/\/>/ contains=alTodo

syn region alString start=/"/ skip=/\\./ end=/"/ contains=alInserted 
syn region alLongString start=/"""/ end=/"""/ 

syn match alInserted contained '\${[^}]*}'
syn match alInserted contained '\$[a-zA-Z_][a-zA-Z0-9_]*\'*'

syn match alIdentifier '[a-zA-Z_][a-zA-Z0-9_]*\'*'

let b:current_syntax = "alien"

hi def link alMacro       PreProc
hi def link alKeyword     Statement
hi def link alNumber      Constant
hi def link alTodo        Todo
hi def link alComment     Comment
hi def link alFunction    Function
hi def link alString      String
hi def link alLongString  String
hi def link alIdentifier  Identifier
hi def link alOperator    Operator
hi def link alInserted    Special
hi def link alBoolean     Boolean 
