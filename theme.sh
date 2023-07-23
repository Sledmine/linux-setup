#/bin/bash

# Install gnome tweaks
sudo apt install gnome-tweaks
git clone https://github.com/home-sweet-gnome/dash-to-panel
cd dash-to-panel
make install
cd ..
rm -rf dash-to-panel

# Install gnome theme
sudo tar -xvf themes/icons/Vimix-Black.tar.xz -C /usr/share/icons
sudo tar -xvf themes/cursor/LyraB-cursors.tar.gz -C /usr/share/icons
sudo tar -xvf themes/shell/Yaru-Blue.tar.xz -C /usr/share/themes

# Set cursor size
gsettings set org.gnome.desktop.interface cursor-size 32
# Disable recent files
gsettings set org.gnome.desktop.privacy remember-recent-files false

# Install gtk theme changer
# Check if lsb_release is 20.04
if [ "$(lsb_release -rs)" = "20.04" ]; then
    sudo apt install lxappearance
    sudo apt install gtk-chtheme
    sudo apt install qt5-style-plugins
    sudo apt install qt5ct # Requires qt5-default in 22.04, so it is not compatible yet
fi
