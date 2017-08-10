apt-get install -y git

apt-get install -y zsh

su vagrant

wget --quiet https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh
wget --quiet https://raw.githubusercontent.com/Bookmark-Novels/Resources/master/Configuration%20Files/.zshrc -O $VAGRANT_HOME/.zshrc
chsh -s /bin/zsh vagrant
zsh
