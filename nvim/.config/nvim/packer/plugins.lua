return require('packer').startup(function(use)

    -- Dark+ theme
    use 'tomasiser/vim-code-dark' -- Subject to change

    -- Airline
    use 'vim-airline/vim-airline' -- Subject to change
    use 'vim-airline/vim-airline-themes' -- Subject to change

    -- Telescope
    use 'nvim-lua/plenary.nvim'
    use 'nvim-telescope/telescope.nvim'

    -- Git integration
    use 'tpope/vim-fugitive'

    -- Sneak
    use 'justinmk/vim-sneak'

    -- Quickscope
    use 'unblevable/quick-scope'

    -- Ranger
    use 'kevinhwang91/rnvimr'

    -- Floaterm
    use 'voldikss/vim-floaterm'

    -- Indent line
    use 'lukas-reineke/indent-blankline.nvim'

    -- Colorizer
    use 'norcalli/nvim-colorizer.lua'

    -- LSP
    use 'neovim/nvim-lspconfig'
    use 'tami5/lspsaga.nvim' -- Subject to change
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-nvim-lua'
    use 'L3MON4D3/LuaSnip'
    use 'saadparwaiz1/cmp_luasnip'
    use 'onsails/lspkind-nvim'

    -- Markdown editing
    use({ "iamcco/markdown-preview.nvim", run = "cd app && npm install",
        setup = function() vim.g.mkdp_filetypes = { "markdown" } end,
        ft = { "markdown" }, })

    -- Copilot
    -- use 'github/copilot.vim'

    -- Comment
    use "terrortylor/nvim-comment"

    -- Treesitter
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

    -- Debugging
    use 'puremourning/vimspector'

    -- Devicons
    use 'kyazdani42/nvim-web-devicons'
    use 'ryanoasis/vim-devicons' -- Subject to change

end)
