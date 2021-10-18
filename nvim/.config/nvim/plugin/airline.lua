local g = vim.g

g.airline_theme = 'codedark'
g.airline_powerline_fonts = 1
g['airline#extensions#whitespace#enabled'] = 0
g['airline#extensions#tabline#enabled'] = 1
g.airline_section_b = '%{strftime("%c")}'
g['airline#extensions#tabline#formatter'] = 'unique_tail'
