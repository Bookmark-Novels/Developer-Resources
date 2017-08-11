export ZSH=/home/vagrant/.oh-my-zsh
ZSH_THEME="awesomepanda"

plugins=(git)

source $ZSH/oh-my-zsh.sh

# Check for global config updates.
latest_provision_script=$(curl -s https://raw.githubusercontent.com/Bookmark-Novels/Resources/master/Tools/Scripts/vagrant_bootstrap.sh | md5sum | awk '{print $1}')
local_provision_script=$(cat ~vagrant/.bookmark_global_vagrant)

if [ $latest_provision_script != $local_provision_script]
then
    echo 'Your guest environment was provisioned using an outdated provision script. Please update it by running "vagrant provision" in your host environment.'
fi
