##
# zsh
##
sudo apt install zsh -y

##
# oh my zsh
##

# (unattended; does not set default shell)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" "" --unattended

# source the default config
# it'll fail due to zsh syntax
# but sets environment variables we need to finish installation
cd ~
. ./.zshrc

# now chuck the default config and link ours
rm .zshrc
ln -s ./.dotfiles/zsh/.zshrc .zshrc

##
# powerline10k
##

# link the config first so it doesn't run interactive configuration
ln -s ./.dotfiles/zsh/.p10k.zsh .p10k.zsh

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k