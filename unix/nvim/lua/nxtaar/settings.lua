local cmd = vim.cmd
local opt = vim.opt
local g = vim.g

local CACHE_PATH  = vim.fn.stdpath("cache")

-- UI Font
vim.o.guifont = 'SauceCodePro Nerd Font Mono'

-- preserve closed buffers
opt.hidden = true

-- Color settings
opt.termguicolors = true
opt.background = "dark"

-- Show line numbers
opt.number = true
opt.relativenumber = true
opt.signcolumn = 'yes'

-- Space as leader key
g.mapleader = ' '
g.maplocalleader = ' '

-- Backup settings
opt.swapfile = false
opt.backup = false
opt.undofile = true
opt.undodir = CACHE_PATH .. '/undo'

-- Search
opt.incsearch = true
opt.hlsearch = true

-- Folding
opt.foldlevel = 20
opt.foldmethod = 'expr'
opt.foldenable = false
opt.foldexpr = 'nvim_treesitter#foldexpr()'

-- Scroll
opt.scrolloff = 8

-- Encoding
opt.fileencoding = 'utf-8'

-- Consider dashes as a part of a word
cmd('set iskeyword+=-')
-- Consider dashes as not a part of a word
cmd("set iskeyword-=:")

-- Substitude highlights and changes on the fly
cmd("set inccommand=split")

-- UI language
cmd('language en_US')