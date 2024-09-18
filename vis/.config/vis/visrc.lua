-- load standard vis module, providing parts of the Lua API
require('vis')
require('grep')
require('close-inactive-windows')

local leader = ' '
vis.events.subscribe(vis.events.INIT, function()
	-- Your global configuration options
	vis:command('set ai')
	vis:command('set theme gruvbox')
	vis:map(vis.modes.NORMAL, leader.."sg", function()
		vis:command('live-grep')
	end, 'Live grep')
end)

vis.events.subscribe(vis.events.WIN_OPEN, function(win)
	-- Your per window configuration options e.g.
	vis:command('set number')
end)
