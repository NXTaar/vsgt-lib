local exports = {}
local mapping = {}

exports.actions = {
    -- Declaration/Definition
    goto_declaration = vim.lsp.buf.declaration,
    goto_definition = vim.lsp.buf.definition,
    goto_type_definition = vim.lsp.buf.type_definition,
    goto_implementation = vim.lsp.buf.implementation,

    -- Info
    open_float = vim.diagnostic.open_float,
    hover = vim.lsp.buf.hover,
    signature_help = vim.lsp.buf.signature_help,
    show_references = vim.lsp.buf.references,

    -- Diagnostics
    goto_prev_diagnostics = vim.diagnostic.goto_prev,
    goto_next_diagnostics = vim.diagnostic.goto_next,

    -- Actions
    rename = vim.lsp.buf.rename,
    code_action = vim.lsp.buf.code_action,
    set_loc_list = vim.diagnostic.setloclist,
    --[[ format = function() ]]
    --[[     vim.lsp.buf.format({ ]]
    --[[         async = true, ]]
    --[[         filter = function(client) ]]
    --[[             print(client.name) ]]
    --[[             return client.name ~= "tsserver" ]]
    --[[         end ]]
    --[[     }) ]]
    --[[ end, ]]

    -- Workspaces
    add_workspace_folder = vim.lsp.buf.add_workspace_folder,
    remove_workspace_folder = vim.lsp.buf.remove_workspace_folder,
    list_workspace_folders = function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end,
}

function exports.lsp_keymap(key, action)
    mapping[#mapping + 1] = { key = key, action = action }
end

function exports.assign_keymaps(client, bufnr)
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    for _, keymap in pairs(mapping) do
        if (keymap.action ~= exports.actions.format) or client.server_capabilities.documentFormattingProvider then
            vim.keymap.set('n', keymap.key, keymap.action, bufopts)
        end
    end
end

return exports
