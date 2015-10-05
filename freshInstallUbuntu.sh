#!/bin/bash
# Ubuntu Core Updates

sudo apt-add-repository multiverse
sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get dist-upgrade -y && sudo apt-get autoremove -y
sudo apt-get install -y restricted-extras
sudo -v

# Remove crappy packages

sudo apt-get remove --purge -y ttf-arabeyes ttf-arphic-uming ttf-indic-fonts-core ttf-kochi-gothic ttf-kochi-mincho ttf-lao ttf-malayalam-fonts ttf-thai-tlwg ttf-unfonts-core
sudo apt-get remove --purge -y bluez-audio bluez-cups bluez-gnome bluez-utils
sudo apt-get remove --purge -y libgtk-vnc-1.0-0 vinagre vino
sudo apt-get remove --purge -y espeak espeak-data libespeak1 libgnome-speech7
sudo apt-get remove --purge thunderbird -y
sudo apt-get remove --auto-remove -y empathy

# Essential Packages

sudo apt-get update
# Web Browsing
sudo apt-get install -y chromium-browser flashplugin-installer
sudo -v
# Applets
sudo apt-get install -y indicator-cpufreq indicator-multiload diodon psensor
sudo -v
# Network Security
sudo apt-get install -y nmap python-nmap aircrack-ng macchanger macchanger-gtk python-scapy python-qt4 xterm reaver
sudo -v
# Programming
sudo apt-get install -y openjdk-7-jdk icedtea-6-plugin git subversion python-dev libopencv-core2.4 python-opencv python3
sudo -v
sudo apt-get install -y vim eclipse eclipse-cdt guake tmux idle-python2.7 idle-python3.4
sudo -v
# Utilities
sudo apt-get install -y tree gparted cpulimit curl xclip preload make easystroke
sudo -v
# LaTeX
sudo apt-get install texlive-latex-base texlive-fonts-recommended texlive-fonts-extra texlive-latex-extra
sudo -v
# CTF Shite
sudo apt-get install binwalk audacity wireshark
# Other
sudo apt-get install cmus

# Upgrade git
sudo add-apt-repository ppa:git-core/ppa
sudo apt-get update
sudo apt-get install git

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

# Setup Fern Wifi Cracker
clear
mkdir ~/Development
cd ~/Development
svn checkout http://fern-wifi-cracker.googlecode.com/svn/Fern-Wifi-Cracker/

# Get jd-gui
git clone https://github.com/java-decompiler/jd-gui.git
cd ~/Development/jd-gui
sudo add-apt-repository -y ppa:cwchien/gradle
sudo apt-get update
sudo apt-get install -y gradle
gradle build
sudo -v

# Get School Stuff
git clone https://github.com/elc1798/school-notes.git ~/Education

# Install skype
cd /tmp
sudo apt-get install -y sni-qt:i386
sudo dpkg --add-architecture i386
sudo apt-get update
sudo apt-get install -y gdebi
wget download.skype.com/linux/skype-ubuntu-precise_4.3.0.37-1_i386.deb
sudo gdebi skype-ubuntu-precise_4.3.0.37-1_i386.deb
sudo -v

read -p "Install Unity custom GUI? " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]];
then
    # Install Custom GUI
    sudo add-apt-repository ppa:tualatrix/ppa -y
    sudo apt-get update
    sudo apt-get install -y docky ubuntu-tweak unity-tweak-tool cheese
    sudo add-apt-repository -y ppa:ravefinity-project/ppa
    sudo -v
    sudo apt-get update
    sudo apt-get install -y ravefinity-x-icons
    sudo add-apt-repository -y ppa:numix/ppa
    sudo -v
    sudo apt-get update
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
ln -s ~/Education/DOTFILES/.zshrc-linux-base ~/.zshrc
ln -s ~/Education/DOTFILES/photonixshort.zsh-theme ~/.oh-my-zsh/themes/
echo "Please chsh -s /bin/zsh :)"
sudo -v

# Install zsh-syntax-highlighting for zsh
cd ~/.oh-my-zsh/custom/plugins
git clone git://github.com/zsh-users/zsh-syntax-highlighting.git
cd ~
sudo -v

# Install VIM configurations
bash ~/Education/DOTFILES/vim_setup.sh

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
sudo add-apt-repository ppa:webupd8team/atom
sudo apt-get update
sudo apt-get install atom
apm install atom-beautify atom-ternjs autocomplete-python file-type-icons
apm install file-types line-ending-converter merge-conflicts pdf-view processing
apm install script monday-syntax language-latex
ln -s ~/Education/DOTFILES/.uncrustifyrc ~/.uncrustifyrc

# Get HTML homepage for webbrowsers

git clone https://github.com/elc1798/html-homepage.git ~/Development/html-homepage

# Set Backgrounds

sudo -v
sudo mkdir /opt/elc1798
sudo cp -R ~/Education/BACKGROUNDS /opt/elc1798/background-loader
sudo gsettings set org.gnome.desktop.background picture-uri 'file:///opt/elc1798/background-loader/universal.xml'
gsettings set org.gnome.desktop.background picture-uri 'file:///opt/elc1798/background-loader/universal.xml'

# Solar Flare Splash (creds to Plymouth)

read -p "Install custom splash? " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]];
then
    sudo apt-get install plymouth-theme-solar
    sudo update-alternatives --config default.plymouth
    sudo update-initramfs -u
fi

# Install ruby

sh ~/Education/DOTFILES/ruby_setup.sh

# Update tmux

sudo apt-get install python-pip
sudo apt-get install -y python-software-properties software-properties-common
sudo add-apt-repository -y ppa:pi-rho/dev
sudo apt-get update
sudo apt-get install tmux

# Install Powerline Globally

pip install --user git+git://github.com/Lokaltog/powerline
wget -q --show-progress https://github.com/Lokaltog/powerline/raw/develop/font/PowerlineSymbols.otf
wget -q --show-progress https://github.com/Lokaltog/powerline/raw/develop/font/10-powerline-symbols.conf
mkdir -p ~/.fonts/ && mv PowerlineSymbols.otf ~/.fonts/
fc-cache -vf ~/.fonts
mkdir -p ~/.config/fontconfig/conf.d/ && mv 10-powerline-symbols.conf ~/.config/fontconfig/conf.d/

ln -s ~/Education/DOTFILES/.tmux.conf ~/.tmux.conf
ln -s ~/Education/DOTFILES/.vimrc ~/.vimrc

# Remove sudo rights and exit

sudo -k
