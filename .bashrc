#-------------------------------------------------------------------------------
# Basic
#-------------------------------------------------------------------------------
# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
  PATH="$HOME/bin:$PATH"
fi

# Rechner-spezifische .bashrc
if [ -f "$HOME/.bashrc_extension" ]; then
    . "$HOME/.bashrc_extension"
fi

# Colors
BLACK=$(tput setaf 0)
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
LIME_YELLOW=$(tput setaf 190)
POWDER_BLUE=$(tput setaf 153)
BLUE=$(tput setaf 4)
MAGENTA=$(tput setaf 5)
CYAN=$(tput setaf 6)
WHITE=$(tput setaf 7)
BRIGHT=$(tput bold)
NORMAL=$(tput sgr0)
BLINK=$(tput blink)
REVERSE=$(tput smso)
UNDERLINE=$(tput smul)

[ -e ~/.dircolors ] && eval $(dircolors -b ~/.dircolors) || 
  eval $(dircolors -b)

# History handling tmux/multiple terminals
export HISTCONTROL=ignoredups:erasedups # avoid duplicates..
shopt -s histappend # append history entries.
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND" # After each command, save and reload history

# Bessere Pfeiltasten-Histotie. Berücksichtigt was getippt wurde
# Pfeil nach oben
bind '"\e[A": history-search-backward'

# Pfeil nach unten
bind '"\e[B": history-search-forward'


#-------------------------------------------------------------------------------
# Alias
#-------------------------------------------------------------------------------

# ls
alias ll="ls -lsh"
alias lls="ll --color=always -lsh | less -r"

## Normaler Kalender :)
alias cal="cal -mw"


#-------------------------------------------------------------------------------
# Functions
#-------------------------------------------------------------------------------

# Return-code Farbe für ps1long
function rcsymbol(){
    if [ ! $? -eq 0 ]; then
        echo -e "${RED}"
    else
	    echo -e "${NORMAL}"
    fi
}

# Sehr einfache ps1
function ps1short(){
    HOSTCOLOR=$GREEN
    if [ ! "$(hostname)" = "lwesu0319" ]; then
        HOSTCOLOR=$RED
    fi

    PS1="${GREEN}\u@${HOSTCOLOR}\h:${YELLOW}\W\$(rcsymbol)\$${NORMAL} "
}

# Ausführliche PS1 mit Git info etc,
function ps1long(){
    source ~/.git-prompt.bsh
    GIT_PS1_SHOWDIRTYSTATE=true
    GIT_PS1_SHOWUNTRACKEDFILES=true  
    GIT_PS1_SHOWUPSTREAM="verbose git" 
    HOST="$GREEN"
    
    if [ "$HOSTNAME" != "lwesu0319" ]; then
      HOST="$RED"
    fi


    PS1="${GREEN}\u@${HOST}\h:${YELLOW}\w ${CYAN}\$(__git_ps1 "%s")\$(rcsymbol)\n\$${NORMAL} "
}

function ps4default(){
    PS4='+ \e[0;33m[pid${BASHPID}][$(basename "${BASH_SOURCE}"):${LINENO}]: ${FUNCNAME[0]:+${FUNCNAME[0]}(): }\e[m';
}

function debug() {
    PS4="$PS4"'$(read -p "==================================== ENTER ====================================")' bash -vx "$@"    
}

function cheat(){
  # ?T => ohne Farben
  curl --silent "cht.sh/${1}?T" | less 
}

# Sucht den ersten match und startet less
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

function tailgrep(){
  #tail -n+1 -F "$2" | grep --line-buffered "$1"
  tail -n100 -F "$2" | grep --line-buffered "$1"
}

function space(){
  # Extra newline => better readability with linewrapping
  sed 's/$/\n/g'
}

# grep project. Ignoriert .idea und .git
function grepp(){
  grep -Iirn --exclude-dir={.idea,.git} ${1}
}

function gitoverview(){
    for d in "${1:-$(pwd)}"/*/.git; do
        r=${d%.git}
        echo "$r"
        git -C "$r" log \
            --since="{$2:-1week}" \
            --committer="lwescr22" \
            --reverse \
            --pretty='format:%h  %cd  %s'
    done
}

# curl with kerberos
function kurl(){
   curl --negotiate -u : $@
}

# curl with kerberos und xdebug
function xkurl(){
   curl -b XDEBUG_SESSION=lwescr22 --negotiate -u : $@
}

# TMUX Home Session 
function tmuxa(){
    tmux new-session -A -s main
}

function share(){
  python3 -m http.server 1337
}

#-------------------------------------------------------------------------------
# PS ...
#-------------------------------------------------------------------------------
ps1long
ps4default
