local keymap = vim.keymap.set

keymap('v', 'J', ":m '>+1<CR>gv=gv")
keymap('v', 'K', ":m '<-2<CR>gv=gv")

keymap('n', 'J', 'mzJ`z')
keymap('n', '<C-d>', '<C-d>zz')
keymap('n', '<C-u>', '<C-u>zz')
keymap('n', 'n', 'nzzzv')
keymap('n', 'N', 'Nzzzv')

keymap('x', '<Leader>p', '"_dP')

keymap('n', '<TAB>q', ':bd!<CR>')

keymap('n', '<M-j>', ':resize -2<cr>')
keymap('n', '<M-k>', ':resize +2<cr>')
keymap('n', '<M-h>', ':vertical resize +2<cr>')
keymap('n', '<M-l>', ':vertical resize -2<cr>')

keymap('n', '<Leader>u', 'viwU<Esc>')

keymap('n', '<C-s>', ':w<CR>')
keymap('n', '<C-c>', '<Esc>')

keymap('v', '<', '<gv')
keymap('v', '>', '>gv')

keymap('n', '<C-h>', '<C-w>h')
keymap('n', '<C-j>', '<C-w>j')
keymap('n', '<C-k>', '<C-w>k')
keymap('n', '<C-l>', '<C-w>l')
