# linux-setup
Minimalist scripts to setup linux with me needs asap

## Dash-to-panel (GNOME Extensions required)
https://github.com/home-sweet-gnome/dash-to-panel

## Wine
$ wget -nc https://dl.winehq.org/wine-builds/winehq.key

$ sudo -H gpg -o /etc/apt/trusted.gpg.d/winehq.key.gpg --dearmor winehq.key

Add the repository.

$ sudo add-apt-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ hirsute main'

Update the package database.

$ sudo apt update

sudo apt install --install-recommends winehq-stable

Verify the installation succeeded
$ wine --version

https://wiki.winehq.org/Winetricks

## Halo CE

Setting up the HEK will not be a goal and instead I want to focus on setting up a good multiplayer experience. This will involve installing CE, updating it, and installing a few popular mods and improvements:

Chimera 1.0: Custom map downloads, FOV and widescreen fixes, server bookmarks, plus other quality of life improvements
CE Refined: multiplayer and campaign maps rebuilt with a tagset which restores the correct Xbox appearance lost during the game's PC port
DXVK: Implements DirectX 9 over Vulkan for increased framerates
Make sure you have your Halo PC product key ready. You'll need it to install CE later. I'll be referencing some Arch linux specifics, but distro shouldn't really matter so just substitute the equivalents from yours.

System requirements
First off, it's a good idea to start with an up-to-date system and take advantage of any bug fixes and optimizations. For Arch, run sudo pacman -Syu. For graphics, I found the best performance and stability running Xorg with the proprietary Nvidia Linux drivers for my 660ti. Following the Arch wiki, I installed:

sudo pacman -S nvidia nvidia-utils nvidia-settings
I found that the nouveau drivers and mesa gave poor framerates compared to the nvidia driver. I also tried using wlroots-based Wayland window managers (like sway and way-cooler) instead of Xorg and experienced lower framerates and frequent crashes requiring restart, so I can't recommend that approach either unless it's otherwise already stable and performant on your system.

Creating a Wine prefix
Next, install Wine and Winetricks. To get ingame sound working, I needed to install some audio libraries too. I don't know if all these libraries are needed since I gathered the list from a few google results, but it doesn't hurt to install them. You could try only installing Wine and Winetricks in this step and seeing if sound works first.

sudo pacman -S wine winetricks openal libpulse alsa-plugins mpg123 alsa-lib
Now configure a Wine prefix. This is a directory where the Windows system and its "C drive" will be installed. A default wine prefix will be used if you don't specify one, but if you want to isolate applications running under Wine it can be helpful to set a prefix by environment variable.

export WINEPREFIX=/home/<you>/wine-prefixes/halo
wineboot
It will be necessary to set this environment variable any time you are running Wine and want to use this prefix (e.g. from a new shell). During wineboot you may be prompted to install Mono and Gecko. You can cancel these since they're not needed (or set WINEDLLOVERRIDES=mscoree=d;mshtml=d to avoid being prompted).

Installing Halo
Download the CE installer (mirror 1, mirror 2) and the official 1.0.10 patch (mirror 1, mirror 2, mirror 3). With the same Wine prefix configured, run:

# needed by Halo's PidGen.dll to generate a product ID from CD key
winetricks mfc42

# if not installed, multiplayer chat messages will not show up ingame
winetricks msxml4

# install and patch the game
wine halocesetup_en_1.00.exe
wine haloce-patch-1.0.10.exe
If for whatever reason the msxml4 installer doesn't work, you can always use Wine to run the installer which ships in Halo's /redist directory.

During the CE installer, you will be asked for your retail product key. You do not need to install Gamespy arcade, install for all users, or create a desktop icon. Don't click "Play Now" just yet; close the installer and move on to patching the game. When that's done, I suggest making a start script for the game to make it easier to run:

#!/bin/bash
export WINEDEBUG=-all
export WINEPREFIX=/home/<you>/wine-prefixes/halo
HALO_HOME="$WINEPREFIX/drive_c/Program Files (x86)/Microsoft Games/Halo Custom Edition"
HALO_OPTS="-console -screenshot"
cd "$HALO_HOME"
nohup wine haloce.exe $HALO_OPTS &
The WINEDEBUG=-all variable noticeably improved performance for me during multiplayer matches with a lot of players. You should also set the $HALO_HOME variable in your shell because you'll need it later during this guide.

Hopefully the game runs, and you're greeted with the menu music if the audio is working correctly. Head to the video settings and bump the resolution up to your native resolution if available and set framerate to "NO VSYNC". Don't worry about vertical tearing or if your native resolution was not an option; we'll use a mod later to address this. It is not recommended to use Halo's -vidmode <width>,<height>,<refresh> argument or built-in Vsync as it introduces input latency.

Halo's video settings menu

While you're in the settings menu, also head over to sound options and set quality to HIGH.

Start a LAN match on Beaver Creek and test the following:

Chat messages are visible (you should see a "welcome <name>" message when you join")
Pick up the active camo powerup and make sure the shader looks correct. If it's just semitransparent rather than refractive, your graphics card is probably not recognized by the game. Obtain its PCI device ID (for Nvidia, shown in nvidia-settings) and add it to the vendor's section of $HALO_HOME/config.txt. More details can be found in OpenCarnage.net's guide
Sounds are working correctly -- if not you may need to make CE recognize your sound card by adding its device ID to the relevant $HALO_HOME/config.txt section. Again, more details here
Bullet decals should appear. Halo doesn't create a decal for the first bullet fired in a game, so fire a couple! If the decals do not appear, double check the decals option in the game's video settings
Grenades should produce particles and weapons should produce muzzle flash. If not, there may be an issue rendering certain transparent shader types. I had this issue, but am unsure of the root cause because a new wine prefix and updated nvidia driver resolved it
Hit Ctrl + F12 to see a framerate counter. The framerate should not be capped at 30 or 60, and on modern hardware it should be in the hundreds
Mouse input feels smooth and responsive. You may need to strike a balance between DPI on your mouse and ingame sensitivity options
The field of view will be too narrow if you are using a widescreen display. No worries, we'll fix that later.

Testing visuals on Beaver Creek

Installing Chimera
Prior to 2020-03-19 This guide previously recommended installing the HAC2 mod for its automatic custom map download feature. Chimera 1.0 now implements this feature, so for a simpler setup I suggest just sticking with Chimera only.

Chimera is a mod which further enhances the Halo client. It is not compatible with HAC2 or OpenSauce. It can be downloaded from the official development thread and replaces the strings.dll file in your Halo CE install directory:

# download and extract Chimera
curl "https://opencarnage.net/applications/core/interface/file/attachment.php?id=1050" --output chimera.7z
7z x chimera.7z
# back up your existing strings DLL
mv "$HALO_HOME/strings.dll" "$HALO_HOME/strings.dll.bak"
# install the Chimera strings DLL
mv strings.dll "$HALO_HOME"
# install chimera's default config
mv chimera.ini "$HALO_HOME"
Chimera now needs to be configured. In short you need to:

Edit the chimera.ini file installed above. This lets you configure Halo's resolution, set up hotkeys, and adjust chat message locations
Issue commands through the ingame console to further configure Chimera. These are saved to ~/My\ Games/Halo\ CE/chimera/preferences.txt if you haven't otherwise configured your wine prefix
The ingame commands are well documented in Chimera's README.md. To change a preference, type the command into the ingame console by pressing the tilde (~) key. Changes should be immediately saved and applied ingame. Some preferences I recommend are:

chimera_block_buffering 1
chimera_block_camera_shake 1
chimera_block_gametype_indicator 1
chimera_block_gametype_rules 1
chimera_block_hold_f1 1
chimera_block_loading_screen 1
chimera_block_zoom_blur 1
chimera_block_mouse_acceleration 1
chimera_fov 90
chimera_auto_center 2
chimera_devmode true
chimera_enable_console 1
chimera_widescreen_fix 1
chimera_af 1
chimera_interpolate 1
chimera_uncap_cinematic true
DXVK
At this point, you may not be satisfied with framerates. Using winetricks to install native d3d9 can improve framerates a bit, but I highly recommend using DXVK to get the best performance. It installs "native" direct X DLLs to your wine prefix which are backed by Vulkan and your graphics drivers rather than wine's built-in D3D-over-OpenGL implementation. DXVK has been specifically tested and patched for Halo CE among other games, so the experience is great.

You will firstly need to update and install your graphics driver and Vulkan ICD loader (32 bit included, even if you're using a 64 bit wine prefix):

sudo pacman -S nvidia nvidia-utils lib32-nvidia-utils nvidia-settings vulkan-icd-loader lib32-vulkan-icd-loader
Next, grab the latest DXVK release, extract its tarball, and run:

# set the wine prefix if it's not already set
export WINEPREFIX=<your halo wine prefix>
./setup_dxvk.sh install
This copies the DXVK d3d DLLs to your prefix's system32 and syswow64 directories. Next, use winecfg to ensure these DLLs are actually being used:

Wine config showing the d3d9 library in native mode

Ensure that d3d9 is in native mode, not built-in. If you have also installed the HEK in this wine prefix, note that Sapien does not yet work under DXVK and you will need to switch to built-in mode when you want to use it.

Refined stock maps
The Halo CE Refined project by Moses, Jesse, and Vaporeon is a rebuild of all stock campaign and multiplayer maps with the refined tagset which faithfully reproduces the classic Xbox visuals and fixes issues introduced in the port to PC by Gearbox. It also includes higher resolution HUD elements. Download the newest versions here:

Refined singleplayer (1.3 GB) (mirror)
Refined multiplayer (37 MB)
Refined UI (820 KB)
Once these archives have been downloaded, extract all .map files to $HALO_HOME/maps. Overwrite or backup the existing multiplayer and UI maps. The refined multiplayer maps above have forged checksums which allows them to be used in multiplayer. The UI map restores the Halo ring shader and adds a singleplayer menu to Custom Edition so you can load the refined SP maps without having to use the console.

Refined Blood Gulch screenshot

Refined Blood Gulch, showing the fixed teleporter shader and high resolution HUD (split screen version)

Refined AotCR mission

Refined Assault on the Control Room mission, showing fixed jackal shield and Assault Rifle shaders.

Downloading custom maps
Custom maps can be downloaded by joining dedicated servers, or by downloading them from popular release sites:

Halomaps.org
Halo CE3
Tweaks
Halo has a built-in lisp-like scripting language which is used in its campaign maps, HEK console, and the ingame console. It supports a huge number of commands for which you can find semi-complete references online. Halo will automatically run any commands present in $HALO_HOME/init.txt at startup, so you can use this to quickly launch into a map or setup preferences. For example, I set multiplayer_hit_sound_volume 1 to increase the volume of the "ping" sound made when damage is dealt in multiplayer.

Unfortunately, enabling MSAA in the nvidia-settings control panel resulted in a black screen for Halo. FXAA worked.

I hope this has been a useful guide for you. If you have any questions or suggestions, please get in touch. See you ingame!