# Utils
sudo apt install luajit wget

# Get gnome
sudo apt install gnome-session gdm3
sudo apt install gnome-tweak-tool
git clone https://github.com/home-sweet-gnome/dash-to-panel
cd dash-to-panel
make install
cd ..
rm -rf dash-to-panel
# Fix lockscreen monitors
sudo cp ~/.config/monitors.xml ~gdm/.config/

# TODO Install gnome theme
# Icons: themes/Breeze-Noir-White-Blue.tar.gz
# Cursor: themes/LyraB-cursors.tar.gz
# Shell: Skeuos-Blue-Dark.tar.gz

# Install zsh, custom fonts
$(which bash) ./fonts.sh

# Wine
wget -nc https://dl.winehq.org/wine-builds/winehq.key
sudo -H gpg -o /etc/apt/trusted.gpg.d/winehq.key.gpg --dearmor winehq.key
sudo add-apt-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ focal main'
sudo apt update
sudo apt install --install-recommends winehq-stable

# TODO Download Halo Custom Edition from "somewhere"
# Halo CE
#winetricks mfc42
#wine halocesetup_en_1.00.exe
#wine haloce-patch-1.0.10.exe
