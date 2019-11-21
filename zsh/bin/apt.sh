# Don't run directly; we depend on $DOTFILES_REPO

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
. $HOME/.zshrc

# now chuck the default config and link ours
rm $HOME/.zshrc
ln -s $DOTFILES_REPO/zsh/.zshrc $HOME/.zshrc

##
# powerline10k
##

# link the config first so it doesn't run interactive configuration
ln -s $DOTFILES_REPO/zsh/.p10k.zsh $HOME/.p10k.zsh

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k