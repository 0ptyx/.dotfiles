abbr -a l 'ls'
abbr -a ll 'ls -l'
abbr -a lll 'ls -la'

if command -v nvim > /dev/null
	abbr -a e nvim
else
	abbr -a e vim
end

set fish_greeting ""
set PATH $HOME/.local/bin $PATH
