return {
	'wbthomason/packer.nvim',
	'stevearc/dressing.nvim',
	'windwp/nvim-autopairs',

	-- Buffer preserver
	'moll/vim-bbye',

	-- Git integration
	'tpope/vim-fugitive',
	'tpope/vim-unimpaired',
	'tpope/vim-dispatch',
	'shumphrey/fugitive-gitlab.vim',
	'rbong/vim-flog',
	'junegunn/gv.vim',

	-- Color theme
	'shaunsingh/nord.nvim',

	-- Syntax highlighting
	{
		'nvim-treesitter/nvim-treesitter',
		run = ':TSUpdate',
	},

	-- File explorer
	{
		'kyazdani42/nvim-tree.lua',
		requires = {
			'kyazdani42/nvim-web-devicons',
		},
	},
}
