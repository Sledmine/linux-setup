#/bin/bash

# Install gnome theme
sudo tar -xvf themes/icons/Breeze-Noir-White-Blue.tar.gz -C /usr/share/icons
sudo tar -xvf themes/cursor/LyraB-cursors.tar.gz -C /usr/share/icons
sudo tar -xvf themes/shell/Skeuos-Blue-Dark.tar.gz -C /usr/share/themes

# Set cursor size
gsettings set org.gnome.desktop.interface cursor-size 32
