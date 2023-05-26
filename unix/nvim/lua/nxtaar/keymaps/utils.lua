local keymap = vim.keymap.set

local M = {}
local actions = {}

local function cmd_cb(cmd)
    return function()
        vim.cmd(cmd)
    end
end

function M.register_keymap_action(action, cb)
    if actions[action] == nil then
        print('No keymaps for action: ' .. action)
        return
    end

    local config = actions[action]

    keymap(config.mode, config.key, cb, config.options)
end

function M.get_keymap_config_for_action(action)
    if actions[action] == nil then
        print('No keymap config for action: ' .. action)
        return
    end

    return actions[action]
end

function M.keymap(config)
    local mode = config.mode or 'n'
    local silent = config.silent or true
    local buffer = config.buffer or false
    local remap = config.remap or true
    local key = config.l_key and '<leader>' .. config.l_key or config.key
    local output = nil

    local options = {
        silent = silent,
        remap = remap,
        buffer = buffer
    }

    if config.cmd then
        output = cmd_cb(config.cmd)
    end

    if config.callback then
        output = config.callback
    end

    if config.action then
        actions[config.action] = { key = key, options = options, mode = mode }
        return
    end

    keymap(mode, key, output, options)
end

return M
