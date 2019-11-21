# export stuff used by sub-scripts
export DOTFILES_REPO_NAME=.dotfiles # could be customisable one day
export DOTFILES_REPO=$HOME/$DOTFILES_REPO_NAME
. $DOTFILES_REPO/bin/unix-platform.sh

# usual starters
sudo apt update
sudo apt upgrade -y

# common dependencies of dotfiles scripts
. $DOTFILES_REPO/bin/deps/apt.sh

# zsh
. $DOTFILES_REPO/zsh/bin/apt.sh

# fonts referenced by configs
. $DOTFILES_REPO/bin/fonts/linux.sh


# we're done; remind user we haven't changed the default shell
# becuase that's interactive
echo "🎉 Installation complete"
echo "👉 Use chsh to change the default shell to /bin/zsh if it isn't already"
