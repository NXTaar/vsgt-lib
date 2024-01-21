local M = {
    'sainnhe/everforest',
}

function M.config()
    local g = vim.g

    g.everforest_background = 'hard'
    g.everforest_better_performance = 1

    vim.cmd('colorscheme everforest')
    vim.cmd('hi Normal guibg=NONE ctermbg=NONE')
end

return M

