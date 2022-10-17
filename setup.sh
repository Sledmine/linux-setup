#/bin/bash

# Install utils
sudo apt install -y luajit wget gettext

# Install gnome tweaks
#sudo apt install gnome-session gdm3
sudo apt install gnome-tweaks
git clone https://github.com/home-sweet-gnome/dash-to-panel
cd dash-to-panel
make install
cd ..
rm -rf dash-to-panel

# Install custom fonts
$(which bash) ./fonts.sh

# Install terminal
$(which bash) ./terminal.sh

# Fix lockscreen monitors
sudo cp ~/.config/monitors.xml ~gdm/.config/
