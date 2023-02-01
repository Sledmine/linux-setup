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
