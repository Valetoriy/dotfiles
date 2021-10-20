local Plug = vim.fn['plug#']

--call plug#begin("$HOME/.config/nvimplugged")
vim.call('plug#begin', '~/.config/nvimplugged')

-- Dark+ theme
Plug 'tomasiser/vim-code-dark'

-- Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

-- Telescope
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

-- Sneak
Plug 'justinmk/vim-sneak'

-- Quickscope
Plug 'unblevable/quick-scope'

-- Ranger
Plug 'kevinhwang91/rnvimr'

-- Floaterm
Plug 'voldikss/vim-floaterm'

-- Indent line
Plug 'lukas-reineke/indent-blankline.nvim'

-- Colorizer
Plug 'norcalli/nvim-colorizer.lua'

-- Devicons
Plug 'kyazdani42/nvim-web-devicons'

--call plug#end()
vim.call('plug#end')
