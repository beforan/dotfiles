# this is pretty naive but we use it to determine
# if we are on a flavour of Linux
# or macOS (or other FreeBSD, sure)
# and chuck it in the environment
# so other configs can change paths appropriately

# this affects windows less often as cross platform tools
# will usually have different settings for different platforms

platform='unknown'
unamestr=$(uname)
if [ "$unamestr" = 'Linux' ]; then
   platform='linux'
elif [ "$unamestr" = 'FreeBSD' ]; then
   platform='freebsd'
fi

export PLATFORM="$platform"