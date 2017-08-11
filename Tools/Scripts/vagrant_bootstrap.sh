apt-get update

apt-get install -y git
apt-get install -y python3-pip
apt-get install -y zsh

if [ ! -d ~vagrant/.oh-my-zsh ]; then
  git clone https://github.com/robbyrussell/oh-my-zsh.git ~vagrant/.oh-my-zsh
fi

chown vagrant: ~vagrant/.zshrc

wget --quiet https://raw.githubusercontent.com/Bookmark-Novels/Resources/master/Configuration%20Files/.zshrc -O ~vagrant/.zshrc
chsh -s /bin/zsh vagrant

latest_provision_script=$(curl -s https://raw.githubusercontent.com/Bookmark-Novels/Resources/master/Tools/Scripts/vagrant_bootstrap.sh | md5sum | awk '{print $1}')
echo $latest_provision_script > ~vagrant/.bookmark_global_vagrant
