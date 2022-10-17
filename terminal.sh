#/bin/bash

# Install zsh and powerlevel10k
sudo apt install zsh
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
echo 'ZSH_THEME="powerlevel10k/powerlevel10k"' >> ~/.zshrc

# Install fig
curl -SsL https://pkg.fig.io/install.sh | bash