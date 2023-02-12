return function()
    local g = vim.g
    local opts = {silent = true, noremap = true}

    g.floaterm_gitcommit = 'floaterm'
    g.floaterm_autoinsert = 1
    g.floaterm_width = 0.8
    g.floaterm_height = 0.8
    g.floaterm_wintitle = 0
    g.floaterm_autoclose = 1

    vim.api.nvim_set_keymap('n', '<F1>', ':FloatermToggle<cr>', opts)
    vim.api.nvim_set_keymap('t', '<F1>', '<C-\\><C-n>:FloatermToggle<cr>', opts)
    vim.api.nvim_set_keymap('n', '<F2>', ':FloatermNext<cr>', opts)
    vim.api.nvim_set_keymap('t', '<F2>', '<C-\\><C-n>:FloatermNext<cr>', opts)
    vim.api.nvim_set_keymap('n', '<F3>', ':FloatermPrev<cr>', opts)
    vim.api.nvim_set_keymap('t', '<F3>', '<C-\\><C-n>:FloatermPrev<cr>', opts)
    vim.api.nvim_set_keymap('n', '<F4>', ':FloatermNew<cr>', opts)
    vim.api.nvim_set_keymap('t', '<F4>', '<C-\\><C-n>:FloatermNew<cr>', opts)

    vim.api.nvim_set_keymap('n', '<Leader>tp', ':FloatermNew python<cr>', opts)
end
