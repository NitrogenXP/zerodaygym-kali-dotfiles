# ZeroDayGym Kali linux dotfiles

<img width="1910" height="1079" alt="image" src="https://github.com/user-attachments/assets/bfedf358-4d49-4d39-a1e2-91954710ca39" />
<img width="1915" height="1079" alt="image" src="https://github.com/user-attachments/assets/3226d84d-d74f-4d88-8b56-1c808690603d" />

*The README file was generated using the help of a GitHub Copilot AI* 

A custom i3-gaps desktop environment setup for Kali Linux with polybar, custom scripts, and themed configurations.

## Features

- i3-gaps window manager
- Polybar status bar with custom modules (HTB VPN, USB, Ethernet, Target info)
- Custom rofi launcher with Nord theme
- Multiple terminal options (Alacritty, Kitty, Terminator, Gnome Terminal)
- Tmux configuration with clipboard integration
- Custom scripts for network monitoring and target tracking
- Pywal color scheme support

## Installation

```bash
sudo chmod +x install.sh
sudo ./install.sh
```

After installation:
1. Reboot your system
2. Select **i3** at the login screen
3. Launch tmux and press `Ctrl+b` then `Shift+i` to install tmux plugins
4. Run `lxappearance` and select **Arc-Dark** theme
5. Set your wallpaper: `pywal -i /path/to/wallpaper`

## Custom Scripts

- `~/.config/bin/htb.sh` - HTB VPN status (tun0)
- `~/.config/bin/eth.sh` - Ethernet status
- `~/.config/bin/usb.sh` - USB network status
- `~/.config/bin/htb_target.sh` - Display current target (edit `~/.config/bin/target`)

## Usage

Edit `~/.config/bin/target` to set your current target:
