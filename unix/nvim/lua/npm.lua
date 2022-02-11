local function init(pkg)
    pkg.setup()
end

require("dependencies").module({ "package-info" }, {
	{
		"vuki656/package-info.nvim",
		requires = "MunifTanjim/nui.nvim",
	},
}, init)
