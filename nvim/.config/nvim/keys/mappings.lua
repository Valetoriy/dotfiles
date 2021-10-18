local map = vim.api.nvim_set_keymap

-- Use alt + hjkl to resize windows
map('n', '<M-j>', ':resize -2<cr>', { noremap = true })
map('n', '<M-k>', ':resize +2<cr>', { noremap = true })
map('n', '<M-h>', ':vertical resize +2<cr>', { noremap = true })
map('n', '<M-l>', ':vertical resize -2<cr>', { noremap = true })

-- Easy CAPS
map('n', '<Leader>u', 'viwU<Esc>', { noremap = true })

-- TAB in general mode will move to text buffer
map('n', '<TAB>n', ':bn<CR>', { noremap = true })
map('n', '<TAB>p', ':bp<CR>', { noremap = true })
map('n', '<TAB>q', ':bd!<CR>', { noremap = true })

-- Alternate way to save
map('n', '<C-s>', ':w<CR>', { noremap = true })
-- Use control-c instead of escape
map('n', '<C-c>', '<Esc>', { noremap = true })

-- Better tabbing
map('v', '<', '<gv', { noremap = true })
map('v', '>', '>gv', { noremap = true })

-- Better window navigation
map('n', '<C-h>', '<C-w>h', { noremap = true })
map('n', '<C-j>', '<C-w>j', { noremap = true })
map('n', '<C-k>', '<C-w>k', { noremap = true })
map('n', '<C-l>', '<C-w>l', { noremap = true })
