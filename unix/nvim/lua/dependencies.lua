local exports = {}

exports.deps = {}

function exports.module(reqs, plugins, cb)
	for _, plugin in pairs(plugins) do
		exports.deps[#exports.deps + 1] = plugin
	end

	local resolved = {}

	for _, dep in pairs(reqs) do
		local status_ok, module = pcall(require, dep)

		if not status_ok then
			return
		end

		resolved[#resolved + 1] = module
	end

    cb(unpack(resolved))
end

return exports
