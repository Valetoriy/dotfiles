vim.g.mapleader = ' '

local v = vim.opt

v.termguicolors = true
v.signcolumn = 'yes'
v.hlsearch = false
v.incsearch = true
v.errorbells = false
v.hidden = true
v.wrap = true
v.encoding = 'utf-8'
v.pumheight = 10
v.fileencoding = 'utf-8'
v.swapfile = false
v.backup = false
v.ruler = true
v.iskeyword:append({ '-' })
v.mouse = 'a'
v.splitbelow = true
v.splitright = true
v.conceallevel = 0
v.tabstop = 4
v.softtabstop = 4
v.scrolloff = 8
v.shiftwidth = 4
v.smarttab = true
v.expandtab = true
v.smartindent = true
v.autoindent = true
v.laststatus = 0
v.number = true
v.relativenumber = true
v.cursorline = true
v.updatetime = 50
v.timeoutlen = 500
v.formatoptions:remove({ 'c', 'r', 'o' })
v.clipboard = 'unnamedplus'
v.shortmess:append({ c = true })
