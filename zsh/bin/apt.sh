##
# zsh
##
sudo apt install zsh -y

##
# oh my zsh
##

# (unattended; does not set default shell)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" "" --unattended

# load zsh at this point so p10k will install correctly
zsh

# chuck omz's config and link ours
cd ~
rm .zshrc
ln -s ./.dotfiles/zsh/.zshrc .zshrc

##
# powerline10k
##

# link the config first so it doesn't run interactive configuration
ln -s ./.dotfiles/zsh/.p10k.zsh .p10k.zsh

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k