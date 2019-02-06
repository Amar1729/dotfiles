# Amar Paul's .profile

# Everything moved to either .bashrc or .bash_profile after switch to zsh
export PATH="$PATH:/opt/bin/"

# add snap path on ubuntu
[[ -d /snap/bin ]] && emulate sh -c 'source /etc/profile.d/apps-bin-path.sh'
