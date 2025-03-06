local module = {}
module.fzf_path = "fzf"
module.grep_path = "rg"
module.cat_path = "batcat"
module.fzf_args = ""

local function grep(cmd)
	local file = io.popen(cmd)
	local output = {}
	for line in file:lines() do
		table.insert(output, line)
	end
	local success, msg, status = file:close()
	
    	if status == 0 then
        	local action = 'e'

        	if     output[1] == 'ctrl-s' then action = 'split'
        	elseif output[1] == 'ctrl-v' then action = 'vsplit'
	        end
		local f = {}
		for file in string.gmatch(output[2], "([^:]+)") do
			table.insert(f, file)
		end

	        vis:feedkeys(string.format(":%s '%s'<Enter>", action, f[1]))
	        vis:feedkeys(string.format(":%s<Enter>", f[2]))
    	elseif status == 1 then
	        vis:info(
			string.format(
	                "vis-grep: No match. Command %s exited with return value %i.",
	                command, status
			)
	        )
    	elseif status == 2 then
	        vis:info(
			string.format(
	                "vis-grep: Error. Command %s exited with return value %i.",
	                command, status
			)
	        )
    	elseif status == 130 then
	        vis:info(
			string.format(
	                "vis-grep: Interrupted. Command %s exited with return value %i",
	                command, status
			)
	        )
    	else
	        vis:info(
			string.format(
	                "vis-grep: Unknown exit status %i. command %s exited with return value %i",
	                status, command, status
			)
	        )
    	end
	vis:redraw()
    	--vis:feedkeys("<vis-redraw>")

    	return true;

end

vis:command_register("live-grep", function(argv, force, win, selection, range)
	local fzf_path = module.fzf_path
	local cat_path = module.cat_path

	fzf_path = (
		[[FZF_DEFAULT_COMMAND="echo ''" fzf]]
	)

	local command = string.gsub([[
			$fzf_path -d ':' \
			--header="Enter:edit,^s:split,^v:vsplit" \
			--expect="ctrl-s,ctrl-v" \
			--preview="$cat_path --style=full --color=always --highlight-line {2} -n {1} 2>/dev/null" \
			--preview-window="+{2}/2" \
			--bind "change:reload(./live-grep.sh {q})" \
			--ansi --disabled \

		]],
		'%$([%w_]+)', {
			fzf_path=fzf_path,
			cat_path=cat_path
		}
	)
	return grep(command)

end, "Interactive grep")

vis:command_register("grep", function(argv, force, win, selection, range)
	local fzf_path = module.fzf_path
	local grep_path = module.grep_path
	local cat_path = module.cat_path
	local selection = vis.win.file:content(selection.range)
	local command = string.gsub([[
		    $grep_path -n $args | $fzf_path -d ':' \
		        --header="Enter:edit,^s:split,^v:vsplit" \
		        --expect="ctrl-s,ctrl-v" \
		        --preview="$cat_path --style=full --color=always --highlight-line {2} -n {1}" \
		        --preview-window="+{2}/2" \
		]],
		'%$([%w_]+)', {
		    grep_path=grep_path,
		    cat_path=cat_path,
		    fzf_path=fzf_path,
		    args=table.concat(argv, " ")
		}
	)

		
	return grep(command)

end, "grep files")




return module
