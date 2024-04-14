local actions = require('nxtaar.utils.action-names')
local devicons = require('nvim-web-devicons')
-- local columns = require('nxtaar.tools.buffers.columns')
local entry_maker = require('nxtaar.tools.buffers.telescope_entry_maker').telescope_entry_maker
local utils = require('nxtaar.tools.buffers.utils')
local calculate_buffer_meta = require('nxtaar.tools.buffers.buffers_meta')

local git_repo = require('nxtaar.tools.buffers.tokens.git_repo')
local buffer_number = require('nxtaar.tools.buffers.tokens.buffer_number')
local unsaved = require('nxtaar.tools.buffers.tokens.unsaved')
local file = require('nxtaar.tools.buffers.tokens.file')

local M = {}

function M.display_buffers_telescope()
    local display = entry_maker({ buffer_number, git_repo, unsaved, file }, calculate_buffer_meta)

    return function(entry)
        local bufname = entry.info.name ~= '' and entry.info.name or '[No Name]'
        local file_name = vim.fn.fnamemodify(bufname, ':p:t')
        local icons, highlight = devicons.get_icon(bufname, string.match(bufname, '%a+$'), { default = true })
        local dir_name = vim.fn.fnamemodify(bufname, ':p:h')
        local repo = utils.get_buffer_repo_name(entry.bufnr)
        local no_repo = repo == ''

        return {
            valid = true,

            value = bufname,
            ordinal = repo,
            display = display,

            bufnr = entry.bufnr,
            changed = entry.info.changed == 1,
            repo = repo,
            no_repo = no_repo,
            devicons = icons,
            devicons_highlight = highlight,
            file_name = file_name,
            dir_name = dir_name,
        }
    end
end

register_keymap_action(actions.BUFFERS_CLOSE_ALL_BUT_CURRENT, function()
    local bufs = vim.api.nvim_list_bufs()
    local current_buf = vim.api.nvim_get_current_buf()
    local closed_count = vim.tbl_count(bufs)

    for _, i in ipairs(bufs) do
        if i ~= current_buf then
            vim.api.nvim_buf_delete(i, {})
        end
    end

    vim.print('Closed buffers: ' .. closed_count - 1)
end)

return M
