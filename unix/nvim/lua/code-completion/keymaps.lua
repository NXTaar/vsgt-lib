local cmp = require("cmp")
local luasnip = require("luasnip")

local exports = {}

local check_backspace = function()
  local col = vim.fn.col "." - 1
  return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
end

exports.mapping = {}

exports.actions = {
    select_prev_item = cmp.mapping.select_prev_item(),
    select_next_item = cmp.mapping.select_next_item(),
    scroll_docs_up = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
    scroll_docs_down = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
    disable = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    close = cmp.mapping {
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    },
    -- Accept currently selected item. If none selected, `select` first item.
    -- Set `select` to `false` to only confirm explicitly selected items.
    confirm = cmp.mapping.confirm { select = true },
    smart_select_next = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expandable() then
        luasnip.expand()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif check_backspace() then
        fallback()
      else
        fallback()
      end
    end, {
      "i",
      "s",
    }),
    smart_select_prev = cmp.mapping(function(fallback)
        if cmp.visible() then
            cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
        else
            fallback()
        end
    end, {
            "i",
            "s",
        }),
}

function exports.code_completion_keymap(keymap, action)
    exports.mapping[keymap] = action 
end

return exports
