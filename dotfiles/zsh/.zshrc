# load /etc/profile.d scripts as bashrc would
[[ -r $XDG_CONFIG_HOME/dotfiles/dotfiles/zsh/load-etc-profiled ]] && emulate sh -c 'source $XDG_CONFIG_HOME/dotfiles/dotfiles/zsh/load-etc-profiled'

# sane history
HISTFILE=~/.config/zsh/.histfile
HISTSIZE=100000
SAVEHIST=100000
setopt HIST_SAVE_NO_DUPS
setopt INC_APPEND_HISTORY

# Configure the push directory stack (most people don't need this) # TODO: do i?
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT

# zsh-newuser-install settings
setopt autocd extendedglob nomatch notify
unsetopt beep

# Emacs keybinds
bindkey -e

# Completion (compinstall)
zstyle :compinstall filename '/home/beforan/.config/zsh/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# OMZ directory aliases # https://github.com/ohmyzsh/ohmyzsh/blob/master/lib/directories.zsh
# alias l='ls -lah'
# alias la='ls -lAh'
# alias ll='ls -lh'
# alias ls='ls -G'
# alias lsa='ls -lah'

alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'

alias -- -='cd -'
alias 1='cd -1'
alias 2='cd -2'
alias 3='cd -3'
alias 4='cd -4'
alias 5='cd -5'
alias 6='cd -6'
alias 7='cd -7'
alias 8='cd -8'
alias 9='cd -9'


# General ENV
export HOMEBREW_BUNDLE_FILE="$XDG_CONFIG_HOME/dotfiles/brewfiles/Brewfile"

# Init Antigen (zsh plugins) so we can load plugins
source $HOMEBREW_PREFIX/share/antigen/antigen.zsh

# nvm (dev?)
export NVM_DIR="$HOME/.local/nvm"
# export NVM_LAZY_LOAD=true
antigen bundle lukechilds/zsh-nvm

antigen apply

# custom aliases
alias dotfiles="$VISUAL $XDG_CONFIG_HOME/dotfiles"
alias conda-activate="source ~/.local/conda/bin/activate"

# directory hashes
hash -d s=$HOME/src

# PATH modifications
export PATH=$HOME/.local/appimage:$PATH

# Init stuff
source <(fzf --zsh)
eval "$(zoxide init zsh)"
eval "$(starship init zsh)"
eval "$(atuin init zsh)"

