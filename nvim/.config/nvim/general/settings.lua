--set leader key
--let g:mapleader = "\<Space>"
vim.g.mapleader = " "

local t = vim.opt

--set termguicolors
t.termguicolors = true
--syntax enable                           " Enables syntax highlighing
--t.syntax = "enable"
--set nohlsearch
t.hlsearch = false
--set noerrorbells
t.errorbells = false
--set incsearch
t.incsearch = true
--set hidden                              " Required to keep multiple buffers open
t.hidden = true
--set nowrap                              " Display long lines as just one line
t.wrap = false
--set encoding=utf-8                      " The encoding displayed
t.encoding = "utf-8"
--set pumheight=10                        " Makes popup menu smaller
t.pumheight = 10
--set fileencoding=utf-8                  " The encoding written to file
t.fileencoding = "utf-8"
--set ruler              			        " Show the cursor position all the time
t.ruler = true
--set cmdheight=2                         " More space for displaying messages
t.cmdheight = 2
--set iskeyword+=-                      	" Treat dash separated words as a word text object"
t.iskeyword:append({ '-' })
--set mouse=a                             " Enable your mouse
t.mouse = "a"
--set splitbelow                          " Horizontal splits will automatically be below
t.splitbelow = true
--set splitright                          " Vertical splits will automatically be to the right
t.splitright = true
--set t_Co=256                            " Support 256 colors
--set conceallevel=0                      " So that I can see `` in markdown files
t.conceallevel = 0
--set tabstop=4                           " Insert 4 spaces for a tab
t.tabstop = 4
--set softtabstop=4
t.softtabstop = 4
--set scrolloff=8
t.scrolloff = 8
--set shiftwidth=4                        " Change the number of space characters inserted for indentation
t.shiftwidth = 4
--set smarttab                            " Makes tabbing smarter will realize you have 2 vs 4
t.smarttab = true
--set expandtab                           " Converts tabs to spaces
t.expandtab = true
--set smartindent                         " Makes indenting smart
t.smartindent = true
--set autoindent                          " Good auto indent
t.autoindent = true
--set laststatus=0                        " Always display the status line
t.laststatus = 0
--set number                              " Line numbers
t.number = true
--set relativenumber
t.relativenumber = true
--set cursorline                          " Enable highlighting of the current line
t.cursorline = true
--set background=dark                     " Tell vim what the background color looks like
--set showtabline=2                       " Always show tabs
--set noshowmode                          " We don't need to see things like -- INSERT -- anymore
--set nobackup                            " This is recommended by coc
--set nowritebackup                       " This is recommended by coc
--set updatetime=50                       " Faster completion
t.updatetime = 50
--set timeoutlen=500                      " By default timeoutlen is 1000 ms
t.timeoutlen = 500
--set formatoptions-=cro                  " Stop newline continuation of comments
t.formatoptions:remove({ 'c', 'r', 'o' })
--set clipboard=unnamedplus               " Copy paste between vim and everything else
t.clipboard = "unnamedplus"
--set shortmess+=c
t.shortmess:append({ c = true })
--set autochdir                           " Your working directory will always be the same as your working directory
