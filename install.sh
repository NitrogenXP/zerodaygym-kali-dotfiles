#!/bin/bash

# Get the actual user running the script (not root)
if [ -n "$SUDO_USER" ]; then
    ACTUAL_USER=$SUDO_USER
    USER_HOME=$(getent passwd "$SUDO_USER" | cut -d: -f6)
else
    ACTUAL_USER=$USER
    USER_HOME=$HOME
fi

#sudo apt update && sudo apt upgrade -y

apt update
apt-get install -y arandr flameshot arc-theme feh i3blocks i3status i3 i3-wm lxappearance python3-pip rofi unclutter cargo compton papirus-icon-theme imagemagick
apt-get install -y libxcb-shape0-dev libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev xcb libxcb1-dev libxcb-icccm4-dev libyajl-dev libev-dev libxcb-xkb-dev libxcb-cursor-dev libxkbcommon-dev libxcb-xinerama0-dev libxkbcommon-x11-dev libstartup-notification0-dev libxcb-randr0-dev libxcb-xrm0 libxcb-xrm-dev autoconf meson
apt-get install -y libxcb-render-util0-dev libxcb-shape0-dev libxcb-xfixes0-dev terminator mpv wget zsh polybar net-tools kitty tmux xclip meson ninja-build pkg-config
apt install -y gnome-terminal copyq neovim dconf-cli libstartup-notification0-dev libxcb-xkb-dev libxcb-xkb-dev libxcb-randr0-dev libxcb-util-dev 
sudo apt install -y \
  build-essential meson pkg-config \
  libstartup-notification0-dev \
  libxcb1-dev libxcb-util-dev libxcb-xkb-dev libxcb-xinerama0-dev \
  libxcb-randr0-dev libxcb-shape0-dev libxcb-cursor-dev libxcb-keysyms1-dev \
  libxcb-icccm4-dev libxcb-xrm-dev libxkbcommon-dev libxkbcommon-x11-dev \
  libyajl-dev libpcre2-dev libcairo2-dev libpango1.0-dev libglib2.0-dev \
  libev-dev xterm



# Install uv for Python package management
sudo -u $ACTUAL_USER bash -c 'curl -LsSf https://astral.sh/uv/install.sh | sh'

dconf load /org/gnome/terminal/ < ./config/gnome_terminal_settings_backup.txt
mkdir -p $USER_HOME/.local/share/fonts/

wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Iosevka.zip
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/RobotoMono.zip

unzip Iosevka.zip -d $USER_HOME/.local/share/fonts/
unzip RobotoMono.zip -d $USER_HOME/.local/share/fonts/

fc-cache -fv
cp ./config/.bashrc $USER_HOME/.bashrc
cp ./config/.tmux.conf $USER_HOME/.tmux.conf

# Install TPM (Tmux Plugin Manager)
sudo -u $ACTUAL_USER git clone https://github.com/tmux-plugins/tpm $USER_HOME/.tmux/plugins/tpm

# Install tmux-themepack
sudo -u $ACTUAL_USER git clone https://github.com/jimeh/tmux-themepack.git $USER_HOME/.tmux-themepack

wget https://github.com/barnumbirr/alacritty-debian/releases/download/v0.10.0-rc4-1/alacritty_0.10.0-rc4-1_amd64_bullseye.deb
sudo dpkg -i alacritty_0.10.0-rc4-1_amd64_bullseye.deb
sudo apt install -f

mkdir $USER_HOME/.fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.3/Hack.zip
unzip Hack.zip -d $USER_HOME/.fonts/

# Clean up existing i3-gaps directory if it exists
rm -rf i3-gaps

git clone https://www.github.com/Airblader/i3 i3-gaps
cd i3-gaps && mkdir -p build && cd build && meson setup ..
ninja
sudo ninja install
cd ../..

# Install pywal using uv
sudo -u $ACTUAL_USER $USER_HOME/.cargo/bin/uv pip install --system pywal

mkdir -p $USER_HOME/.config/i3
mkdir -p $USER_HOME/.config/compton
mkdir -p $USER_HOME/.config/rofi
mkdir -p $USER_HOME/.config/alacritty
mkdir -p $USER_HOME/.config/polybar
mkdir -p $USER_HOME/.config/terminator


cp -r config/nvim $USER_HOME/.config/
cp -r config/kitty $USER_HOME/.config/
cp config/terminator/config $USER_HOME/.config/terminator/
cp config/polybar/* $USER_HOME/.config/polybar/
cp -r config/bin $USER_HOME/.config/
cp config/i3/config $USER_HOME/.config/i3/config
cp config/alacritty/alacritty.yml $USER_HOME/.config/alacritty/alacritty.yml
cp config/i3/i3blocks.conf $USER_HOME/.config/i3/i3blocks.conf
cp config/compton/compton.conf $USER_HOME/.config/compton/compton.conf
cp config/rofi/config $USER_HOME/.config/rofi/config
cp fehbg $USER_HOME/.fehbg
cp config/i3/clipboard_fix.sh $USER_HOME/.config/i3/clipboard_fix.sh
cp -r wallpaper $USER_HOME/.wallpaper

chmod +x $USER_HOME/.config/bin/*
chmod +x $USER_HOME/.config/polybar/launch.sh

# Fix ownership of all copied files
chown -R $ACTUAL_USER:$ACTUAL_USER $USER_HOME/.config
chown -R $ACTUAL_USER:$ACTUAL_USER $USER_HOME/.local
chown -R $ACTUAL_USER:$ACTUAL_USER $USER_HOME/.fonts
chown -R $ACTUAL_USER:$ACTUAL_USER $USER_HOME/.tmux
chown -R $ACTUAL_USER:$ACTUAL_USER $USER_HOME/.tmux-themepack
chown -R $ACTUAL_USER:$ACTUAL_USER $USER_HOME/.wallpaper
chown $ACTUAL_USER:$ACTUAL_USER $USER_HOME/.bashrc
chown $ACTUAL_USER:$ACTUAL_USER $USER_HOME/.tmux.conf
chown $ACTUAL_USER:$ACTUAL_USER $USER_HOME/.fehbg

wget https://raw.githubusercontent.com/undiabler/nord-rofi-theme/master/nord.rasi
mv nord.rasi /usr/share/rofi/themes/
#echo "Done! Grab some wallpaper and run pywal -i filename to set your color scheme. To have the wallpaper set on every boot edit ~.fehbg"
#echo "After reboot: Select i3 on login, run lxappearance and select arc-dark"
dconf load /org/gnome/terminal/ < ./config/gnome_terminal_settings_backup.txt