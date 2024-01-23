local cmd = vim.cmd

local function fugitive()
    -- local GSTATUS_HEIGHT = 20

    -- register_keymap_action('git.open-figutive', function()
    --     cmd('Git')
    --     cmd(GSTATUS_HEIGHT .. 'wincmd_')
    -- end)

    register_keymap_action('git.push', function()
        cmd('Git push')
    end)

    register_keymap_action('git.pull', 'Git pull -r', 'cmd')

    register_keymap_action('git.push-force', 'Git push -f', 'cmd')
end

local function flog()
    register_keymap_action('git.open-flog-tree', 'Flog -all', 'cmd')
end

local function lazygit()
    register_keymap_action('git.open', 'LazyGit', 'cmd')
end

local M = {
    { 'tpope/vim-fugitive', config = fugitive },
    { 'rbong/vim-flog',     config = flog },
    {
        'kdheepak/lazygit.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
        },
        config = lazygit
    },
}

return M
