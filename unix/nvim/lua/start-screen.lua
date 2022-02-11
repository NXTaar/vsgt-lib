local alpha = require("alpha")
local startify_theme = require("alpha.themes.startify")

local exports = {}

function exports.plugin(use)
	use({
		"goolord/alpha-nvim",
		requires = { "kyazdani42/nvim-web-devicons" },
	})
end

function exports.init()
	alpha.setup(startify_theme.config)
end

return exports
