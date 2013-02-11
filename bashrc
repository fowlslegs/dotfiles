shopt -s checkwinsize
shopt -s no_empty_cmd_completion
shopt -s histappend cmdhist
shopt -s globstar

complete -cf sudo
complete -cf man

_prompt_command() {
    builtin history -a
    case "$TERM" in
        rxvt* | xterm*)
            echo -en "\e]0;Terminal ${PWD//$HOME/~}$(git branch --no-color 2> /dev/null | grep '^\*' | sed 's/\* \(.*\)/ (\1)/')\a"
            ;;
    esac
    tput ed
}

export PS1='\[\e[1;35m\]>\[\e[0m\] '
export PS2='\[\e[1;30m\]>\[\e[0m\] '
export PROMPT_COMMAND='_prompt_command'

[ -r "$SHELL_ALIASES" ] && . "$SHELL_ALIASES"
[ -r "$SHELL_FUNCTIONS" ] && . "$SHELL_FUNCTIONS"

. /etc/profile.d/z.sh
. "$XDG_CONFIG_HOME"/bash_completion.d/eat
complete -abck i
complete -c bed
complete -C finddots dot

eval $(dircolors -b ~/.dircolors)

if [ "$TERM" = "linux" ] ; then
    "$XDG_COLORS_DIR"/redef_console
fi

if [ -f "/usr/lib/libstderred.so" ]; then
    export LD_PRELOAD="/usr/lib/libstderred.so"
fi
