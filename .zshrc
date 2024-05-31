#-- dotfiles .zshrc begin --

# TODO: install pipx in home-manager?
# Created by `pipx` on 2023-12-30 20:47:16
export PATH="$PATH:/home/beforan/.local/bin"

# TODO: install nvm in home-manager?
export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# bun completions # TODO install bun in home-manager?
[ -s "/home/beforan/.bun/_bun" ] && source "/home/beforan/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

eval "$(starship init zsh)"
#-- dotfiles .zshrc end --
