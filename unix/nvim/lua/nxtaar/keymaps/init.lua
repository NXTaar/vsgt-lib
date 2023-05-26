local keymap = require('nxtaar.keymaps.utils').keymap

-- Clear highlighted selection
keymap({ key = '<C-n>', cmd = 'noh' })

-- Split-screen navigation
keymap({ key = '<C-h>', cmd = '<C-w>h' })
keymap({ key = '<C-j>', cmd = '<C-w>j' })
keymap({ key = '<C-k>', cmd = '<C-w>k' })
keymap({ key = '<C-l>', cmd = '<C-w>l' })

-- Version control
keymap({ l_key = 'gg', action = 'git.open-figutive' })
keymap({ l_key = 'gtr', action = 'git.open-flog-tree' })

-- Source file
keymap({ l_key = 'sc', cmd = ":source % | echo 'File '.expand('%').' sourced successfully'" })

keymap({ l_key = 'f', cmd = 'Telescope find_files' })
keymap({ l_key = '-', cmd = 'Oil' })

-- LSP
keymap({ key = 'K', action = 'lsp.show-hint', silent = false, remap = false, buffer = true })
keymap({ key = 'gd', action = 'lsp.go-to-definition', silent = false, remap = false, buffer = true })
keymap({ key = 'gD', action = 'lsp.go-to-declaration', silent = false, remap = false, buffer = true })
keymap({ key = 'gi', action = 'lsp.go-to-implementation', silent = false, remap = false, buffer = true })
keymap({ key = 'go', action = 'lsp.go-to-type-definition', silent = false, remap = false, buffer = true })
keymap({ key = 'gr', action = 'lsp.go-to-references', silent = false, remap = false, buffer = true })
keymap({ key = 'gs', action = 'lsp.signature-help', silent = false, remap = false, buffer = true })
keymap({ l_key = 'rn', action = 'lsp.rename', silent = false, remap = false, buffer = true })
keymap({ key = '<F3>', action = 'lsp.format-async', silent = false, remap = false, buffer = true, mode={'n', 'x'} })
keymap({ l_key = 'x', action = 'lsp.code-action', silent = false, remap = false, buffer = true })
keymap({ l_key = 'i', action = 'lsp.show-info', silent = false, remap = false, buffer = true })
keymap({ key = '[d', action = 'lsp.diagnostic-go-to-prev', silent = false, remap = false, buffer = true })
keymap({ key = ']d', action = 'lsp.diagnostic-go-to-next', silent = false, remap = false, buffer = true })

-- Code completion
keymap({ key = '<CR>', action = 'completion.select' })

