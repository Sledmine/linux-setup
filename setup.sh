#/bin/bash

# Install utils
sudo apt install -y luajit wget gettext

# Install theme and icons
$(which bash) ./theme.sh

# Install software
$(which bash) ./software.sh

# Install custom fonts
$(which bash) ./fonts.sh

# Install terminal
$(which bash) ./terminal.sh

# Fix lockscreen monitors (not needed anymore in 22.04)
#sudo cp ~/.config/monitors.xml ~gdm/.config/
