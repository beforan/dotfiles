# export stuff used by sub-scripts
export DOTFILES_REPO_NAME=.dotfiles # could be customisable one day
export DOTFILES_REPO=$HOME/$DOTFILES_REPO_NAME
. $DOTFILES_REPO/bin/unix-platform.sh

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
. $DOTFILES_REPO/zsh/bin/apt.sh

# fonts referenced by configs
. $DOTFILES_REPO/bin/fonts/linux.sh


# we're done; remind user we haven't changed the default shell
# becuase that's interactive
echo "🎉 Installation complete"
echo "👉 Use chsh to change the default shell to /bin/zsh if it isn't already"
