set nocompatible " Disable Vi compatibility

" Hide vim's generated files in XDG directories
if empty($XDG_CACHE_HOME) | let $XDG_CACHE_HOME = $HOME.'/.cache'       | endif
if empty($XDG_STATE_HOME) | let $XDG_STATE_HOME = $HOME.'/.local/state' | endif
set backupdir=$XDG_STATE_HOME/vim/backup | call mkdir(&backupdir, 'p')
set directory=$XDG_STATE_HOME/vim/swap   | call mkdir(&directory, 'p')
set undodir=$XDG_STATE_HOME/vim/undo     | call mkdir(&undodir,   'p')
set viewdir=$XDG_STATE_HOME/vim/view     | call mkdir(&viewdir,   'p')
set viminfofile=$XDG_STATE_HOME/vim/viminfo

" (OCaml) ocp-indent
set runtimepath^=$XDG_DATA_HOME/opam/default/share/ocp-indent/vim

" Vim Plug
call plug#begin($HOME.'/.vim/plugged')

" Plugins for all filetypes
Plug 'dense-analysis/ale'        " Linter
Plug 'KeitaNakamura/neodark.vim' " Colorscheme
Plug 'itchyny/lightline.vim'     " Status bar
Plug 'maximbaz/lightline-ale'    " Status bar ALE integration
Plug 'bling/vim-bufferline'      " Show buffers in the command bar
Plug 'jiangmiao/auto-pairs'      " Auto parenthesis insertion
Plug 'junegunn/vim-easy-align'   " Alignment plugin
Plug 'tpope/vim-surround'        " Mappings for surrounding text
Plug 'tpope/vim-repeat'          " Allow repeating plugin maps
Plug 'tpope/vim-speeddating'     " Let <C-A>/<C-X> recognize dates
Plug 'tpope/vim-unimpaired'      " Miscellaneous bracket mappings
Plug 'tpope/vim-commentary'      " Minimal commenting plugin (maps gc<movement>)
Plug 'tpope/vim-vinegar'         " Netrw assistance
Plug 'tpope/vim-dadbod'          " Database stuff
Plug 'tpope/vim-fugitive'        " Git stuff
Plug 'ctrlpvim/ctrlp.vim'        " Fuzzy search

" LISP
Plug 'guns/vim-sexp'             " S-Expression handling
Plug 'luochen1990/rainbow'       " Rainbow parentheses
Plug 'tpope/vim-sexp-mappings-for-regular-people' " Sane S-Expression mappings

" LEAN
Plug 'leanprover/lean.vim'

" jq
Plug 'vito-c/jq.vim'

" Coq
Plug 'whonore/Coqtail'           " Coq environment

" Agda
Plug 'derekelkins/agda-vim'      " Agda environment

" Souffle Datalog
Plug 'souffle-lang/souffle.vim'  " Syntax highlighting

" BQN
Plug 'mlochbaum/BQN', { 'rtp': 'editors/vim' }

" Koka
Plug 'Nymphium/vim-koka'

" LaTex
Plug 'lervag/vimtex', { 'for': 'tex' }

" LLVM
Plug 'rhysd/vim-llvm'

" Dhall
Plug 'vmchale/dhall-vim'

" Elm
Plug 'elm-tooling/elm-vim'

" Markdown
Plug 'iamcco/markdown-preview.nvim', {'do': 'cd app && npm install'}

" Standard ML
Plug 'Skyb0rg007/vim-better-sml'

" Purescript
Plug 'purescript-contrib/purescript-vim'

" Raku
Plug 'Raku/vim-raku'

" Vimscript
Plug 'junegunn/vader.vim'

call plug#end()

let g:skip_loading_mswin = 1

" Syntax highlighting
syntax enable
filetype on
filetype indent on
filetype plugin on
set termguicolors
set background=dark
colorscheme neodark
let g:neodark#background = '#202020'

" General settings
set autoindent " Copy indent from current line when starting a new line
set autoread " Re-read a file when a change occurs
set backspace=indent,eol,start " Allow backspacing over everything
set complete=".,w,b,u,t" " Completes by looking at (loaded & unloaded) buffers, windows, tags
set display+=lastline " Show the last line as much as possible
set encoding=utf-8 " Force utf8
set expandtab " Tabs are replaced by spaces
set formatoptions="tcqj" " Auto-wrap text and comments, gq formats comments, remove comment when joining lines
set hlsearch " Highlight the search
set incsearch " Show search results incrementally
set laststatus=2 " Always show status
set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+ " How to display non-print chars
set mouse=a " Allow full mouse integration
set nowrap " No line wrapping
set nrformats-=octal " <C-A> doesn't recognize octal constants
set ruler " Show line+column in the bottom right
set scrolloff=1 " Cursor is 1 line from top/bottom
set shiftwidth=4 " '>' is 4 spaces
set sidescrolloff=5 " Cursor is 5 rows from left/right
set smarttab " Tab inserts spaces up to the tab stop
set timeoutlen=1000 ttimeoutlen=0 " Don't wait after i_CTRL-[
set tabstop=4 " Tabs are 4 spaces
set textwidth=0 wrapmargin=0 " Don't auto-insert newlines
set wildmenu " Completion is enhanced
set wildmode=full " Complete the next full match
set colorcolumn=80 " Highlight the 80th column
set hidden " Allows you to close a dirty buffer without saving
set exrc secure " Allow for a local .vimrc to override these settings
set splitright " Split below and to the right
set t_Co=256 " Number of colors
set visualbell " Disable alarm
set path=.,/usr/include/,/usr/include/x86_64-linux-gnu/,,

" Folds
set foldmethod=indent
set foldnestmax=5
set foldlevelstart=99
set foldcolumn=0

" Cursor is a line in insert mode and a block in normal mode
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

" Show the cursor line in normal mode
set cursorline
autocmd InsertLeave,BufEnter * set cursorline
autocmd InsertEnter,BufLeave * set nocursorline

" For mouse handling on WSL
set ttymouse=sgr

" Use Vim's manpage plugin
runtime ftplugin/man.vim
set keywordprg=:Man

"--- Mappings ---

" <C-L> clears search results
nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
" Y yanks until end-of-line, like C and D
nnoremap Y y$

" emacs-keys:
cnoremap <C-A>      <Home>
cnoremap <C-B>      <Left>
cnoremap <C-D>      <Del>
cnoremap <C-E>      <End>
cnoremap <C-F>      <Right>
cnoremap <C-N>      <Down>
cnoremap <C-P>      <Up>
cnoremap <Esc><C-B> <S-Left>
cnoremap <Esc><C-F> <S-Right>

" Prompt for directory creation (if doesn't exist) on save
augroup VIMRC_AUTO_MKDIR
    autocmd!
    autocmd BufWritePre * call s:auto_mkdir(expand('<afile>:p:h'))
    function! s:auto_mkdir(dir)
        if !isdirectory(a:dir)
            if input("'" . a:dir . "' does not exist. Create? [y/N]") =~? '^y\%[es]$'
                call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
            endif
        endif
    endfunction
augroup END

"--- Digraphs ---

digraphs !!  0449 " ǁ
digraphs Sr  0691 " ʳ
digraphs Sx  0739 " ˣ
digraphs SH  7476 " ᴴ
digraphs SR  7487 " ᴿ
digraphs ST  7488 " ᵀ
digraphs Sd  7496 " ᵈ
digraphs Sk  7503 " ᵏ
digraphs Sp  7510 " ᵖ
digraphs St  7511 " ᵗ
digraphs si  7522 " ᵢ
digraphs sr  7523 " ᵣ
digraphs Si  8305 " ⁱ
digraphs Sn  8319 " ⁿ
digraphs sx  8339 " ₓ
digraphs sk  8342 " ₖ
digraphs sl  8343 " ₗ
digraphs sn  8345 " ₙ
digraphs sp  8346 " ₚ
digraphs st  8348 " ₜ
digraphs \|C 8450 " ℂ
digraphs \|H 8461 " ℍ
digraphs \|N 8469 " ℕ
digraphs \|P 8473 " ℙ
digraphs \|Q 8474 " ℚ
digraphs \|R 8477 " ℝ
digraphs \|Z 8484 " ℤ
digraphs /D  8517 " ⅅ
digraphs /d  8518 " ⅆ
digraphs /e  8519 " ⅇ
digraphs /i  8520 " ⅈ
digraphs /j  8521 " ⅉ
digraphs 17  8528 " ⅐
digraphs 19  8529 " ⅑
digraphs 10  8530 " ⅒
digraphs !3  8802 " ≢
digraphs [_  8849 " ⊑
digraphs ]_  8850 " ⊑
digraphs [U  8851 " ⊓
digraphs ]U  8852 " ⊔
digraphs +o  8853 " ⊕
digraphs -o  8854 " ⊖
digraphs xo  8855 " ⊗
digraphs \|- 8866 " ⊢
digraphs T+  8868 " ⊤
digraphs <.  8918 " ⋖
digraphs .>  8919 " ⋗
digraphs \|< 10216 " ⟨
digraphs \|> 10217 " ⟩
digraphs ~>  10547 " ⤳
digraphs Fg  120100 " 𝔤
digraphs \|A 120120 " 𝔸
digraphs \|B 120121 " 𝔹
digraphs \|D 120123 " 𝔻
digraphs \|E 120124 " 𝔼
digraphs \|F 120125 " 𝔽
digraphs \|G 120126 " 𝔾
digraphs \|I 120128 " 𝕀
digraphs \|J 120129 " 𝕁
digraphs \|K 120130 " 𝕂
digraphs \|L 120131 " 𝕃
digraphs \|M 120132 " 𝕄
digraphs \|O 120134 " 𝕆
digraphs \|S 120138 " 𝕊
digraphs \|W 120142 " 𝕎
digraphs \|X 120143 " 𝕏
digraphs \|a 120146 " 𝕒
digraphs \|b 120147 " 𝕓
digraphs \|c 120148 " 𝕔
digraphs \|d 120149 " 𝕕
digraphs \|e 120150 " 𝕖
digraphs \|f 120151 " 𝕗
digraphs \|g 120152 " 𝕘
digraphs \|h 120153 " 𝕙
digraphs \|i 120154 " 𝕚
digraphs \|j 120155 " 𝕛
digraphs \|k 120156 " 𝕜
digraphs \|l 120157 " 𝕝
digraphs \|m 120158 " 𝕞
digraphs \|n 120159 " 𝕟
digraphs \|o 120160 " 𝕠
digraphs \|p 120161 " 𝕡
digraphs \|q 120162 " 𝕢
digraphs \|r 120163 " 𝕣
digraphs \|s 120164 " 𝕤
digraphs \|t 120165 " 𝕥
digraphs \|u 120166 " 𝕦
digraphs \|v 120167 " 𝕧
digraphs \|w 120168 " 𝕨
digraphs \|x 120169 " 𝕩
digraphs \|y 120170 " 𝕪
digraphs \|z 120171 " 𝕫
digraphs \|0 120792 " 𝟘
digraphs \|1 120793 " 𝟙
digraphs \|2 120794 " 𝟚
digraphs \|3 120795 " 𝟛
digraphs \|4 120796 " 𝟜
digraphs \|5 120797 " 𝟝
digraphs \|6 120798 " 𝟞
digraphs \|7 120799 " 𝟟
digraphs \|8 120800 " 𝟠
digraphs \|9 120801 " 𝟡

"--- Plugin settings ---

" Netrw
let g:netrw_banner = 0
let g:netrw_liststyle = 3

" ALE
let g:ale_set_highlights = 0
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s'
let g:ale_linters = {
    \   'c': ['gcc'],
    \   'cpp': ['gcc'],
    \   'javascript': ['eslint'],
    \   'haskell': ['stack_build'],
    \   'lua': ['luac', 'luacheck']
    \ }
let g:ale_fixers = {
    \   'haskell': ['trim_whitespace'],
    \ }
let g:ale_sign_column_always = 1
let g:ale_lua_luac_executable = 'luac5.4'

" Lightline
set noshowmode
set showtabline=2
let g:lightline = {
    \   'colorscheme': 'neodark',
    \   'active': {
    \     'left': [['mode', 'paste'],
    \              ['readonly', 'filename', 'modified']],
    \     'right': [['lineinfo'],
    \               ['percent'],
    \               ['linter_errors', 'linter_warnings', 'linter_ok']],
    \   },
    \   'component_expand': {
    \     'linter_warnings': 'lightline#ale#warnings',
    \     'linter_errors': 'lightline#ale#errors',
    \     'linter_ok': 'lightline#ale#ok',
    \   },
    \   'component_type': {
    \     'linter_warnings': 'warning',
    \     'linter_errors': 'error',
    \     'linter_ok': 'green',
    \   },
    \   'tabline': {
    \     'left': [['tabs']],
    \     'right': [],
    \   },
    \ }

" Bufferline
let g:bufferline_echo = 1 " Automatically echo to the command bar

" Auto Pairs
let g:AutoPairs = { '"': '"', "'": "'", '(': ')', '[': ']', '{': '}', '`': '`' }
let g:AutoPairsShortcutToggle = ''
let g:AutoPairsShortcutFastWrap = ''
let g:AutoPairsShortcutJump = ''
let g:AutoPairsMoveCharacter = ''

" Vim Sexp
let g:sexp_filetypes = 'clojure,scheme,lisp'
let g:sexp_enable_insert_mode_mappings = 0
let g:sexp_mappings = {
            \ 'sexp_move_to_prev_element_head': '',
            \ 'sexp_move_to_next_element_head': '',
            \ 'sexp_move_to_prev_element_tail': '',
            \ 'sexp_move_to_next_element_tail': '',
            \ 'sexp_flow_to_prev_close':        '',
            \ 'sexp_flow_to_next_open':         '',
            \ 'sexp_flow_to_prev_open':         '',
            \ 'sexp_flow_to_next_close':        '',
            \ 'sexp_flow_to_prev_leaf_head':    '',
            \ 'sexp_flow_to_next_leaf_head':    '',
            \ 'sexp_flow_to_prev_leaf_tail':    '',
            \ 'sexp_flow_to_next_leaf_tail':    '',
            \ 'sexp_select_prev_element':       '',
            \ 'sexp_select_next_element':       '',
            \ 'sexp_round_head_wrap_list':      '',
            \ 'sexp_round_tail_wrap_list':      '',
            \ 'sexp_square_head_wrap_list':     '',
            \ 'sexp_square_tail_wrap_list':     '',
            \ 'sexp_curly_head_wrap_list':      '',
            \ 'sexp_curly_tail_wrap_list':      '',
            \ 'sexp_round_head_wrap_element':   '',
            \ 'sexp_round_tail_wrap_element':   '',
            \ 'sexp_square_head_wrap_element':  '',
            \ 'sexp_square_tail_wrap_element':  '',
            \ 'sexp_curly_head_wrap_element':   '',
            \ 'sexp_curly_tail_wrap_element':   '',
            \ 'sexp_insert_at_list_head':       '',
            \ 'sexp_insert_at_list_tail':       '',
            \ 'sexp_splice_list':               '',
            \ 'sexp_convolute':                 '',
            \ 'sexp_raise_list':                '',
            \ 'sexp_raise_element':             '',
            \ 'sexp_swap_list_backward':        '',
            \ 'sexp_swap_list_forward':         '',
            \ 'sexp_swap_element_backward':     '',
            \ 'sexp_swap_element_forward':      '',
            \ 'sexp_emit_head_element':         '',
            \ 'sexp_emit_tail_element':         '',
            \ 'sexp_capture_prev_element':      '',
            \ 'sexp_capture_next_element':      '',
            \ }

" Rainbow parentheses
let g:rainbow_active = 0
augroup RAINBOW_FILETYPES
    autocmd!
    autocmd FileType clojure,scheme,lisp RainbowToggleOn
augroup END

" Easy Align
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" Coqtail
let g:coqtail_noimap = 1
function! g:CoqtailHighlight()
    hi def CoqtailChecked guibg=#265538
    hi def CoqtailSent guibg=#26327A
    hi def CoqtailError guibg=#603238
    " hi def CoqtailChecked ctermbg=17 guibg=LightGreen
    " hi def CoqtailSent    ctermbg=60 guibg=LimeGreen
    hi def CoqtailChecked ctermbg=87af87 guibg=LightGreen
    " hi def CoqtailSent    ctermbg=178 guibg=DarkGreen
endfunction

" VimTex
let g:vimtex_view_general_viewer = 'okular'
let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'
let g:vimtex_complete_enabled = 0

