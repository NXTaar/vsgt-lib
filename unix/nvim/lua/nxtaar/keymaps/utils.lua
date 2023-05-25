local keymap = vim.keymap.set

local M = {}
local actions = {}

local function cmd_cb(cmd)
    return function()
        vim.cmd(cmd)
    end
end

function M.register_keymap_action(key, callback)
    actions[key] = callback
end

function M.keymap(config)
    local mode = config.mode or 'n'
    local silent = config.silent or true
    local remap = config.noremap or false
    local key = config.l_key and "<leader>" .. config.l_key or config.key
    local output = nil

    local options = {
        silent = silent,
        remap = remap
    }

    if config.cmd then
        output = cmd_cb(config.cmd)
    end

    if config.callback then
        output = config.callback
    end

    if config.action and actions[config.action] ~= nil then
        output = actions[config.action]
    end

    if config.action and actions[config.action] == nil then
        print("No registered keymap for action: " .. config.action)
        return
    end

    keymap(mode, key, output, options)
end

return M
