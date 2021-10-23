local map = vim.api.nvim_set_keymap

map('n', '<Leader>di', "<Plug>VimspectorBalloonEval", { silent = true, noremap = true })
map('x', '<Leader>di', "<Plug>VimspectorBalloonEval", { silent = true, noremap = true })

map('n', '<Leader>de', ":call vimspector#Reset()<CR>", { silent = true, noremap = true })

vim.g.vimspector_enable_mappings = 'VISUAL_STUDIO'
