local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable',
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

return {
    'lunarvim/darkplus.nvim',
    {
        'kevinhwang91/rnvimr',
        config = function()
            local g = vim.g

            g.rnvimr_enable_ex = 1
            g.rnvimr_enable_bw = 1

            vim.keymap.set('n', '<Leader>r', ':RnvimrToggle<cr>')
        end,
    },
    {
        'nvim-telescope/telescope.nvim',
        tag = 'v0.2.0',
        config = function()
            local keymap = vim.keymap.set

            keymap('n', '<Leader>ff', ':lua require("telescope.builtin").find_files()<cr>')
            keymap('n', '<Leader>fg', ':lua require("telescope.builtin").live_grep()<cr>')
            keymap('n', '<Leader>fb', ':lua require("telescope.builtin").buffers()<cr>')
            keymap('n', '<Leader>fh', ':lua require("telescope.builtin").help_tags()<cr>')
        end,
        dependencies = 'nvim-lua/plenary.nvim',
    },
    {
        'nvim-treesitter/nvim-treesitter',
        lazy = false,
    },
    {
        "mason-org/mason.nvim",
        opts = {}
    },
    {
        "mason-org/mason-lspconfig.nvim",
        opts = {},
        dependencies = {
            { "mason-org/mason.nvim", opts = {} },
            "neovim/nvim-lspconfig",
        },
    },
    "nvimtools/none-ls.nvim",
    'tpope/vim-fugitive',
    {
        "hrsh7th/nvim-cmp",
        config = require('plugins.nvim-cmp'),
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp_luasnip",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "saadparwaiz1/cmp_luasnip"
        },
    },
    {
        'akinsho/toggleterm.nvim',
        config = require('plugins.toggleterm'),
    },
    {
        'terrortylor/nvim-comment',
        config = function()
            require('nvim_comment').setup {
                line_mapping = '<Leader>v', operator_mapping = '<Leader>c' }
        end,
    },
    { 'lukas-reineke/indent-blankline.nvim', main = 'ibl', opts = {} },
    {
        'norcalli/nvim-colorizer.lua',
        config = function()
            require('colorizer').setup()
        end
    },
    {
        'nvim-tree/nvim-web-devicons',
        config = function()
            require('nvim-web-devicons').setup {
                default = true,
                strict = true,
            }
        end,
    },
    'ryanoasis/vim-devicons',
    {
        'windwp/nvim-autopairs',
        config = function()
            require('nvim-autopairs').setup() -- ???
        end,
    },
    {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup() -- ???
        end,
    },
    {
        'goolord/alpha-nvim',
        config = function()
            require('alpha').setup(require('alpha.themes.startify').config)
        end,
        dependencies = 'nvim-tree/nvim-web-devicons',
    },
    {
        'nvim-lualine/lualine.nvim',
        config = require('plugins.lualine'),
        dependencies = 'nvim-tree/nvim-web-devicons'
    },
    {
        'ggandor/leap.nvim',
        config = function()
            require('leap')
            vim.keymap.set({ 'n', 'x', 'o' }, 's', '<Plug>(leap)')
            vim.keymap.set('n', 'S', '<Plug>(leap-from-window)')
        end,
        dependencies = 'tpope/vim-repeat',
    },
    {
        'ThePrimeagen/harpoon',
        config = require('plugins.harpoon'),
        branch = 'harpoon2',
        dependencies = 'nvim-lua/plenary.nvim',
    },
    {
        'iamcco/markdown-preview.nvim',
        config = function()
            vim.g.mkdp_filetypes = { 'markdown' }
        end,
        build = 'cd app && npm install',
        ft = 'markdown'
    }
}
