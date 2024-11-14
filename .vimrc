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
Plug 'tpope/vim-obsession'       " Session management
Plug 'ctrlpvim/ctrlp.vim'        " Fuzzy search
Plug 'mcchrish/nnn.vim'          " nnn file manager
" Plug 'kana/vim-arpeggio'         " chording
Plug 'github/copilot.vim'        " Copilot support
" Plug 'sirver/ultisnips'
Plug 'catppuccin/vim', {'as': 'catppuccin'} " Colorscheme
Plug 'sonph/onehalf', { 'rtp': 'vim' }
" Plug 'christoomey/vim-tmux-navigator'
Plug 'wakatime/vim-wakatime'

" Direnv
Plug 'direnv/direnv.vim'

" Todo.txt
Plug 'freitass/todo.txt-vim'

" klog
Plug '73/vim-klog'

" Recfiles
Plug 'zaid/vim-rec'

" Ansible
Plug 'pearofducks/ansible-vim'

" Beancount
Plug 'nathangrigg/vim-beancount'

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

" Uiua
Plug 'sputnick1124/uiua.vim', { 'for': 'uiua' }

" Koka
Plug 'Nymphium/vim-koka'

" LaTex
Plug 'lervag/vimtex', { 'for': 'tex' }

" LLVM
Plug 'rhysd/vim-llvm'

" Dhall
Plug 'vmchale/dhall-vim', { 'for': 'dhall' }

" Elm
Plug 'elm-tooling/elm-vim', { 'for': 'elm' }

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

" KMonad
Plug 'kmonad/kmonad-vim'

" Justfile
Plug 'NoahTheDuke/vim-just'

call plug#end()

" Distributed packages
packadd! editorconfig

let g:skip_loading_mswin = 1

" Syntax highlighting
syntax enable
filetype on
filetype indent on
filetype plugin on
set termguicolors
set background=dark

colorscheme onehalfdark
let g:terminal_ansi_colors = [
    \ "#282c34", "#e06c75", "#98c379", "#e5c07b",
    \ "#61afef", "#c678dd", "#56b6c2", "#dcdfe4",
    \ "#282c34", "#e06c75", "#98c379", "#e5c07b",
    \ "#61afef", "#c678dd", "#56b6c2", "#dcdfe4",
    \ ]
" colorscheme catppuccin_mocha
" colorscheme neodark
" let g:neodark#background = '#202020'

" General settings
set autoindent " Copy indent from current line when starting a new line
set autoread " Re-read a file when a change occurs
set backspace=indent,eol,start " Allow backspacing over everything
set complete=".,w,b,u,t" " Completes by looking at (loaded & unloaded) buffers, windows, tags
set display+=lastline " Show the last line as much as possible
set encoding=utf-8 " Force UTF-8
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
if !empty($WORDLIST) && filereadable($WORDLIST)
    set dictionary+=$WORDLIST
else
    set dictionary+=/usr/share/dict/words
endif
set spelllang=en_us
set number

" Folds
set foldmethod=indent
set foldnestmax=5
set foldlevelstart=99
set foldcolumn=0

" Cursor is a line in insert mode and a block in normal mode
let &t_SI = "\e[5 q"
let &t_EI = "\e[2 q"
if exists('$TMUX')
    " let &t_SI = "\e]50;CursorShape=1\x7"
    " let &t_EI = "\e]50;CursorShape=0\x7"
    let &t_SI = "\ePtmux;\e" . &t_SI . "\e\\"
    let &t_EI = "\ePtmux;\e" . &t_EI . "\e\\"
endif

" Show the cursor line in normal mode
set cursorline
autocmd InsertLeave,BufEnter * set cursorline
autocmd InsertEnter,BufLeave * set nocursorline

" For mouse handling on WSL
set ttymouse=sgr

" Use Vim's manpage plugin
runtime ftplugin/man.vim
set keywordprg=:Man

let g:awk_is_gawk = 1

"--- Mappings ---

" <C-L> clears search results TODO: Remap this
nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
" Y yanks until end-of-line, like C and D
nnoremap Y y$

" emacs-keys:
cnoremap <C-A> <Home>
cnoremap <C-B> <Left>
cnoremap <C-D> <Del>
cnoremap <C-E> <End>
cnoremap <C-F> <Right>
cnoremap <C-N> <Down>
cnoremap <C-P> <Up>
" cnoremap <Esc><C-B> <S-Left>
" cnoremap <Esc><C-F> <S-Right>

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

" Miscellaneous
call digraph_set('!!', "\u01c1") " ǁ
call digraph_set('/D', "\u2145") " ⅅ
call digraph_set('/d', "\u2146") " ⅆ
call digraph_set('/e', "\u2147") " ⅇ
call digraph_set('/i', "\u2148") " ⅈ
call digraph_set('/j', "\u2149") " ⅉ
call digraph_set('=.', "\u2250") " ≐

" Misc Mathematical
call digraph_set('!3', "\u2262") " ≢
call digraph_set('[_', "\u2191") " ⊑
call digraph_set(']_', "\u2291") " ⊑
call digraph_set('[U', "\u2293") " ⊓
call digraph_set(']U', "\u2294") " ⊔
call digraph_set('+o', "\u2295") " ⊕
call digraph_set('-o', "\u2296") " ⊖
call digraph_set('xo', "\u2297") " ⊗
call digraph_set('|-', "\u22a2") " ⊢
call digraph_set('T+', "\u22a4") " ⊤
call digraph_set('<.', "\u22d6") " ⋖
call digraph_set('.>', "\u22d7") " ⋗
call digraph_set('|<', "\u27e8") " ⟨
call digraph_set('|>', "\u27e9") " ⟩
call digraph_set('~>', "\u2933") " ⤳
call digraph_set('|=', "\u22a8") " ⊨
call digraph_set('(/', "\u2209") " ∉

" Latin Superscript Small Letters (TODO: Finish the set)
" ᵈ ⁱ ᵏ ⁿ ᵖ ʳ ᵗ ˣ
call digraph_setlist(
            \ [['Sd', "\u1d48"],
            \  ['Si', "\u2071"],
            \  ['Sk', "\u1d4f"],
            \  ['Sn', "\u207f"],
            \  ['Sp', "\u1d56"],
            \  ['Sr', "\u02b3"],
            \  ['St', "\u1d57"],
            \  ['Sx', "\u02e3"]])

" Latin Superscript Capital Letters (TODO: Finish the set)
" ᴴ ᴿ ᵀ
call digraph_setlist(
            \ [['SH', "\u1d34"],
            \  ['SR', "\u1d3f"],
            \  ['ST', "\u1d40"]])

" Latin Subscript Small Letters (TODO: Finish the set)
" ₐ ₑ ₕ ᵢ ⱼ ₖ ₗ ₙ ₒ ₚ ₜ ₓ
call digraph_setlist(
            \ [['sa', "\u2090"],
            \  ['se', "\u2091"],
            \  ['sh', "\u2095"],
            \  ['si', "\u1d62"], ['sj', "\u2c7c"],
            \  ['sk', "\u2096"], ['sl', "\u2097"],
            \  ['sn', "\u2099"],
            \  ['so', "\u2092"], ['sp', "\u209a"],
            \  ['st', "\u209c"],
            \  ['sx', "\u2093"],
            \ ])

" Fractions
" ⅐ ⅑ ⅒
call digraph_setlist([['17', "\u2150"], ['19', "\u2151"], ['10', "\u2152"]])

""" Mathematical Alphanumeric Symbols

" Fraktur
" 𝔄 𝔅 ℭ 𝔇 𝔈 𝔉 𝔊 ℌ ℑ 𝔍 𝔎 𝔏 𝔐 𝔑 𝔒 𝔓 𝔔 ℜ 𝔖 𝔗 𝔘 𝔙 𝔚 𝔛 𝔜 ℨ
" 𝔞 𝔟 𝔠 𝔡 𝔢 𝔣 𝔤 𝔥 𝔦 𝔧 𝔨 𝔩 𝔪 𝔫 𝔬 𝔭 𝔮 𝔯 𝔰 𝔱 𝔲 𝔳 𝔴 𝔵 𝔶 𝔷
" Use 'AF' to avoid clobbering 'FA'(∀)
call digraph_setlist(
            \ [['AF', "\U0001d504"], ['FB', "\U0001d505"],
            \  ['FC', "\u212d"],     ['FD', "\U0001d507"],
            \  ['FE', "\U0001d508"], ['FF', "\U0001d509"],
            \  ['FG', "\U0001d50a"], ['FH', "\u210c"],
            \  ['FI', "\u2111"],     ['FJ', "\U0001d50d"],
            \  ['FK', "\U0001d50e"], ['FL', "\U0001d50f"],
            \  ['FM', "\U0001d510"], ['FN', "\U0001d511"],
            \  ['FO', "\U0001d512"], ['FP', "\U0001d513"],
            \  ['FQ', "\U0001d514"], ['FR', "\u211c"],
            \  ['FS', "\U0001d516"], ['FT', "\U0001d517"],
            \  ['FU', "\U0001d518"], ['FV', "\U0001d519"],
            \  ['FW', "\U0001d51a"], ['FX', "\U0001d51b"],
            \  ['FY', "\U0001d51c"], ['FZ', "\u2128"],
            \  ['Fa', "\U0001d51e"], ['Fb', "\U0001d51f"],
            \  ['Fc', "\U0001d520"], ['Fd', "\U0001d521"],
            \  ['Fe', "\U0001d522"], ['Ff', "\U0001d523"],
            \  ['Fg', "\U0001d524"], ['Fh', "\U0001d525"],
            \  ['Fi', "\U0001d526"], ['Fj', "\U0001d527"],
            \  ['Fk', "\U0001d528"], ['Fl', "\U0001d529"],
            \  ['Fm', "\U0001d52a"], ['Fn', "\U0001d52b"],
            \  ['Fo', "\U0001d52c"], ['Fp', "\U0001d52d"],
            \  ['Fq', "\U0001d52e"], ['Fr', "\U0001d52f"],
            \  ['Fs', "\U0001d530"], ['Ft', "\U0001d531"],
            \  ['Fu', "\U0001d532"], ['Fv', "\U0001d533"],
            \  ['Fw', "\U0001d534"], ['Fx', "\U0001d535"],
            \  ['Fy', "\U0001d536"], ['Fz', "\U0001d537"],
            \  ])

" Double-Struck
" 𝔸 𝔹 ℂ 𝔻 𝔼 𝔽 𝔾 ℍ 𝕀 𝕁 𝕂 𝕃 𝕄 ℕ 𝕆 ℙ ℚ ℝ 𝕊 𝕋 𝕌 𝕍 𝕎 𝕏 𝕐 ℤ
" 𝕒 𝕓 𝕔 𝕕 𝕖 𝕗 𝕘 𝕙 𝕚 𝕛 𝕜 𝕝 𝕞 𝕟 𝕠 𝕡 𝕢 𝕣 𝕤 𝕥 𝕦 𝕧 𝕨 𝕩 𝕪 𝕫
" 𝟘 𝟙 𝟚 𝟛 𝟜 𝟝 𝟞 𝟟 𝟠 𝟡
" ⨟
call digraph_setlist(
            \ [['|A', "\U0001d538"], ['|B', "\U0001d539"],
            \  ['|C', "\u2102"],     ['|D', "\U0001d53b"],
            \  ['|E', "\U0001d53c"], ['|F', "\U0001d53d"],
            \  ['|G', "\U0001d53e"], ['|H', "\u210d"],
            \  ['|I', "\U0001d540"], ['|J', "\U0001d541"],
            \  ['|K', "\U0001d542"], ['|L', "\U0001d543"],
            \  ['|M', "\U0001d544"], ['|N', "\u2115"],
            \  ['|O', "\U0001d546"], ['|P', "\u2119"],
            \  ['|Q', "\u211a"],     ['|R', "\u211d"],
            \  ['|S', "\U0001d54a"], ['|T', "\U0001d54b"],
            \  ['|U', "\U0001d54c"], ['|V', "\U0001d54d"],
            \  ['|W', "\U0001d54e"], ['|X', "\U0001d54f"],
            \  ['|Y', "\U0001d550"], ['|Z', "\u2124"],
            \  ['|a', "\U0001d552"], ['|b', "\U0001d553"],
            \  ['|c', "\U0001d554"], ['|d', "\U0001d555"],
            \  ['|e', "\U0001d556"], ['|f', "\U0001d557"],
            \  ['|g', "\U0001d558"], ['|h', "\U0001d559"],
            \  ['|i', "\U0001d55a"], ['|j', "\U0001d55b"],
            \  ['|k', "\U0001d55c"], ['|l', "\U0001d55d"],
            \  ['|m', "\U0001d55e"], ['|n', "\U0001d55f"],
            \  ['|o', "\U0001d560"], ['|p', "\U0001d561"],
            \  ['|q', "\U0001d562"], ['|r', "\U0001d563"],
            \  ['|s', "\U0001d564"], ['|t', "\U0001d565"],
            \  ['|u', "\U0001d566"], ['|v', "\U0001d567"],
            \  ['|w', "\U0001d568"], ['|x', "\U0001d569"],
            \  ['|y', "\U0001d56a"], ['|z', "\U0001d56b"],
            \  ['|0', "\U0001d7d8"], ['|1', "\U0001d7d9"],
            \  ['|2', "\U0001d7da"], ['|3', "\U0001d7db"],
            \  ['|4', "\U0001d7dc"], ['|5', "\U0001d7dd"],
            \  ['|6', "\U0001d7de"], ['|7', "\U0001d7df"],
            \  ['|8', "\U0001d7e0"], ['|9', "\U0001d7e1"],
            \  ['|;', "\u2a1f"],
            \ ])

"--- Plugin settings ---

let g:copilot_enabled = v:false

" Use the <C-W> + motion bindings instead of the ctrl+motion defaults
" let g:tmux_navigator_no_mappings = 1
let g:tmux_navigator_save_on_switch = 1 " Write current buffer
let g:tmux_navigator_no_wrap = 1

" nnoremap <silent> <c-w>h :<C-U>TmuxNavigateLeft<cr>
" nnoremap <silent> <c-w>j :<C-U>TmuxNavigateDown<cr>
" nnoremap <silent> <c-w>k :<C-U>TmuxNavigateUp<cr>
" nnoremap <silent> <c-w>l :<C-U>TmuxNavigateRight<cr>

" let g:UltiSnipsJumpOrExpandTrigger = "<tab>"
" let g:UltiSnipsListSnippets = "<c-q>"
" let g:UltiSnipsJumpForwardTrigger = "<c-j>"
" let g:UltiSnipsJumpBackwardTrigger = "<c-k>"
" let g:UltiSnipsEditSplit = "vertical"

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
    \   'lua': ['luac', 'luacheck'],
    \   'tex': ['chktex', 'proselint', 'cspell']
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
    \   'colorscheme': 'onehalfdark',
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

