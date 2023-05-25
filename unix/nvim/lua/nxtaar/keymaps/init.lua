local keymap = require("nxtaar.keymaps.utils").keymap

-- Clear highlighted selection
keymap({ key = '<C-n>', cmd = 'noh' })

-- Split-screen navigation
keymap({ key = '<C-h>', cmd = '<C-w>h' })
keymap({ key = '<C-j>', cmd = '<C-w>j' })
keymap({ key = '<C-k>', cmd = '<C-w>k' })
keymap({ key = '<C-l>', cmd = '<C-w>l' })

-- Version control
keymap({ l_key = 'gg',  action = 'git.open-figutive'  })
keymap({ l_key = 'gtr', action = 'git.open-flog-tree' })