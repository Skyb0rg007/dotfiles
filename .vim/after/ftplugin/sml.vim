setlocal commentstring=(*\ %s\ *)
setlocal textwidth=0
setlocal tabstop=2
setlocal shiftwidth=2

let b:AutoPairs = { '(': ')', '[': ']', '{': '}', '"': '"' }

nnoremap <leader>ss :SMLReplStart<cr>
nnoremap <leader>sb :SMLReplBuild<cr>
nnoremap <leader>sc :SMLReplClear<cr>
