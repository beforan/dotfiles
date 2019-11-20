# usual starters
sudo apt update
sudo apt upgrade -y

# we don't install git because to get the repo you'd need it

# curl and wget (wsl likes to not have basic stuff)
sudo apt install curl wget -y

# jq, so we can perform shenanigans with GitHub's API
sudo apt install jq -y

# zsh
. ~/.dotfiles/zsh/bin/apt.sh




# we're done; remind user we haven't changed the default shell
# becuase that's interactive
echo "✔ Installation complete"
echo "ℹ Use chsh to change the default shell to /bin/zsh if it isn't already"
