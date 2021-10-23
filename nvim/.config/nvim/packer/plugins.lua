return require('packer').startup(function(use)

    -- Dark+ theme
    use 'tomasiser/vim-code-dark' -- Subject to change

    -- Airline
    use 'vim-airline/vim-airline' -- Subject to change
    use 'vim-airline/vim-airline-themes' -- Subject to change

    -- Telescope
    use 'nvim-lua/plenary.nvim'
    use 'nvim-telescope/telescope.nvim'

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
    use { 'tami5/lspsaga.nvim', branch = 'nvim51' } -- Subject to change
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-nvim-lua'
    use 'onsails/lspkind-nvim'

    -- Treesitter
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

    -- Devicons
    use 'kyazdani42/nvim-web-devicons'
    use 'ryanoasis/vim-devicons' -- Subject to change

end)
