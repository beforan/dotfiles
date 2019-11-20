# usual starters
sudo apt update
sudo apt upgrade -y

# we don't install git because to get the repo you'd need it

# curl and wget (wsl likes to not have basic stuff)
sudo apt install curl wget -y

# zsh
. ~/.dotfiles/zsh/bin/apt.sh




# we're done; remind user we haven't changed the default shell
# becuase that's interactive
echo "Use chsh to change the default shell to /bin/zsh if it isn't already"