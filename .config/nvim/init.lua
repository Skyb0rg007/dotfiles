
-- TODO: Manage plugins with binaries through Nix

-- Packages
vim.pack.add {
    -- Integration
    "https://github.com/coder/claudecode.nvim",
    "https://github.com/dense-analysis/ale",
    "https://github.com/kylechui/nvim-surround",
    "https://github.com/tpope/vim-fugitive",
    "https://github.com/windwp/nvim-autopairs",
    -- Tools
    "https://github.com/dstein64/vim-startuptime",
    "https://github.com/lumen-oss/lz.n",
    "https://github.com/nvim-telescope/telescope.nvim",
    -- "https://github.com/wakatime/vim-wakatime",
    "https://github.com/direnv/direnv.vim",
    -- Language support
    "https://github.com/jez/vim-better-sml",
    "https://github.com/Julian/lean.nvim",
    "https://github.com/nxuv/just.nvim",
    "https://github.com/pest-parser/pest.vim",
    "https://github.com/niklasl/vim-rdf",
    -- "https://github.com/whonore/coqtail",
    -- Dependencies
    "https://github.com/nvim-tree/nvim-web-devicons",
    "https://github.com/nvim-lua/plenary.nvim",
    "https://github.com/folke/snacks.nvim",
    "https://github.com/j-hui/fidget.nvim",
}

vim.cmd('colorscheme onehalfdark')

--- Builtin
-- vim.cmd('packadd! nvim.tohtml')   -- :TOhtml
vim.cmd('packadd! nvim.undotree') -- :Undotree
-- vim.cmd('packadd! nvim.difftool') -- :DiffTool

--- Package Helpers
vim.cmd('packadd! fidget.nvim')

--- Plugins
vim.cmd('packadd! telescope-fzf-native.nvim')
vim.cmd('packadd! nvim-treesitter')
vim.cmd('packadd! nvim-treesitter-textobjects') -- deps: nvim-treesitter
vim.cmd('packadd! nvim-treesitter-endwise')

-- Syntax highlighting
require('ale').setup({
    completion_enabled = true,
    warn_about_trailing_whitespace = true,
    sign_column_always = true,
})

-- File fuzzy-search
require('telescope').setup({
    defaults = {
        mappings = {
        },
    },
    pickers = {
    },
    extensions = {
    },
})
-- TODO: move to the mappings section of setup call
local ts_builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-p>', ts_builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>ff', ts_builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', ts_builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', ts_builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', ts_builtin.help_tags, { desc = 'Telescope help tags' })

-- Parenthesis completion
require('nvim-autopairs').setup({})

-- Surround
require('nvim-surround').setup({})

-- devicons
require('nvim-web-devicons').setup({
    override_by_extension = {
        ['tofu'] = {
            name = 'OpenTofu',
            icon = '',
            color = '#4732AF',
            cterm_color = '55',
        },
    },
})

-- Claudecode
require('claudecode').setup({
    auto_start = false,
    focus_after_send = true,
})

-- vim.keymap.set('n', '<leader>a', nil, { desc = 'AI/Claude Code' })
vim.keymap.set('n', '<leader>ac', '<cmd>ClaudeCode<cr>', { desc = 'Toggle Claude' })
vim.keymap.set('n', '<leader>af', '<cmd>ClaudeCodeFocus<cr>', { desc = 'Focus Claude' })
vim.keymap.set('n', '<leader>ar', '<cmd>ClaudeCode --resume<cr>', { desc = 'Resume Claude' })
vim.keymap.set('n', '<leader>aC', '<cmd>ClaudeCode --continue<cr>', { desc = 'Continue Claude' })
vim.keymap.set('n', '<leader>am', '<cmd>ClaudeCodeSelectModel<cr>', { desc = 'Select Claude model' })
    -- Context sending
vim.keymap.set('n', '<leader>as', '<cmd>ClaudeCodeAdd %<cr>', { desc = 'Add current buffer' })
vim.keymap.set('v', '<leader>as', '<cmd>ClaudeCodeSend<cr>', { desc = 'Send to Claude' })
-- vim.keymap.set('n', '<leader>as', '<cmd>ClaudeCodeTreeAdd<cr>', {
--     desc = 'Add file from tree',
    -- ft = { 'NvimTree', 'neo-tree', 'oil', 'minifiles', 'netrw' },
-- })
-- Development helpers
vim.keymap.set('n', '<leader>ao', '<cmd>ClaudeCodeOpen<cr>', { desc = 'Open Claude' })
vim.keymap.set('n', '<leader>aq', '<cmd>ClaudeCodeClose<cr>', { desc = 'Close Claude' })
vim.keymap.set('n', '<leader>ai', '<cmd>ClaudeCodeStatus<cr>', { desc = 'Claude Status' })
vim.keymap.set('n', '<leader>aS', '<cmd>ClaudeCodeStart<cr>', { desc = 'Start Claude Server' })
vim.keymap.set('n', '<leader>aQ', '<cmd>ClaudeCodeStop<cr>', { desc = 'Stop Claude Server' })
-- Diff management (buffer-local, only active in diff buffers)
vim.keymap.set('n', '<leader>aa', '<cmd>ClaudeCodeDiffAccept<cr>', { desc = 'Accept diff' })
vim.keymap.set('n', '<leader>ad', '<cmd>ClaudeCodeDiffDeny<cr>', { desc = 'Deny diff' })

-- Call in ftplugin/
-- require('nvim-surround').buffer_setup({})

-- Unimpaired
vim.keymap.set('n', ']e',
    function()
        local count = vim.v.count1
        vim.cmd('silent! move +' .. count)
    end)

vim.keymap.set('n', '[e',
    function()
        local count = vim.v.count1
        vim.cmd('silent! move --' .. count)
    end)

-- Standard ML
vim.keymap.set('n', '<leader>ss', ':SMLReplStart<CR>', { desc = 'SML start REPL' })
vim.keymap.set('n', '<leader>sb', ':SMLReplBuild<CR>', { desc = 'SML build project' })
vim.keymap.set('n', '<leader>sq', ':SMLReplStop<CR>', { desc = 'SML stop REPL' })
vim.keymap.set('n', '<leader>sc', ':SMLReplClear<CR>', { desc = 'SML clear REPL' })
vim.keymap.set('n', '<leader>st', ':SMLTypeQuery<CR>', { desc = 'SML query type' })

-- Lean
-- require('lean').setup({
--     mappings = true,
-- })

local xdg_state = os.getenv('XDG_STATE_HOME') or '~/.local/state'

-- WakaTime
-- require('wakatime').setup({
--     debug = false,
--     heartbeat_frequency = 5,
--     plugin_name = 'vim-wakatime',
--     cli_path = xdg_state .. '/nix/profile/bin/wakatime-cli',
-- })

-- Options
vim.o.number = true
vim.o.signcolumn = 'number' -- use number column for errors
vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.colorcolumn = '80'
vim.o.cursorline = true
vim.o.spelllang = 'en' -- TODO: en_US support, PL concepts
vim.o.exrc = true

-- Disable "How to disable mouse" item in right-click menu
vim.cmd('silent! aunmenu PopUp.How-to\\ disable\\ mouse')
vim.cmd('silent! aunmenu PopUp.-2-')

-- Additional filetype extensions
vim.filetype.add({
    extension = {
        ign = 'json',
        bu = 'yaml',
        bst = 'yaml',
        tofu = 'terraform',
    },
    pattern = {
        ['${XDG_CONFIG_HOME}/environment.d/.*%.conf'] = 'env',
    },
    filename = {
        ['mkosi.conf'] = 'systemd',
        ['mkosi.nspawn'] = 'systemd',
    },
})

