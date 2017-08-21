
function fish_prompt
	echo -n -s ' ' (set_color $fish_color_cwd) (prompt_pwd) (set_color normal) ' $ '
end

set --export EDITOR nvim
set --export PYTHONSTARTUP $HOME/.pythonrc.py

alias ppjson="python -m json.tool"

alias vim="nvim"

alias l="ll"

alias open="xdg-open"


function mcat
	highlight -O xterm256 --style=zenburn -i $argv[1]
end


