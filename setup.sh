#/bin/bash

# Install utils
sudo apt update
sudo apt install -y luajit wget gettext

# Install terminal
$(which bash) ./terminal.sh

# Install custom fonts
$(which bash) ./fonts.sh

# Install software
$(which bash) ./software.sh

# Install theme and icons
$(which bash) ./theme.sh

# Fix lockscreen monitors (not needed anymore in 22.04)
#sudo cp ~/.config/monitors.xml ~gdm/.config/
