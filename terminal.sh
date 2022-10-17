#/bin/bash

# Install zsh, oh-my-zsh and powerlevel10k
sudo apt install -y zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
echo 'ZSH_THEME="powerlevel10k/powerlevel10k"' >> ~/.zshrc
chsh -s $(which zsh)

# Install fig
curl -SsL https://pkg.fig.io/install.sh | bash
