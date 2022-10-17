#/bin/bash

# Install Notion (notes application)
echo "deb [trusted=yes] https://apt.fury.io/notion-repackaged/ /" | sudo tee /etc/apt/sources.list.d/notion-repackaged.list
sudo apt update
sudo apt install notion-app-enhanced

# Install Google Chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
rm google-chrome-stable_current_amd64.deb

# Install Noise Torch (open source noise reduction)
curl -s https://api.github.com/repos/noisetorch/NoiseTorch/releases/latest \
| grep "browser_download_url.*NoiseTorch_x64" \
| cut -d : -f 2,3 \
| tr -d \" \
| xargs wget
tar -C $HOME -h -xzf NoiseTorch_x64_v0.12.2.tgz
# Allow noisetorch to capture system resources
sudo setcap 'CAP_SYS_RESOURCE=+ep' ~/.local/bin/noisetorch
