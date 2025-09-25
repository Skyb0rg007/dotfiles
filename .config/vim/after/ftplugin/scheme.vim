" R7RS
setlocal lispwords^=define-library,if,call-with-input-string

" Chibi-scheme
setlocal lispwords^=match,match-let,match-let*,match-lambda

" GNU Guile
setlocal lispwords^=define-module,define-public,call-with-prompt

" R6RS
setlocal lispwords^=library,syntax-case

" Nanopass
setlocal lispwords^=define-language,define-pass,trace-define-pass,with-output-language,nanopass-case

setlocal tabstop=2 shiftwidth=2
let b:AutoPairs = { '(': ')', '[': ']', '{': '}', '"': '"' }
