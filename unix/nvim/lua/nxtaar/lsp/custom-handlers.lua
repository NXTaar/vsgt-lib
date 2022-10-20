local ts = require("typescript")
local get_server_settings = require("nxtaar.lsp.settings").get_server_settings

local custom_handlers = {
	tsserver = function()
		ts.setup({
			disable_commands = false,
			debug = false,
			server = get_server_settings("tsserver"),
		})
	end,
}

local function attach_custom_handlers(storage)
    for server_name, handler in pairs(custom_handlers) do
        storage[server_name] = handler
	end
    
    return storage
end

return attach_custom_handlers