local M = {}

function M:peek()
	local cache = ya.file_cache(self)
	if not cache then
		return
	end

	ya.image_show(cache, self.area)
	ya.preview_code_incremental(self)
end

function M:seek()
	local h = cx.active.current.hovered
	if h and h.url then
		ya.mgr_emit("peek", { h.url })
	end
end

function M:preload()
	local cache = ya.file_cache(self)
	if cache then
		return 1
	end

	local child = Command("ffmpegthumbnailer")
		:arg({
			"-i", tostring(self.file.url),
			"-o", tostring(cache),
			"-s", "512",
			"-q", "6"
		})
		:stdout(Command.PIPED)
		:stderr(Command.PIPED)
		:spawn()

	if not child then
		return 0
	end

	local status = child:wait()
	return status and status.success and 1 or 2
end

return M