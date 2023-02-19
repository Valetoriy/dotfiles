return function()
    local keymap = vim.keymap.set

    keymap('n', '\\gh', '<cmd>Lspsaga lsp_finder<CR>')

    keymap('n', '\\ca', '<cmd>Lspsaga code_action<CR>')

    keymap('n', '\\rn', '<cmd>Lspsaga rename<CR>')
    keymap('n', '\\rN', '<cmd>Lspsaga rename ++project<CR>')

    keymap('n', '\\gd', '<cmd>Lspsaga goto_definition<CR>')

    keymap('n', '[d', '<cmd>Lspsaga diagnostic_jump_next<CR>')
    keymap('n', ']d', '<cmd>Lspsaga diagnostic_jump_prev<CR>')

    keymap('n', '[D', function()
        require('lspsaga.diagnostic'):goto_next({ severity = vim.diagnostic.severity.ERROR })
    end)
    keymap('n', ']D', function()
        require('lspsaga.diagnostic'):goto_prev({ severity = vim.diagnostic.severity.ERROR })
    end)

    keymap('n', '[o', '<cmd>Lspsaga outline<CR>')
    keymap('n', 'K', '<cmd>Lspsaga hover_doc<CR>')

    keymap('n', '\\f', '<cmd>lua vim.lsp.buf.format({async = true})<CR>')

    require('lspsaga').setup({
        symbol_in_winbar = {
            enable = false, -- слишком медленно
        },
    })
end
