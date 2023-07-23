# Download latest fonts from NerdFonts
curl -s https://api.github.com/repos/ryanoasis/nerd-fonts/releases/latest \
| grep "browser_download_url.*JetBrainsMono" \
| cut -d : -f 2,3 \
| tr -d \" \
| xargs wget

curl -s https://api.github.com/repos/ryanoasis/nerd-fonts/releases/latest \
| grep "browser_download_url.*Iosevka" \
| cut -d : -f 2,3 \
| tr -d \" \
| xargs wget

# Unzip fonts, install them and refresh cache
unzip -o JetBrainsMono.zip -d ~/.local/share/fonts
unzip -o Iosevka.zip -d ~/.local/share/fonts
sudo fc-cache -fv
rm JetBrainsMono.zip
rm Iosevka.zip
