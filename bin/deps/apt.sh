# we don't install git because to get the repo you'd need it already

# ensure we have a load of common stuff that might be missing
# e.g. from WSL distros as they tend to be very lean

# curl and wget
sudo apt install curl wget -y

# fontconfig to ensure we can install fonts
sudo apt install fontconfig -y

# jq, so we can perform shenanigans with API's such as GitHub
sudo apt install jq -y