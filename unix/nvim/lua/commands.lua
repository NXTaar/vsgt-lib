local cmd = vim.cmd

cmd[[command -nargs=0 Grom silent Git fetch | Git rebase origin/master]]
cmd[[command -nargs=0 Gromi silent Git fetch | Git rebase -i origin/master]]

