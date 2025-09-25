if exists("did_load_filetypes")
    finish
endif
augroup filetypedetect
    autocmd! BufRead,BufNewFile *.sml,*.sig,*.fun setfiletype sml
    autocmd! BufRead,BufNewFile *.scm,*.sld       setfiletype scheme
    autocmd! BufRead,BufNewFile *.bqn             setfiletype bqn
    autocmd! BufRead,BufNewFile *.agda            setfiletype agda
    autocmd! BufRead,BufNewFile *.elf             setfiletype twelf
augroup END
