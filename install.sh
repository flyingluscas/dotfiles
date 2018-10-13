#!/bin/bash

# Get dotfiles installation directory
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Install YAY
if [[ ! -f /usr/bin/yay ]]; then
  echo "Installing YAY..."
  git clone https://aur.archlinux.org/yay.git ~/yay
  cd ~/yay
  makepkg -si --noconfirm
  cd ~
  rm -Rf ~/yay
fi

# Install Docker
if [[ ! -f /usr/bin/docker ]]; then
  echo "Installing Docker..."
  sudo pacman -S --noconfirm docker
  sudo usermod -aG docker $USER
fi

# Install Docker Compose
if [[ ! -f /usr/bin/docker-compose ]]; then
  echo "Installing Docker Compose..."
  sudo pacman -S --noconfirm docker-compose
fi

# Install Fonts
echo "Installing fonts..."
sudo pacman -S --noconfirm \
  ttf-roboto \
  ttf-liberation \
  ttf-ubuntu-font-family \
  ttf-fira-mono \
  otf-fira-mono \
  ttf-inconsolata \
  adobe-source-code-pro-fonts \
  ttf-linux-libertine \
  adobe-source-sans-pro-fonts \
  noto-fonts-emoji

# Install Emoji Fonts
yay -S --noconfirm \
  ttf-symbola \
  ttf-emojione \
  ttf-emojione-color \
  ttf-twemoji-color
