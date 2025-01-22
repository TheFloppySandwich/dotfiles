if status is-interactive
    # Commands to run in interactive sessions can go here
    # if type -q tmux
	#     if not test -n "$TMUX"
	# 	tmux attach-session -t default; or tmux new-session -s default
	#     end
	# end
	#set -Ux TERM xterm-256color

	alias ls="ls -A -l -lt --color=auto"
	alias grep="grep --color=auto"
	set ZELLIJ_AUTO_ATTACH true
	set ZELLIJ_AUTO_EXIT true
	eval (zellij setup --generate-auto-start fish | string collect)
	function ze
	  command zellij edit $argv
	end
	function zef
	  command zellij edit --floating --height 80% --width 80% -x 10% -y 10% $argv
	end
end


