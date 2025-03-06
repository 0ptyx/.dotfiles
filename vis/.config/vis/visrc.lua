-- load standard vis module, providing parts of the Lua API
require('vis')
require('grep')
require('close-inactive-windows')
require('open-file-under-cursor')

-- grep.lua
local leader = ' '
vis.events.subscribe(vis.events.INIT, function()
	-- Your global configuration options
	vis:command('set ai')
	vis:command('set theme gruvbox')
	vis:map(vis.modes.NORMAL, leader.."sg", function()
		vis:command('live-grep')
	end, 'Live grep')
	vis:map(vis.modes.NORMAL, leader.."sw", function()
		vis:feedkeys("viw")
		local selection = vis.win.file:content(vis.win.selection.range)
		vis:command('grep '..selection)
	end, 'Grep word')
	vis:map(vis.modes.VISUAL, leader.."sw", function()
		local selection = vis.win.file:content(vis.win.selection.range)
		vis:command('grep '..selection)
	end, 'Grep Word')
end)

vis.events.subscribe(vis.events.WIN_OPEN, function(win)
	-- Your per window configuration options e.g.
	vis:command('set number')
end)
