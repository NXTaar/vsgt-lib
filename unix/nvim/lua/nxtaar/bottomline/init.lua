local lualine = require('lualine')
local setInterval = require('nxtaar.utils.timers').setInterval
local setTimeout = require('nxtaar.utils.timers').setTimeout
local clearInterval = require('nxtaar.utils.timers').clearInterval
local animations = require('nxtaar.bottomline.animations')

local exports = {}

local function update_vsc_value(value)
	vim.g.lualine_vsc_loader = value
	vim.schedule(function()
		vim.api.nvim_command('redrawtabline')
	end)
end

function exports.loader(message, animation)
	animation = animation or animations.point

	local framesCount = vim.tbl_count(animation.frames)
	local currentFrame = 0
	local timer = setInterval(function()
		currentFrame = currentFrame % framesCount + 1

		update_vsc_value(animation.frames[currentFrame] .. ' ' .. message)
	end, animation.interval)

	return function()
		clearInterval(timer)
		update_vsc_value(nil)
	end
end

function exports.message(message, timeout)
	update_vsc_value(message)

	local timer = setTimeout(function()
		update_vsc_value(nil)
	end, timeout)

	return function()
		clearInterval(timer)
		update_vsc_value(nil)
	end
end

-- vim.g.lualine_vsc_loader ="%#DevIconBash#hello%#lualine_c_normal# olol"

lualine.setup({
	options = {
		theme = 'nord',
	},
	sections = {
		lualine_b = { 'branch', 'g:lualine_vsc_loader', 'diff', 'diagnostics' },
	},
})

return exports
