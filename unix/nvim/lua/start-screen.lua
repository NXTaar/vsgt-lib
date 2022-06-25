local function init(alpha, startify_theme)
	alpha.setup(startify_theme.config)
end

require('dependencies').module({ 'alpha', 'alpha.themes.startify' }, {
	{
		'goolord/alpha-nvim',
		requires = 'kyazdani42/nvim-web-devicons',
	},
}, init)
