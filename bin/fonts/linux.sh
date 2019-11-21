##
# prep the user fonts target directory
##

cd /usr/share/fonts
sudo mkdir -p truetype/dotfiles
cd truetype/dotfiles

##
# download some truetype fonts!
##

# Delugia Code NF (Cascadia Code)
assetsUrl=`curl https://api.github.com/repos/adam7/delugia-code/releases/latest | jq -r '.assets_url'`
assetDetails=`curl $assetsUrl | jq '.[] | select(.name | test("Complete")) | { browser_download_url, name }'`

sudo wget -N `echo $assetDetails | jq -r .browser_download_url` -O `echo $assetDetails | jq -r .name`


##
# refresh the user font cache
##

cd ..
fc-cache
