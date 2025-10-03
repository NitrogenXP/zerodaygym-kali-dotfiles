#!/usr/bin/env bash

set -euo pipefail

# Robust installer for the "dark" config collection.
# - Backs up existing dotfiles to ~/.dotfiles_backup_TIMESTAMP
# - Symlinks dotfiles (files in config/ starting with a dot) into $HOME
# - Links config subdirectories into ~/.config
# - Links executables in config/bin to ~/.local/bin
# - Installs packages, fonts and other optional components (same defaults as before)

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles_backup_$(date +%Y%m%d%H%M%S)"

echo "Repository: $REPO_DIR"
echo "Backing up existing dotfiles to: $BACKUP_DIR"
mkdir -p "$BACKUP_DIR"

backup_and_move() {
	local target="$1"
	if [ -e "$target" ] || [ -L "$target" ]; then
		echo "Backing up $target -> $BACKUP_DIR/"
		mv "$target" "$BACKUP_DIR/"
	fi
}

link_file() {
	local src="$1" dst="$2"
	mkdir -p "$(dirname "$dst")"
	backup_and_move "$dst"
	echo "Linking $dst -> $src"
	ln -s "$src" "$dst"
}

link_dir() {
	local src="$1" dst="$2"
	# If dst exists and is not a symlink, back it up and then create symlink
	if [ -e "$dst" ] && [ ! -L "$dst" ]; then
		backup_and_move "$dst"
	fi
	# Remove existing symlink so ln -sfn can replace reliably
	if [ -L "$dst" ]; then
		rm -f "$dst"
	fi
	mkdir -p "$(dirname "$dst")"
	echo "Linking dir $dst -> $src"
	ln -sfn "$src" "$dst"
}

install_packages() {
	echo "Installing apt packages (you may be prompted for sudo)..."
	sudo apt update
	sudo apt install -y \
		arandr flameshot arc-theme feh i3blocks i3status i3 i3-wm lxappearance python3-pip rofi unclutter cargo compton papirus-icon-theme imagemagick \
		libxcb-shape0-dev libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev xcb libxcb1-dev libxcb-icccm4-dev libyajl-dev libev-dev libxcb-xkb-dev libxcb-cursor-dev libxkbcommon-dev libxcb-xinerama0-dev libxkbcommon-x11-dev libstartup-notification0-dev libxcb-randr0-dev libxcb-xrm0 libxcb-xrm-dev autoconf meson \
		libxcb-render-util0-dev libxcb-shape0-dev libxcb-xfixes0-dev terminator mpv wget zsh polybar net-tools kitty
}

install_fonts() {
  echo "Installing nerd fonts to ~/.local/share/fonts..."
  mkdir -p "$HOME/.local/share/fonts"
  mkdir -p "$REPO_DIR/downloads"
  cd "$REPO_DIR/downloads"
  
  # Download fonts if not present
  if [ ! -f Iosevka.zip ]; then
    echo "Downloading Iosevka font..."
    wget -c https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Iosevka.zip || true
  fi
  if [ ! -f RobotoMono.zip ]; then
    echo "Downloading RobotoMono font..."
    wget -c https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/RobotoMono.zip || true
  fi
  
  # Extract fonts
  if [ -f Iosevka.zip ]; then
    echo "Installing Iosevka font..."
    unzip -o Iosevka.zip -d "$HOME/.local/share/fonts/" 2>/dev/null || true
  fi
  if [ -f RobotoMono.zip ]; then
    echo "Installing RobotoMono font..."
    unzip -o RobotoMono.zip -d "$HOME/.local/share/fonts/" 2>/dev/null || true
  fi
  
  echo "Rebuilding font cache..."
  fc-cache -fv || true
}install_alacritty_deb() {
  cd "$REPO_DIR/downloads"
  local deb_file="alacritty_0.10.0-rc4-1_amd64_bullseye.deb"
  
  if [ ! -f "$deb_file" ]; then
    echo "Downloading Alacritty..."
    wget -c https://github.com/barnumbirr/alacritty-debian/releases/download/v0.10.0-rc4-1/alacritty_0.10.0-rc4-1_amd64_bullseye.deb || true
  fi
  
  if [ -f "$deb_file" ]; then
    echo "Installing Alacritty..."
    sudo dpkg -i "$deb_file" || true
    sudo apt install -f -y || true
  else
    echo "Alacritty deb not found, skipping."
  fi
}

install_hack_font() {
  mkdir -p "$HOME/.fonts"
  cd "$REPO_DIR/downloads"
  
  if [ ! -f Hack.zip ]; then
    echo "Downloading Hack font..."
    wget -c https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.3/Hack.zip || true
  fi
  
  if [ -f Hack.zip ]; then
    echo "Installing Hack font..."
    unzip -o Hack.zip -d "$HOME/.fonts/" 2>/dev/null || true
  fi
}install_pywal() {
	echo "Installing pywal via pip..."
	python3 -m pip install --user pywal || sudo python3 -m pip install pywal || true
}

install_i3_gaps() {
	if [ ! -d "$REPO_DIR/i3-gaps" ]; then
		echo "Cloning and building i3-gaps (optional)..."
		git clone https://www.github.com/Airblader/i3 "$REPO_DIR/i3-gaps" || true
	fi
	if [ -d "$REPO_DIR/i3-gaps" ]; then
		(cd "$REPO_DIR/i3-gaps" && mkdir -p build && cd build && meson .. && ninja && sudo ninja install) || true
	fi
}

main() {
	echo "Starting install..."

	# Install packages (comment out if you don't want apt changes)
	install_packages || echo "Package installation finished with some errors (continuing)"

	# Fonts and optional components
	install_fonts || true
	install_alacritty_deb || true
	install_hack_font || true
	install_pywal || true

	# Symlink dotfiles (files in config/ that start with a dot)
	for f in "$REPO_DIR"/config/.*; do
		basename_f="$(basename "$f")"
		# skip . and ..
		if [ "$basename_f" = "." ] || [ "$basename_f" = ".." ]; then
			continue
		fi
		if [ -f "$f" ]; then
			dst="$HOME/$basename_f"
			link_file "$f" "$dst"
		fi
	done

	# Link config directories into ~/.config
	mkdir -p "$HOME/.config"
	for d in "$REPO_DIR"/config/*; do
		if [ -d "$d" ]; then
			name="$(basename "$d")"
			case "$name" in
				bin)
					# link executables into ~/.local/bin
					mkdir -p "$HOME/.local/bin"
					for exe in "$d"/*; do
						if [ -f "$exe" ]; then
							dst="$HOME/.local/bin/$(basename "$exe")"
							backup_and_move "$dst"
							ln -sfn "$exe" "$dst"
							chmod +x "$exe" || true
						fi
					done
					;;
				*)
					dst="$HOME/.config/$name"
					link_dir "$d" "$dst"
					;;
			esac
		fi
	done

	# Special-case files previously handled in the original script
	if [ -f "$REPO_DIR/fehbg" ]; then
		backup_and_move "$HOME/.fehbg"
		ln -sfn "$REPO_DIR/fehbg" "$HOME/.fehbg"
	fi

	if [ -d "$REPO_DIR/wallpaper" ]; then
		backup_and_move "$HOME/.wallpaper"
		ln -sfn "$REPO_DIR/wallpaper" "$HOME/.wallpaper"
	fi

	# Ensure common executable permissions
	if [ -d "$HOME/.config/bin" ]; then
		chmod +x "$HOME/.config/bin"/* || true
	fi
	if [ -f "$HOME/.config/polybar/launch.sh" ]; then
		chmod +x "$HOME/.config/polybar/launch.sh" || true
	fi

	# Optional: install i3-gaps (may take long)
	# install_i3_gaps || true

	# Optional: install nord rofi theme if present
	if command -v wget >/dev/null 2>&1; then
		if [ ! -f /usr/share/rofi/themes/nord.rasi ]; then
			wget -q -O /tmp/nord.rasi https://raw.githubusercontent.com/undiabler/nord-rofi-theme/master/nord.rasi || true
			if [ -f /tmp/nord.rasi ]; then
				sudo mkdir -p /usr/share/rofi/themes
				sudo mv /tmp/nord.rasi /usr/share/rofi/themes/
			fi
		fi
	fi

	echo "Install finished. Backed up replaced files into: $BACKUP_DIR"
	echo "Next steps: log out and select i3 on login, run 'lxappearance' to pick theme if needed. Run 'wal -i <wallpaper>' to apply colors."
}

main "$@"

