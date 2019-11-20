# zsh
sudo apt install zsh -y

# now let's pre-link the configs so the following don't run any interactive config
cd ~
ln -s ./.dotfiles/zsh/.zshrc .zshrc
ln -s ./.dotfiles/zsh/.p10k.zsh .p10k.zsh

# oh my zsh (unattended; does not set default shell)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" "" --unattended

# powerline10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k