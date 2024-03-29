# Set up the prompt

autoload -Uz promptinit
autoload -Uz vcs_info
precmd() { vcs_info }

zstyle ':vcs_info:git:*' formats '%b %m%u'
zstyle ':vcs_info:git*' check-for-changes true formats '%b %m%u '

setopt PROMPT_SUBST
PROMPT='%F{green}%n@%M%f %F{blue}%~%f %F{red}${vcs_info_msg_0_}%f
%(?.%F{white}.%F{red})$ %f'

# promptinit
# prompt adam1

setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'



#-------------------------------------------------------------------------------
# Basic
#-------------------------------------------------------------------------------
# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
  PATH="$HOME/bin:$PATH"
fi


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

# greping in tail
function tailgrep(){
  tail -n+1 -F "$2" | grep --line-buffered "$1"
}

# tmux attach or create main session
function tmuxa(){
    tmux new-session -A -s main
}

