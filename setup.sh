#/bin/bash

# Install utils
sudo apt install luajit wget

# Install gnome
git clone https://github.com/home-sweet-gnome/dash-to-panel
cd dash-to-panel
make install
cd ..
rm -rf dash-to-panel

# Install gnome theme
# Icons: themes/Breeze-Noir-White-Blue.tar.gz
# Cursor: themes/LyraB-cursors.tar.gz
# Shell: Skeuos-Blue-Dark.tar.gz

# Install custom fonts
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
$(which bash) ./fonts.sh

# Install terminal
$(which bash) ./terminal.sh

# Fix lockscreen monitors
sudo cp ~/.config/monitors.xml ~gdm/.config/
