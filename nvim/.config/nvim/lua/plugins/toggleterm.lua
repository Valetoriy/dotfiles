return function()
    local opts = {silent = true, noremap = true}
    -- vim.api.nvim_set_keymap('t', '<esc>', '<C-\\><C-n>', opts)
    vim.api.nvim_set_keymap('t', '<F2>', '<C-\\><C-n>:TermSelect<cr>', opts)
    vim.api.nvim_set_keymap('t', '<F3>', '<C-\\><C-n>:TermSelect<cr>', opts)
    vim.api.nvim_set_keymap('t', '<F4>', '<C-\\><C-n>:TermNew<cr>', opts)
    require("toggleterm").setup {
        open_mapping = '<F1>',
        hide_numbers = true,
        autochdir = false,
        shade_terminals = true,
        start_in_insert = true,
        insert_mappings = true,
        terminal_mappings = true,
        persist_size = true,
        persist_mode = true,
        direction = 'float',
        close_on_exit = true,
        clear_env = false,
        shell = vim.o.shell,
        auto_scroll = true,
        float_opts = {
            border = 'single',
            title_pos = 'left'
        },
        winbar = {
            enabled = true,
            name_formatter = function(term)
                return term.name
            end
        },
        responsiveness = {
            horizontal_breakpoint = 135,
        }
    }
end
