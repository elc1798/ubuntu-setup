#!/bin/bash

# Load required source repositories

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

sudo cp -R $DIR/sources.list.d /etc/apt/
sudo cp $DIR/sources.list /etc/apt/sources.list

# Update sources list and run package upgrade

sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get dist-upgrade -y
sudo apt-get autoremove -y
sudo apt-get install -y restricted-extras
sudo -v

# lol nobody actually uses thunderbird right?

sudo apt-get remove --purge thunderbird -y

# Web Browsing

sudo apt-get install -y chromium-browser flashplugin-installer
sudo -v

# Applets

sudo apt-get install -y indicator-cpufreq indicator-multiload diodon psensor
sudo -v

# Programming

sudo apt-get install -y openjdk-7-jdk icedtea-6-plugin git subversion python-dev python3
sudo apt-get install -y vim idle-python2.7 idle-python3.4
sudo apt-get install -y python-software-properties software-properties-common
sudo apt-get install -y python-pip
sudo -v

# Utilities

sudo apt-get install -y tree gparted cpulimit curl xclip preload make
sudo -v

read -p "Install OpenSSH? " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]];
then
    sudo apt-get install openssh-server
fi

read -p "Install Apache Webserver? " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]];
then
    sudo apt-get install apache2
fi

# Cleanup
sudo apt-get autoclean -y
sudo apt-get autoremove -y

# Disable Guest Account
sudo sh -c 'printf "[SeatDefaults]\nallow-guest=false\n" > /usr/share/lightdm/lightdm.conf.d/50-no-guest.conf'
sudo -v

read -p "Install Unity custom GUI? " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]];
then
    # Install Custom GUI
    sudo apt-get install -y docky ubuntu-tweak unity-tweak-tool cheese
    sudo apt-get install -y numix-gtk-theme
    sudo apt-get install -y numix-icon-theme numix-icon-theme-circle
    sudo -v
fi

read -p "Install i3 UI? " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]];
then
    sudo apt-get install -y i3 i3lock
    sudo -v
fi

# Install ZSHELL
sudo apt-get install -y zsh
git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
cp $DIR/zshrc ~/.zshrc

# Install zsh-syntax-highlighting for zsh
cd ~/.oh-my-zsh/custom/plugins
git clone git://github.com/zsh-users/zsh-syntax-highlighting.git
cd ~
sudo -v

# Install VIM configurations
bash $DIR/vim_setup.sh

# Install youtube-dl

sudo curl https://yt-dl.org/downloads/2015.09.03/youtube-dl -o /usr/local/bin/youtube-dl
sudo chmod a+rx /usr/local/bin/youtube-dl
sudo -v

# Check for wget update! Cuz Ubuntu 14 apt is slow to upgrade packages.

echo "Updating 'wget' package to 1.16"
sudo apt-get update
sudo apt-get build-dep wget
cd /tmp
wget http://ftp.gnu.org/gnu/wget/wget-1.16.tar.gz
tar -xvf wget-1.16.tar.gz
cd wget-1.16/
./configure --with-ssl=openssl --prefix=/opt/wget
make
sudo -v
sudo make install
sudo mkdir /opt/wget/WGET_REAL_1_15
sudo mv /usr/bin/wget /opt/wget/WGET_REAL_1_15/wget_1_15
sudo ln -s /opt/wget/bin/wget /usr/bin/wget
sudo -v

# Install Atom with dependencies

sudo apt-get install uncrustify
sudo apt-get install atom
apm install atom-beautify atom-ternjs autocomplete-python file-type-icons
apm install file-types line-ending-converter merge-conflicts pdf-view processing
apm install script monday-syntax language-latex
cp $DIR/uncrustifyrc ~/.uncrustifyrc

# Solar Flare Splash (creds to Plymouth)

read -p "Install custom splash? " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]];
then
    sudo apt-get install plymouth-theme-solar
    sudo update-alternatives --config default.plymouth
    sudo update-initramfs -u
fi

# Install Powerline Globally

pip install --user git+git://github.com/Lokaltog/powerline
wget -q --show-progress https://github.com/Lokaltog/powerline/raw/develop/font/PowerlineSymbols.otf
wget -q --show-progress https://github.com/Lokaltog/powerline/raw/develop/font/10-powerline-symbols.conf
mkdir -p ~/.fonts/ && mv PowerlineSymbols.otf ~/.fonts/
fc-cache -vf ~/.fonts
mkdir -p ~/.config/fontconfig/conf.d/ && mv 10-powerline-symbols.conf ~/.config/fontconfig/conf.d/

cp $DIR/vimrc ~/.vimrc

# Change default shell for user to zsh, kill sudo rights, and exit

chsh -s /bin/zsh $USER
sudo -k
