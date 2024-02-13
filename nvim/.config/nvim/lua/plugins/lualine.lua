return function()
    local colors = {
        green  = '#0dbc79',
        cyan   = '#11a8cd',
        white  = '#c6c6c6',
        red    = '#cd3131',
        yellow = '#e5e510',
        violet = '#bc3fbc',
        grey   = '#303030',
    }

    local bubbles_theme = {
        normal = {
            a = { fg = colors.grey, bg = colors.cyan },
            b = { fg = colors.white, bg = colors.grey },
            c = { fg = colors.grey, bg = colors.grey },
        },
        insert = { a = { fg = colors.grey, bg = colors.violet } },
        visual = { a = { fg = colors.grey, bg = colors.green } },
        replace = { a = { fg = colors.grey, bg = colors.red } },
        inactive = {
            a = { fg = colors.white, bg = colors.grey },
            b = { fg = colors.white, bg = colors.grey },
            c = { fg = colors.grey, bg = colors.grey },
        },
    }

    require('lualine').setup {
        options = {
            theme = bubbles_theme,
            component_separators = '|',
            section_separators = { left = '', right = '' },
        },
        sections = {
            lualine_a = {
                { 'mode', separator = { left = '' }, right_padding = 2,
                    color = function()
                        return {
                            bg = vim.api.nvim_get_mode().mode == 'n'
                                and vim.bo.modified and colors.yellow
                        }
                    end,
                },
            },
            lualine_b = { 'filename', 'branch' },
            lualine_c = { 'fileformat' },
            lualine_x = {},
            lualine_y = {
                function()
                    return os.date('%Y-%m-%d %H:%M:%S')
                end,
                'encoding', 'filetype', 'progress' },
            lualine_z = {
                { 'location', separator = { right = '' }, left_padding = 2 },
            },
        },
        inactive_sections = {
            lualine_a = { 'filename' },
            lualine_b = {},
            lualine_c = {},
            lualine_x = {},
            lualine_y = {},
            lualine_z = { 'location' },
        },
        tabline = {},
        extensions = {},
    }
end
