local uv = vim.loop
local exports = {}

function exports.create_file(file)
	local ok, fd = pcall(uv.fs_open, file, 'w', 420)
	if not ok then
		print("Couldn't create file " .. file)
		return
	end
	uv.fs_close(fd)
end

function exports.file_exists(path)
	local _, error = uv.fs_stat(path)
	return error == nil
end

return exports
