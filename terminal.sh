#/bin/bash

# Install zsh, oh-my-zsh and powerlevel10k
sudo apt install -y zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
#echo "ZSH_THEME=\"powerlevel10k/powerlevel10k\"" >> ~/.zshrc
echo "Do not forget to set ZSH_THEME=\"powerlevel10k/powerlevel10k\" in ~/.zshrc"

# Install zsh-autocomplete
# https://github.com/marlonrichert/zsh-autocomplete

# Install exa (ls replacement)
# https://the.exa.website/
# Check if lsb_release is 20.04
if [ "$(lsb_release -rs)" = "20.04" ]; then
    curl -L https://github.com/ogham/exa/releases/download/v0.10.0/exa-linux-x86_64-v0.10.0.zip -o exa.zip
    unzip exa.zip -d exa
    sudo install exa/bin/exa /usr/local/bin
    rm -rf exa.zip exa
else
    sudo apt install -y exa
fi

# Install vs code nautilus extension (right click open with code)
wget -qO- https://raw.githubusercontent.com/harry-cpp/code-nautilus/master/install.sh | bash
