#/bin/bash

# Install utils
sudo apt update
sudo apt install -y luajit wget gettext

# Install custom fonts
$(which bash) ./fonts.sh

# Install terminal
$(which bash) ./terminal.sh

# Install software
$(which bash) ./software.sh

# Install theme and icons
$(which bash) ./theme.sh

# Fix lockscreen monitors (not needed anymore in 22.04)
if [ "$(lsb_release -rs)" = "20.04" ]; then
    sudo cp ~/.config/monitors.xml ~gdm/.config/
fi
