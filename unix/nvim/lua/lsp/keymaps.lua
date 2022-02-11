  local exports = {}

  exports.mapping = {}

  exports.actions = {
      goto_declaration = "<cmd>lua vim.lsp.buf.declaration()<CR>",
      goto_definition = "<cmd>lua vim.lsp.buf.definition()<CR>",
      hover = "<cmd>lua vim.lsp.buf.hover()<CR>",
      goto_implementation = "<cmd>lua vim.lsp.buf.implementation()<CR>",
      signature_help = "<cmd>lua vim.lsp.buf.signature_help()<CR>",
      rename = "<cmd>lua vim.lsp.buf.rename()<CR>",
      show_references = "<cmd>lua vim.lsp.buf.references()<CR>",
      code_action = "<cmd>CodeActionMenu<CR>",
      open_float = "<cmd>lua vim.diagnostic.open_float()<CR>",
      goto_prev_diagnostics = "<cmd>lua vim.diagnostic.goto_prev({ border = 'rounded' })<CR>",
      show_line_diagnostics = "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics({ border = 'rounded' })<CR>",
      goto_next_diagnostics = "<cmd>lua vim.diagnostic.goto_next({ border = 'rounded' })<CR>",
      set_loc_list = "<cmd>lua vim.diagnostic.setloclist()<CR>",
  }

  function exports.lsp_keymap(mode, key, action)
      exports.mapping[#exports.mapping + 1] = { mode, key, action }
  end

  return exports
