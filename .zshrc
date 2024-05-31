#-- dotfiles .zshrc begin --

# TODO: install pipx in home-manager?
# Created by `pipx` on 2023-12-30 20:47:16
export PATH="$PATH:/home/beforan/.local/bin"

# bun completions # TODO install bun in home-manager?
[ -s "/home/beforan/.bun/_bun" ] && source "/home/beforan/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

eval "$(starship init zsh)"
#-- dotfiles .zshrc end --
