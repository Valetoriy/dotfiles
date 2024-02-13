return function()
    local keymap = vim.keymap.set
    local harpoon = require('harpoon')

    keymap('n', '<Leader>a', function() harpoon:list():append() end)
    keymap('n', '<Leader>d', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

    keymap('n', '<Leader>j', function() harpoon:list():select(1) end)
    keymap('n', '<Leader>k', function() harpoon:list():select(2) end)
    keymap('n', '<Leader>l', function() harpoon:list():select(3) end)
    keymap('n', '<Leader>;', function() harpoon:list():select(4) end)

    keymap('n', '<TAB>n', function() harpoon:list():next() end)
    keymap('n', '<TAB>p', function() harpoon:list():prev() end)

    harpoon:setup()
end
