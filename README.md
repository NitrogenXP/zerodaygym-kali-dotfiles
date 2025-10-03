# Dark Theme i3-gaps Configuration

*The install script and the Readme files were generated using the help of Github Copilot AI.*

A comprehensive i3-gaps desktop environment setup with dark theme configurations, custom scripts, and optimized dotfiles for Debian-based systems.

## Overview

This repository contains a complete desktop environment configuration featuring:

- i3-gaps window manager with custom configuration
- Polybar status bar with custom modules
- Rofi application launcher with Nord theme
- Alacritty and Kitty terminal configurations
- Custom shell configurations (bash, zsh, tmux)
- pywal integration for dynamic color schemes
- Custom scripts for system management
- Carefully curated wallpaper collection

## Features

- Automated installation with backup of existing configurations
- Symlinked dotfiles for easy updates and version control
- Complete package installation including dependencies
- Nerd Fonts integration (Iosevka, RobotoMono, Hack)
- Compton compositor for transparency and effects
- Pre-configured terminal environments
- Custom keyboard shortcuts and workspace management

## Prerequisites

- Debian-based Linux distribution (Debian, Ubuntu, Kali Linux, etc.)
- Sudo privileges for package installation
- Internet connection for downloading packages and fonts
- At least 500MB free disk space

## Installation

### Quick Install

Clone this repository and run the installation script:

```bash
git clone https://github.com/d3m0nrul3s/dark.git
cd dark
chmod +x install.sh
./install.sh
```

### What the Installer Does

The installation script performs the following operations:

1. **Backup**: Creates a timestamped backup of existing dotfiles in `~/.dotfiles_backup_YYYYMMDDHHMMSS`
2. **Package Installation**: Installs required packages via apt (i3-gaps, polybar, rofi, terminal emulators, etc.)
3. **Font Installation**: Downloads and installs Nerd Fonts to `~/.local/share/fonts`
4. **Symlink Creation**: Creates symbolic links for all configuration files and directories
5. **Permissions**: Sets executable permissions on scripts and binaries
6. **Optional Components**: Installs pywal, Alacritty, and other optional tools

### Manual Installation

If you prefer to install components individually:

```bash
# Install packages only
sudo apt update
sudo apt install -y i3-gaps polybar rofi alacritty kitty terminator feh compton

# Link specific configurations
mkdir -p ~/.config
ln -sf $(pwd)/config/i3 ~/.config/i3
ln -sf $(pwd)/config/polybar ~/.config/polybar
ln -sf $(pwd)/config/rofi ~/.config/rofi

# Link dotfiles
ln -sf $(pwd)/config/.bashrc ~/.bashrc
ln -sf $(pwd)/config/.tmux.conf ~/.tmux.conf
```

## Configuration Structure

```
dark/
├── config/              # Configuration files
│   ├── .bashrc          # Bash shell configuration
│   ├── .tmux.conf       # Tmux terminal multiplexer config
│   ├── alacritty/       # Alacritty terminal config
│   ├── bin/             # Custom executable scripts
│   ├── compton/         # Compton compositor config
│   ├── i3/              # i3-gaps window manager config
│   ├── kitty/           # Kitty terminal config
│   ├── polybar/         # Polybar status bar config
│   ├── rofi/            # Rofi launcher config
│   └── terminator/      # Terminator terminal config
├── downloads/           # Downloaded packages and fonts
├── wallpaper/           # Wallpaper collection
├── fehbg                # Wallpaper setter script
└── install.sh           # Main installation script
```

## Post-Installation

### First Login

1. Log out of your current session
2. At the login screen, select "i3" as your session type
3. Log in with your credentials
4. On first launch, press Enter to generate the default i3 config (or press Escape to keep the installed config)

### Setting Up Appearance

```bash
# Set your wallpaper and generate color scheme
wal -i ~/.wallpaper/your-chosen-wallpaper.jpg

# Configure GTK theme
lxappearance
# In the appearance settings, select "Arc-Dark" theme

# Reload i3 configuration
# Press Mod+Shift+R (default: Windows+Shift+R)
```

### Customization

#### Keyboard Shortcuts

The default modifier key is set to the Windows/Super key. Common shortcuts:

- `Mod+Enter`: Open terminal
- `Mod+D`: Open Rofi launcher
- `Mod+Shift+Q`: Close focused window
- `Mod+1-9`: Switch to workspace 1-9
- `Mod+Shift+1-9`: Move window to workspace 1-9
- `Mod+Shift+R`: Reload i3 configuration
- `Mod+Shift+E`: Exit i3

#### Modifying Configurations

All configuration files are symlinked. To modify:

```bash
# Edit configurations in the repository
cd ~/path/to/dark
vim config/i3/config

# Changes are immediately reflected in ~/.config/i3/config
# Reload i3 to apply changes (Mod+Shift+R)
```

#### Adding Custom Scripts

Place executable scripts in `config/bin/`:

```bash
# Scripts will be automatically linked to ~/.local/bin
cp your-script.sh config/bin/
chmod +x config/bin/your-script.sh
```

## Installed Packages

The installer includes the following packages:

**Core Window Manager:**
- i3-gaps, i3-wm, i3blocks, i3status

**Applications:**
- rofi (application launcher)
- polybar (status bar)
- compton (compositor)
- feh (wallpaper setter)
- flameshot (screenshot tool)
- arandr (display manager)

**Terminals:**
- alacritty
- kitty
- terminator

**Themes and Fonts:**
- arc-theme
- papirus-icon-theme
- Nerd Fonts (Iosevka, RobotoMono, Hack)

**Development Tools:**
- python3-pip
- cargo (Rust package manager)
- meson, autoconf (build tools)

**Utilities:**
- lxappearance (theme configuration)
- pywal (color scheme generator)
- imagemagick, mpv, wget, unclutter

## Custom Scripts

Scripts available in `~/.local/bin` (or `~/.config/bin`):

- `eth.sh`: Ethernet connection helper
- `htb.sh`: HackTheBox VPN manager
- `htb_target.sh`: HackTheBox target manager
- `usb.sh`: USB device manager
- `target`: Target IP management

## Troubleshooting

### i3 Won't Start

Check the i3 log file:
```bash
cat ~/.local/share/i3/i3log
```

### Polybar Not Showing

Ensure the launch script is executable and running:
```bash
chmod +x ~/.config/polybar/launch.sh
~/.config/polybar/launch.sh
```

### Fonts Not Displaying Correctly

Rebuild the font cache:
```bash
fc-cache -fv
```

### Restoring Original Configuration

Your original dotfiles are backed up in `~/.dotfiles_backup_YYYYMMDDHHMMSS`:
```bash
# List backups
ls -la ~ | grep dotfiles_backup

# Restore from backup
cp -r ~/.dotfiles_backup_YYYYMMDDHHMMSS/.* ~/
```

## Uninstallation

To remove the configuration:

```bash
# Remove symlinks
rm ~/.config/i3
rm ~/.config/polybar
rm ~/.config/rofi
rm ~/.bashrc
rm ~/.tmux.conf
# ... (remove other symlinks as needed)

# Restore from backup
cp -r ~/.dotfiles_backup_YYYYMMDDHHMMSS/.* ~/
```

## Dependencies

The installer will automatically handle dependencies. For manual builds:

**i3-gaps build dependencies:**
- libxcb development libraries
- xcb, libxcb-icccm4-dev, libyajl-dev, libev-dev
- libxcb-xkb-dev, libxcb-cursor-dev, libxkbcommon-dev
- libpango1.0-dev, libstartup-notification0-dev
- meson, ninja-build

## Contributing

Contributions are welcome. Please ensure:
- Configurations are well-documented
- Scripts include usage comments
- Changes maintain compatibility with Debian-based systems

## License

This configuration is provided as-is for personal use and modification.

## Credits

- i3-gaps: https://github.com/Airblader/i3
- Polybar: https://github.com/polybar/polybar
- pywal: https://github.com/dylanaraps/pywal
- Nord Rofi Theme: https://github.com/undiabler/nord-rofi-theme
- Nerd Fonts: https://github.com/ryanoasis/nerd-fonts

## Support

For issues or questions:
- Check the troubleshooting section above
- Review i3 documentation: https://i3wm.org/docs/
- Check configuration files for inline comments
