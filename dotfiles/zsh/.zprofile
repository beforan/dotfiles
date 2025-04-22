# pretend we're bash during login shells
# mainly so we load `/etc/profile.d` as expected
[[ -r /etc/profile ]] && emulate sh -c 'source /etc/profile'
