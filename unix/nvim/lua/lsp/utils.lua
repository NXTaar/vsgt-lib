local cmp_nvim_lsp = require "cmp_nvim_lsp"

local exports = {}

function exports.assign_keymaps(mapping, bufnr)
    local opts = { noremap = true, silent = true }

    for _, keymap in pairs(mapping) do
        vim.api.nvim_buf_set_keymap(bufnr, keymap[1], keymap[2], keymap[3], opts)
    end
end

function exports.lsp_highlight_document(client)
    -- Set autocommands conditional on server_capabilities
    if client.resolved_capabilities.document_highlight then
        vim.api.nvim_exec(
            [[
                augroup lsp_document_highlight
                    autocmd! * <buffer>
                    autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
                    autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
                augroup END
            ]],
            false
        )
    end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
exports.capabilities = cmp_nvim_lsp.update_capabilities(capabilities)

return exports
