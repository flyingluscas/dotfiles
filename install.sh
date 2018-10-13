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

# Install VLC
if [[ ! -f /usr/bin/vlc ]]; then
  echo "Installing VLC..."
  sudo pacman -S --noconfirm vlc
fi

# Install Steam
if [[ ! -f /usr/bin/steam ]]; then
  echo "Installing Steam..."
  sudo pacman -S --noconfirm steam
  yay -S --noconfirm steam-fonts
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

# Install ZSH
if [[ ! -f /usr/bin/zsh ]]; then
  echo 'Installing ZSH...'
  sudo pacman -S --noconfirm zsh
fi

# Install Oh My ZSH
if [[ ! -d ~/.oh-my-zsh ]]; then
  echo 'Installing Oh My ZSH...'
  sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

# Install ZSH Spaceship Theme
ZSH_CUSTOM=$HOME/.oh-my-zsh/custom

if [[ ! -d $ZSH_CUSTOM/themes/spaceship-prompt ]]; then
  echo "Installing Spaceship ZSH Theme..."
  git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt"
  ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
fi

# Create Symlinks
ln -sf "$DOTFILES_DIR/.gitconfig" ~
ln -sf "$DOTFILES_DIR/.gitignore_global" ~
ln -sf "$DOTFILES_DIR/.zshrc" ~
ln -sf "$DOTFILES_DIR/.exports" ~
ln -sf "$DOTFILES_DIR/.aliases" ~
ln -sf "$DOTFILES_DIR/.functions" ~
