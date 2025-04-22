If not using something like nix home manager, a non-zero amount of symlinking is required for config files.

Here are some thoughts on symlinking + Brew + Flatpak as an alternative to nix/home-manager.

## ZSH

It would be nice to have an rc builder (and maybe a Brewfile builder) so you could opt in or out of bits of config per host / needs. e.g. Keep dev bits out of .zshrc

### use a system level `zshenv` to set ZDOTDIR for a user
`sudo bash -c "echo 'ZDOTDIR=${XDG_CONFIG_HOME:-$HOME/.config}/zsh' >> /etc/zshenv"`

Then a user's dotfiles take care of the rest of zsh config

### link zsh config directory to dotfiles repo

`ln -s $XDG_CONFIG_HOME/dotfiles/dotfiles/zsh $XDG_CONFIG_HOME/zsh`

### Set user shell
`which zsh`
`sudo usermod --shell /path/to/shell < user >`

## Starship
`ln -s $XDG_CONFIG_HOME/dotfiles/dotfiles/starship.toml $XDG_CONFIG_HOME/starship.toml`
