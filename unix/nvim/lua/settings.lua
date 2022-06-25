local cmd = vim.cmd -- to execute Vim commands e.g. cmd('pwd')
local opt = vim.opt -- to opt.options
local HOME = os.getenv("HOME")

vim.o.termguicolors = true
cmd[[set hidden]]
cmd[[colorscheme nord]]

cmd("language en_US")

-- Show line numbers
opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes"

-- Intendation and tabs
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smarttab = true
opt.wrap = false

-- Backup settings
opt.swapfile = false
opt.backup = false
opt.undofile = true
opt.undodir = HOME .. "/.nvim/undodir"
-- Comment

-- Search
opt.incsearch = true
opt.hlsearch = false

-- Scroll
opt.scrolloff = 8

-- Encoding
opt.fileencoding = "utf-8"

-- Keyword size definition
cmd([[set iskeyword+=-]])

vim.g.fugitive_gitlab_domains = { "https://gitlab.m2.ru" }

vim.g.gitlab_api_keys = {
	["https://gitlab.m2.ru"] = "_HpAwPs2KGobHqmViK4J",
}