local module = {}


local vis_supports_pipe_buf = pcall(vis.pipe, vis, 'foo', 'true')

--- Wrapper for the two vis:pipe variants.
-- If vis does not support vis:pipe(input, cmd), prefix the command
-- with a printf call piping the result to the original command.
-- @param input The input to pipe to the command
-- @param cmd The external command to pipe the input to
function vis_pipe(input, cmd, fullscreen)
  if vis_supports_pipe_buf then
    return vis:pipe(input, cmd, fullscreen or false)
  end

  local escaped_input = input:gsub('\'', '\'"\'"\'')
  cmd = 'printf %s \'' .. escaped_input .. '\' | ' .. cmd
  return vis:pipe(vis.win.file, {start = 0, finish = 0}, cmd)
end



local function close_win(win)
	local file = win.file
	if file.modified then
		prompt = file.name.." has unsaved changes. save? "
		cmd = "vis-menu -p '"..prompt.."'"
		local status, out, _ = vis_pipe("y\nn", cmd)
		local choice = ""
		if status == 0 then
			if out:sub(-1) == '\n' then
				choice = out:sub(1, -2)
			else
				choice = out
			end
			vis:info(choice)
			if choice == "y" then
				local oldwin = vis.win
				vis.win = win
				vis:feedkeys("ZZ")
				vis.win = oldwin
			else
				win:close(true)
			end
		end
	else
		win:close()
	end
end

vis:command_register("close-inactive-windows", function(argv, _, win)
	for w in vis:windows() do
		if w ~= vis.win then
			close_win(w)
		end
	end
end, "Close all inactive windows")


return module
