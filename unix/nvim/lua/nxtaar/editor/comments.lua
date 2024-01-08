local comments = require('nvim_comment')
vim.g.skip_ts_context_commentstring_module = true

comments.setup({ comment_empty = false })
require('ts_context_commentstring').setup {}
