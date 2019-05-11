" Vim mappings

" ---- Buffer Management ----
set hidden   " Lets you hide modified buffers
nnoremap <Leader>T  :enew<CR>
nnoremap <Leader>L  :bnext<CR>
nnoremap <Leader>K  :bprevious<CR>
nnoremap <C-TAB>    :bnext<CR>
nnoremap <C-S-TAB>  :bprevious<CR>
nnoremap <Leader>q :bp <BAR> bd #<CR>
nnoremap <Leader>d :bd<CR>

" ---- Window Management ----
" Use arrow keys to resize splits
nnoremap <Right> :vertical resize +1<CR>
nnoremap <Left> :vertical resize -1<CR>
nnoremap <Up> :resize +1<CR>
nnoremap <Down> :resize -1<CR>

" ---- Tab Management ----
nnoremap <Leader>t  :tabnew<CR>
nnoremap <Leader>l  :tabnext<CR>
nnoremap <Leader>k  :tabprevious<CR>
nnoremap <C-W>t <C-W>T

" ---- Misc ----
" <c-n> in command history uses current-typed as search
cnoremap <c-n> <down>
cnoremap <c-p> <up>
" why is this not default?
nnoremap Y y$

" '<' and '>' don't lose selection in visual mode
xnoremap < <gv
xnoremap > >gv

" n always searches forward, N backward
nnoremap <expr> n 'Nn'[v:searchforward]
nnoremap <expr> N 'nN'[v:searchforward]

" Map Ctrl+hjkl to move around
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>

" Allow use of , and ; for f and t
nnoremap ,, ,

" Insert one letter
nnoremap <Space> i_<ESC>r

" Pressing <leader><CR> clears search highlighting
nnoremap <leader><CR> :noh<CR>

" Copy-paste
inoremap <C-v> <ESC>"+pa
vnoremap <C-c> "+y
vnoremap <C-x> "+d

" Disable q: pulling up command-line window
" Every time I want to just :q ...
noremap q: <nop>

" F2 toggles fullscreen command-line window
nnoremap <F2> q:<C-w>_
augroup ECW_au
    au!
    au CmdwinEnter * nmap <F2> :q<CR>
    au CmdwinLeave * nmap <F2> q:<C-w>_
augroup END

" Change word under cursor with . repeat (*=forwards, #=backwards)
nnoremap c* *Ncgn
nnoremap c# #Ncgn

" Search visual selection
vnoremap <silent> * :call VisualSelection('f', '')<CR>
vnoremap <silent> # :call VisualSelection('b', '')<CR>
function! VisualSelection(direction, extra_filter) range
  let l:saved_reg = @"
  execute "normal! vgvy"

  let l:pattern = escape(@", '\\/.*$^~[]')
  let l:pattern = substitute(l:pattern, "\n$", "", "")

  if a:direction == 'b'
    execute "normal ?" . l:pattern . "^M"
  elseif a:direction == 'gv'
    call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.' . a:extra_filter)
  elseif a:direction == 'replace'
    call CmdLine("%s" . '/'. l:pattern . '/')
  elseif a:direction == 'f'
    execute "normal /" . l:pattern . "^M"
  endif

  let @/ = l:pattern
  let @" = l:saved_reg
endfunction

" Calling macro over visual selection does matching lines
" and skips non-matches
xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>
function! ExecuteMacroOverVisualRange()
    echo "@".getcmdline()
    execute ":'<,'>normal @".nr2char(getchar())
endfunction

" Quick redraw (Helpful for Pick)
noremap <leader>r :redraw!<CR>

" Toggle git-gutter
noremap <leader>gg :GitGutterToggle<CR>

