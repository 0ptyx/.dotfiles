abbr -a l 'ls'
abbr -a ll 'ls -l'
abbr -a lll 'ls -la'

if command -v nvim > /dev/null
	abbr -a e nvim
else
	abbr -a e vim
end

function fish_prompt
    set_color white
    echo -n "$USER@"
    echo -n (cat /etc/hostname)
    echo -n ' '
    echo -n (string replace "$HOME" "~" $PWD)
    set_color f5cf65
    printf '%s ' (__fish_git_prompt)
    set_color white 
    echo "\$ "
end

set fish_command_color 48D597
set fish_greeting ""
set PATH $HOME/.local/bin $PATH
