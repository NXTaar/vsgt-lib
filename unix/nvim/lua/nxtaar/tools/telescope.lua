local M = {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope-project.nvim'
    }
}


function M.config()
    local telescope = require('telescope')
    local builtin = require('telescope.builtin')
    local themes = require('telescope.themes')
    local register_action = require('nxtaar.utils.actions').register_action

    telescope.setup({
        pickers = {
            find_files = {
                find_command = { 'fd', '--type', 'f', '--strip-cwd-prefix' }
            },
        },
    })

    telescope.load_extension('project')

    register_action('telescope.show-references', function()
        builtin.lsp_references(themes.get_ivy({ initial_mode = 'normal' }))
    end)

    register_keymap_action('telescope.show-projects', function()
        telescope.extensions.project.project(themes.get_dropdown({
            initial_mode = 'normal',
            order_by = 'asc',
        }))
    end)

    register_keymap_action('telescope.find-in-files', function()
        vim.fn.system('git rev-parse --is-inside-work-tree')

        if vim.v.shell_error == 0 then
            builtin.git_files()
        else
            builtin.find_files()
        end
    end)

    register_keymap_action('telescope.live-grep', function()
        builtin.live_grep()
    end)
end

return M

