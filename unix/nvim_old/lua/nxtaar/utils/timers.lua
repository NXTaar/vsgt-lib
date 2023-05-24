local uv = vim.loop

local exports = {}

function exports.setTimeout(callback, timeout)
	local timer = uv.new_timer()

	timer:start(timeout, 0, function()
		timer:stop()
		timer:close()
		callback()
	end)

	return timer
end

function exports.setInterval(callback, interval)
	local timer = uv.new_timer()
	timer:start(interval, interval, function()
		callback()
	end)
	return timer
end

function exports.clearInterval(timer)
	timer:stop()
	timer:close()
end

return exports
