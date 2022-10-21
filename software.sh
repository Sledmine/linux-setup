#/bin/bash

# Install Notion (notes application)
echo "deb [trusted=yes] https://apt.fury.io/notion-repackaged/ /" | sudo tee /etc/apt/sources.list.d/notion-repackaged.list
sudo apt update
sudo apt install -y notion-app-enhanced

# Install Google Chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
rm google-chrome-stable_current_amd64.deb

# Install Noise Torch (open source noise reduction)
curl -s https://api.github.com/repos/noisetorch/NoiseTorch/releases/latest \
| grep "browser_download_url.*.tgz\"" \
| cut -d : -f 2,3 \
| tr -d \" \
| xargs wget -O noisetorch.tgz
tar -C $HOME -h -xzf noisetorch.tgz
rm noisetorch.tgz
# Allow noisetorch to capture system resources
sudo setcap 'CAP_SYS_RESOURCE=+ep' ~/.local/bin/noisetorch
https://packages.microsoft.com/repos/ms-teams/pool/main/t/teams/teams_1.5.00.23861_amd64.deb

# Install Teams
curl -s https://packages.microsoft.com/repos/ms-teams/pool/main/t/teams/ \
| grep -o "teams.*.deb\"" \
| tail -1 \
| tr -d \" \
| xargs printf "https://packages.microsoft.com/repos/ms-teams/pool/main/t/teams/%s" \
| xargs wget -O teams.deb
sudo dpkg -i teams.deb
rm teams.deb
