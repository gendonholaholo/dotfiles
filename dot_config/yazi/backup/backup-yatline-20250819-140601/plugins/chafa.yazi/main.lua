local M = {}

function M:peek(job)
	-- Calculate optimal size for chafa based on preview area
	local width = math.min(job.area.w * 2, 120) -- Double width for better aspect ratio
	local height = math.min(job.area.h, 60)    -- Limit height to prevent overflow

	-- Run chafa with optimal parameters for yazi
	local child = Command("chafa")
			:arg({
				"--size",
				tostring(width) .. "x" .. tostring(height),
				"--format",
				"kitty",
				"--colors",
				"full",
				"--animate",
				"off", -- Disable animation for static preview
				tostring(job.file.url),
			})
			:stdout(Command.PIPED)
			:stderr(Command.PIPED)
			:spawn()

	if not child then
		-- Fallback to default image preview if chafa fails
		return require("image").peek(job)
	end

	local limit = job.area.h
	local i, lines = 0, ""
	repeat
		local next, event = child:read_line()
		if event == 1 then
			-- Error occurred, fallback to default
			return require("image").peek(job)
		elseif event ~= 0 then
			break
		end

		i = i + 1
		if i > job.skip then
			lines = lines .. next
		end
	until i >= job.skip + limit

	child:start_kill()

	-- Handle scrolling
	if job.skip > 0 and i < job.skip + limit then
		ya.mgr_emit("peek", {
			tostring(math.max(0, i - limit)),
			only_if = job.file.url,
			upper_bound = true,
		})
	else
		-- Convert tabs to spaces and display
		lines = lines:gsub("\t", string.rep(" ", 4))
		ya.preview_widgets(job, { ui.Text.parse(lines):area(job.area) })
	end
end

function M:seek(job)
	local h = cx.active.current.hovered
	if not h or h.url ~= job.file.url then
		return
	end

	-- Handle scroll events
	ya.mgr_emit("peek", {
		math.max(0, cx.active.preview.skip + job.units),
		only_if = job.file.url,
	})
end

return M
