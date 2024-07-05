#! /usr/bin/bash

create_symlink() {
    local src=$1
    local target=$2

	ln -s "$(pwd)/${src}" "${target}"
}

mkdir temp
mkdir ~/.icons
mkdir ~/.fonts

# Base dependencies
sudo apt install -y \
	cmake \
	curl \
	cargo \
	git

# Picom Dependencies
sudo apt install -y \
	libconfig-dev \
	libdbus-1-dev \
	libegl-dev \
	libev-dev \
	libgl-dev \
	libepoxy-dev \
	libpcre2-dev \
	libpixman-1-dev \
	libx11-xcb-dev \
	libxcb1-dev \
	libxcb-composite0-dev \
	libxcb-damage0-dev \
	libxcb-glx0-dev \
	libxcb-image0-dev \
	libxcb-present-dev \
	libxcb-randr0-dev \
	libxcb-render0-dev \
	libxcb-render-util0-dev \
	libxcb-shape0-dev \
	libxcb-util-dev \
	libxcb-xfixes0-dev \
	meson \
	ninja-build \
	uthash-dev

# qtile dependencies
sudo apt install -y \
	xserver-xorg \
	xinit \
	libpangocairo-1.0-0 \
	python3-pip \
	python3-xcffib \
	python3-cairocffi

# i3lock-color dependencies
sudo apt install -y \
	autoconf \
	gcc \
	make \
	pkg-config \
	libpam0g-dev \
	libcairo2-dev \
	libfontconfig1-dev \
	libxcb-xkb-dev \
	libxcb-xinerama0-dev \
	libxcb-xrm-dev \
	libxkbcommon-dev \
	libxkbcommon-x11-dev \
	libjpeg-dev

# Tools
sudo apt install -y \
	lxappearance \
	arandr \
	rofi \
	feh

# Install kitty
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
create_symlink ~/.local/kitty.app/bin/kitty ~/.local/bin/kitty

# Install neovim
cargo install bob-nvim
bob install stable

# Install picom
(
	cd temp
	git clone git@github.com:yshui/picom.git
	cd picom
	meson setup --buildtype=release build
	ninja -C build
	ninja -C build install
	cd ..
	rm -r *
)

# Install qtile
pip install qtile

# Install i3lock-color
(
	cd temp
	git clone git@github.com:Raymo111/i3lock-color.git
	cd i3lock-color
	./install-i3lock-color.sh
	cd ..
)

# Install ohmyzsh
sudo apt install -y zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Catpuccin cursors
cursor_flavor="mocha"
cursor_color="yellow"
file_name="catppuccin-${cursor_flavor}-${cursor_color}-cursors.zip"
(
	cd ~/.icons
	curl -LOsS https://github.com/catppuccin/cursors/releases/download/v0.3.1/${file_name}
	unzip ${file_name}
)

# Create symlinks
create_symlink kitty ~/.config/kitty
create_symlink nvim ~/.config/nvim
create_symlink picom ~/.config/picom
create_symlink qtile ~/.config/qtile
create_symlink i3lock ~/.config/i3lock
create_symlink .screenlayout ~/.screenlayout
create_symlink .zshrc ~/.zshrc

# Cleanup
rm -r temp
