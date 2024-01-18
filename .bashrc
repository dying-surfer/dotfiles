#-------------------------------------------------------------------------------
# Basic
#-------------------------------------------------------------------------------
# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
  PATH="$HOME/bin:$PATH"
fi

# machine specific .bashrc
if [ -f "$HOME/.bashrc_extension" ]; then
    . "$HOME/.bashrc_extension"
fi

# Colors
RESTORE='\[\033[0m\]'
RED='\[\033[00;31m\]'; GREEN='\[\033[00;32m\]'; YELLOW='\[\033[00;33m\]'; BLUE='\[\033[00;34m\]'; PURPLE='\[\033[00;35m\]'; CYAN='\[\033[00;36m\]'; LIGHTGRAY='\[\033[00;37m\]';
LRED='\[\033[01;31m\]'; LGREEN='\[\033[01;32m\]'; LYELLOW='\[\033[01;33m\]'; LBLUE='\[\033[01;34m\]'; LPURPLE='\[\033[01;35m\]'; LCYAN='\[\033[01;36m\]'; WHITE='\[\033[01;37m\]';

[ -e ~/.dircolors ] && eval $(dircolors -b ~/.dircolors) || 
  eval $(dircolors -b)

# History handling tmux/multiple terminals
export HISTCONTROL=ignoredups:erasedups # avoid duplicates..
shopt -s histappend # append history entries.
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND" # After each command, save and reload history

# better history arrow behaviour
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'


#-------------------------------------------------------------------------------
# Alias
#-------------------------------------------------------------------------------

# ls
alias ll="ls -lsh"
alias lls="ll --color=always -lsh | less -r"

# german style calender
alias cal="cal -mw"

#-------------------------------------------------------------------------------
# Functions
#-------------------------------------------------------------------------------

# color based on return code
function rcsymbol(){
    if [ ! $? -eq 0 ]; then
        echo -e "\033[00;31m"
    else
	    echo -e "\033[0m"
    fi
}

# simple prompt
function ps1short(){
    HOSTCOLOR=$GREEN
    if [ ! "$(hostname)" = "lwesu0319" ]; then
        HOSTCOLOR=$RED
    fi

    PS1="${GREEN}\u@${HOSTCOLOR}\h:${YELLOW}\W\$(rcsymbol)\$${RESTORE} "
}

# informative prompt
function ps1long(){
    source ~/.git-prompt.bsh
    GIT_PS1_SHOWDIRTYSTATE=true
    GIT_PS1_SHOWUNTRACKEDFILES=true  
    GIT_PS1_SHOWUPSTREAM="verbose git"  

    PS1="${GREEN}\u@${GREEN}\h:${YELLOW}\w ${CYAN}\$(__git_ps1 "%s")\$(rcsymbol)\n\$${RESTORE} "
}

function ps4default(){
    PS4='+ \e[0;33m[pid${BASHPID}][$(basename "${BASH_SOURCE}"):${LINENO}]: ${FUNCNAME[0]:+${FUNCNAME[0]}(): }\e[m';
}

function debug() {
    PS4="$PS4"'$(read -p "==================================== ENTER ====================================")' bash -vx "$@"    
}

# less for logfiles
function loss(){
  if [ -z "${2}" ]; then
    # To the end
    opt="-n +G"
  else
    # Search pattern
    opt="--pattern=${2}"
  fi
  less -S $opt ${1}
}

# greping in tail
function tailgrep(){
  tail -n+1 -F "$2" | grep --line-buffered "$1"
}

# add newlines for readability with line wrapping
function space(){
  # Extra newline => better readability with linewrapping
  sed 's/$/\n/g'
}

# grep project, ignoring .git and .idea
function grepp(){
  grep -Iirn --exclude-dir={.idea,.git} ${1}
}

# tmux attach or create main session
function tmuxa(){
    tmux new-session -A -s main
}

# spin up webserver for fast filesharing
function share(){
  python3 -m http.server 1337
}

#-------------------------------------------------------------------------------
# PS ...
#-------------------------------------------------------------------------------
ps1long
ps4default
