
vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'javascript' },
    callback = function()
        vim.treesitter.start()
    end,
})
