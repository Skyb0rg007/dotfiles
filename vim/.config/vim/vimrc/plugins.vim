" All plugin settings

" ---- ALE ----
" Mapping to show error in window
nnoremap <leader>ae :ALEDetail<CR>
let g:ale_set_highlights = 0
" Shows the linter the error comes from
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s'
let g:ale_linters = {
    \ 'c': ['gcc'],
    \ 'cpp': ['clang','clangtidy','clang-format','cppcheck','cpplint','gcc'],
    \ 'asm': [],
    \ 'haskell': ['hlint'],
    \ 'erlang': ['syntaxerl'],
    \ } 
let g:ale_fixers = {
    \ 'haskell': ['stylish-haskell', 'trim_whitespace']
    \ }
" No clangcheck because it doesn't include c++11 standard
" No asm checker because it only uses gcc-inline assembler
let g:ale_sign_column_always = 1

let g:ale_prolog_swipl_load =
            \ 'current_prolog_flag(argv, [File]), load_files(File), halt.'
 
" ---- Tabular ----
" C-t in visual mode aligns
vnoremap <C-t> :Tab /

" ---- NerdTree ----
let g:loaded_netrw       = 1
let g:loaded_netrwPlugin = 1
nnoremap <C-t> :NERDTreeToggle<CR>
" C-t is to go back through tagstack, CTRL-Q is useless so we use it instead
nnoremap <C-q> <C-t>
let g:NERDTreeBookmarksFile=expand("~") . "/.cache/vim/NERDTreeBookmarks"

" ---- Lightline ----
set noshowmode    " Hides insert bar because Lightline takes care of it
set laststatus=2  " Needed to ensure Lightline is shown
set showtabline=1 " Show tab line as soon as there are at least 2
let g:bufferline_echo = 1
let g:lightline = {
      \ 'colorscheme': 'neodark',
      \ 'active': {
      \     'left':  [  ['mode', 'paste'],
      \                 ['fugitive', 'readonly', 'filename', 'modified'] ],
      \     'right': [  ['lineinfo'], ['percent'], 
      \                 ['linter_errors', 'linter_warnings', 'linter_ok'] ]
      \ },
      \ 'component': {
      \     'readonly': '%{&filetype=="help"?"":&readonly?"🔒":""}',
      \     'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
      \     'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}'
      \ },
      \ 'component_expand': {
      \     'linter_warnings': 'lightline#ale#warnings',
      \     'linter_errors': 'lightline#ale#errors',
      \     'linter_ok': 'lightline#ale#ok',
      \ },
      \ 'component_type': {
      \     'linter_warnings': 'warning',
      \     'linter_errors': 'error',
      \     'linter_ok': 'green',
      \ },
      \ 'component_visible_condition': {
      \     'readonly': '(&filetype!="help"&& &readonly)',
      \     'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
      \     'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
      \ },
      \ 'separator': { 'left': ' ', 'right': ' ' },
      \ 'subseparator': { 'left': ' ', 'right': ' ' }
      \ }
let g:lightline.tabline = {
    \ 'left': [ ['tabs'] ],
    \ 'right':[ ['close'] ] }
let g:lightline#ale#indicator_warnings = ""
let g:lightline#ale#indicator_errors = ""
let g:lightline#ale#indicator_ok = ""

" ---- UtiliSnips ----
let g:UltiSnipsExpandGrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" ---- EasyMotion ----
let g:EasyMotion_do_mapping=0 "Disable Defaults
let g:EasyMotion_smartcase=1
map <C-l> <Plug>(easymotion-lineforward)
map <C-j> <Plug>(easymotion-j)
map <C-k> <Plug>(easymotion-k)
map <C-h> <Plug>(easymotion-linebackward)

" ---- NERDCommenter ----
let g:NERDSpaceDelims = 1 " Add one space after comment 
nmap <Leader>co o<ESC><Leader>cA
nmap <Leader>cO O<ESC><Leader>cA
let g:NERDCustomDelimiters = {
            \ 'gforth': { 'left': '\', 'leftAlt': '(', 'rightAlt': ')' },
            \ 'forth':  { 'left': '\', 'leftAlt': '(', 'rightAlt': ')' }
            \ }

" ---- Clojure redl ----
let g:redl_use_vsplit = 1 " split REPL vertically
let g:rainbow_active  = 1 " Rainbow Paren active

" ---- Tagbar ----
nnoremap <F8> :TagbarToggle<CR>
let g:tagbar_type_haskell = {
    \ 'ctagsbin'  : 'hasktags',
    \ 'ctagsargs' : '-x -c -o-',
    \ 'kinds'     : [
        \  'm:modules:0:1',
        \  'd:data: 0:1',
        \  'd_gadt: data gadt:0:1',
        \  't:type names:0:1',
        \  'nt:new types:0:1',
        \  'c:classes:0:1',
        \  'cons:constructors:1:1',
        \  'c_gadt:constructor gadt:1:1',
        \  'c_a:constructor accessors:1:1',
        \  'ft:function types:1:1',
        \  'fi:function implementations:0:1',
        \  'o:others:0:1'
    \ ],
    \ 'sro'        : '.',
    \ 'kind2scope' : {
        \ 'm' : 'module',
        \ 'c' : 'class',
        \ 'd' : 'data',
        \ 't' : 'type'
    \ },
    \ 'scope2kind' : {
        \ 'module' : 'm',
        \ 'class'  : 'c',
        \ 'data'   : 'd',
        \ 'type'   : 't'
    \ }
\ }

" ---- Scratch ----
let g:scratch_insert_autohide = 0
nnoremap <silent> <leader>sp :ScratchPreview<CR>

" ---- Easytags ----
let g:easytags_async = 1
let g:easytags_auto_highlight = 0
let g:easytags_file = expand('$XDG_CACHE_HOME/vim/vimtags')

" ---- Auto-Pairs ----
let g:AutoPairsMapCh = 0

" ---- GitGutter ----
let g:gitgutter_enabled = 0

" ---- CamelCaseMotion ----
call camelcasemotion#CreateMotionMappings('<leader>')

" ---- Vim-Templates ----
let g:tmpl_auto_initialize = 0
let g:tmpl_search_paths = ['~/.vim/templates/']

" ---- Erlang Templates
let g:erl_author = 'Skye Soss'
