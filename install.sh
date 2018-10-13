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

# Install Gnome Tweak Tool
if [[ ! -f /usr/bin/gnome-tweaks ]]; then
  echo "Installing Gnome Tweak Tool..."
  sudo pacman -S --noconfirm gnome-tweak-tool
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

# Install Tilix
if [[ ! -f /usr/bin/tilix ]]; then
  echo "Installing Tilix..."
  sudo pacman -S --noconfirm tilix
fi

# Install VLC
if [[ ! -f /usr/bin/vlc ]]; then
  echo "Installing VLC..."
  sudo pacman -S --noconfirm vlc
fi

# Install Webtorrent Deskop
if [[ ! -f /usr/bin/webtorrent-desktop ]]; then
  echo "Installing Webtorrent Deskop..."
  yay -S --noconfirm webtorrent-desktop
fi

# Install Steam
if [[ ! -f /usr/bin/steam ]]; then
  echo "Installing Steam..."
  sudo pacman -S --noconfirm steam
  yay -S --noconfirm steam-fonts
fi

# Install Dropbox
if [[ ! -f /usr/bin/dropbox ]]; then
  echo "Installing Dropbox..."
  sudo pacman -S --noconfirm dropbox
fi

# Install Sublime Text
if [[ ! -f /usr/bin/subl ]]; then
  echo "Installing Sublime Text..."
  curl -O https://download.sublimetext.com/sublimehq-pub.gpg
  sudo pacman-key --add sublimehq-pub.gpg
  sudo pacman-key --lsign-key 8A8F901A
  rm sublimehq-pub.gpg
  echo -e "\n[sublime-text]\nServer = https://download.sublimetext.com/arch/stable/x86_64" | sudo tee -a /etc/pacman.conf
  sudo pacman -Syu --noconfirm sublime-text
  cd ~/.config/sublime-text-3/Packages
  rm -r User
  ln -s ~/Dropbox/Sublime/User
fi

# Install Spotify
if [[ ! -f /usr/bin/spotify ]]; then
  echo "Installing Spotify..."
  yay -S --noconfirm spotify-stable
fi

# Install Google Chrome
if [[ ! -f /usr/bin/google-chrome-stable ]]; then
  echo "Installing Google Chrome..."
  yay -S --noconfirm google-chrome
fi

# Install Slack
if [[ ! -f /usr/bin/slack ]]; then
  echo "Installing Slack..."
  yay -S --noconfirm slack-desktop
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

# Install Fonts
yay -S --noconfirm \
  ttf-symbola \
  ttf-emojione \
  ttf-emojione-color \
  ttf-twemoji-color \
  otf-fira-code-git

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

# Install ZSH Autosuggestions
if [[ ! -d $ZSH_CUSTOM/plugins/zsh-autosuggestions ]]; then
  echo "Installing ZSH Autosuggestions..."
  git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
fi

# Create Symlinks
ln -sf "$DOTFILES_DIR/.gitconfig" ~
ln -sf "$DOTFILES_DIR/.gitignore_global" ~
ln -sf "$DOTFILES_DIR/.zshrc" ~
ln -sf "$DOTFILES_DIR/.exports" ~
ln -sf "$DOTFILES_DIR/.aliases" ~
ln -sf "$DOTFILES_DIR/.functions" ~
