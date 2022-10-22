return {
	{
		'nvim-telescope/telescope.nvim',
		requires = 'nvim-lua/plenary.nvim',
	},
	{
		'nvim-telescope/telescope-fzf-native.nvim',
		run = 'make',
	},
	{
		'AckslD/nvim-neoclip.lua',
		requires = 'nvim-telescope/telescope.nvim',
	},
}
