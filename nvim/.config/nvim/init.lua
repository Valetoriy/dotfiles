require('settings')
require('mappings')

local plugins = require('lazyconf')
require('lazy').setup(plugins)

vim.cmd('colorscheme darkplus')
vim.cmd[[
    augroup set-commentstring-ag
    autocmd!
    autocmd BufEnter *.cpp,*.hpp,*.h,*.c,*.glsl :lua vim.api.nvim_buf_set_option(0, 'commentstring', '// %s')
    autocmd BufFilePost *.cpp,*.hpp,*.h,*.c,*.glsl :lua vim.api.nvim_buf_set_option(0, 'commentstring', '// %s')
    augroup END
]]
vim.cmd[[highlight IndentBlanklineIndent1 guifg=#323232 gui=nocombine]]
