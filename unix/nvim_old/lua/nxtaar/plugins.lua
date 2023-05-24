local plugins = require('nxtaar.dependencies').list
local fn = vim.fn

-- Automatically install packer
local ensure_packer = function()
	local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, 'packer')
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require('packer.util').float({ border = 'rounded' })
		end,
	},
})

return packer.startup(function(use)
	use('wbthomason/packer.nvim')

	for _, plugin in pairs(plugins) do
		use(plugin)
	end

	if packer_bootstrap then
		packer.sync()
	end
end)
