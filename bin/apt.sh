# usual starters
sudo apt update
sudo apt upgrade -y

# we don't install git because to get the repo you'd need it

# curl and wget (wsl likes to not have basic stuff)
sudo apt install curl wget -y

# fontconfig to ensure we can install fonts
sudo apt install fontconfig -y

# jq, so we can perform shenanigans with API's such as GitHub
sudo apt install jq -y

# zsh
. ~/.dotfiles/zsh/bin/apt.sh

# fonts referenced by configs
. ~/.dotfiles/bin/fonts/linux.sh


# we're done; remind user we haven't changed the default shell
# becuase that's interactive
echo "✔ Installation complete"
echo "ℹ Use chsh to change the default shell to /bin/zsh if it isn't already"
