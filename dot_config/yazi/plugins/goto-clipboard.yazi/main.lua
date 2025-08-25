-- Plugin to go to path from clipboard
return {
    entry = function()
        -- Get clipboard content
        local output = Command("sh"):arg({ "-c", "wl-paste 2>/dev/null || xclip -o 2>/dev/null" }):output()

        if not output then
            ya.notify({
                title = "Clipboard Error",
                content = "Could not read clipboard",
                timeout = 3,
                level = "error",
            })
            return
        end

        local clipboard_content = output.stdout:gsub("%s+$", "") -- Remove trailing whitespace

        if clipboard_content == "" then
            ya.notify({
                title = "Clipboard Empty",
                content = "No path found in clipboard",
                timeout = 3,
                level = "warn",
            })
            return
        end

        -- Expand ~ to home directory
        if clipboard_content:sub(1, 1) == "~" then
            clipboard_content = os.getenv("HOME") .. clipboard_content:sub(2)
        end

        -- Check if the path exists
        local url = Url(clipboard_content)
        if not url then
            ya.notify({
                title = "Invalid Path",
                content = "Invalid path: " .. clipboard_content,
                timeout = 3,
                level = "error",
            })
            return
        end

        -- Change to directory
        ya.manager_emit("cd", { url })
        ya.notify({
            title = "Navigation",
            content = "Changed to: " .. clipboard_content,
            timeout = 2,
            level = "info",
        })
    end,
}

