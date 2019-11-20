# usual starters
sudo apt update
sudo apt upgrade -y

# we don't install git because to get the repo you'd need it

# curl and wget (wsl likes to not have basic stuff)
sudo apt install curl wget -y

# zsh
. ~/.dotfiles/zsh/bin/apt.sh