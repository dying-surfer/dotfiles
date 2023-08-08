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
RESTORE='\[\033[0m\]'
RED='\[\033[00;31m\]'; GREEN='\[\033[00;32m\]'; YELLOW='\[\033[00;33m\]'; BLUE='\[\033[00;34m\]'; PURPLE='\[\033[00;35m\]'; CYAN='\[\033[00;36m\]'; LIGHTGRAY='\[\033[00;37m\]';
LRED='\[\033[01;31m\]'; LGREEN='\[\033[01;32m\]'; LYELLOW='\[\033[01;33m\]'; LBLUE='\[\033[01;34m\]'; LPURPLE='\[\033[01;35m\]'; LCYAN='\[\033[01;36m\]'; WHITE='\[\033[01;37m\]';

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
        echo -e "\033[00;31m"
    else
	    echo -e "\033[0m"
    fi
}

# Sehr einfache ps1
function ps1short(){
    HOSTCOLOR=$GREEN
    if [ ! "$(hostname)" = "lwesu0319" ]; then
        HOSTCOLOR=$RED
    fi

    PS1="${GREEN}\u@${HOSTCOLOR}\h:${YELLOW}\W\$(rcsymbol)\$${RESTORE} "
}

# Ausführliche PS1 mit Git info etc,
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
  tail -n+1 -F "$2" | grep --line-buffered "$1"
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
