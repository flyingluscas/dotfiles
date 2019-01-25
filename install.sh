#!/bin/bash

# Get dotfiles installation directory
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Install YAY
if [[ ! -f /usr/bin/yay ]]; then
  echo "Installing YAY..."
  git clone https://aur.archlinux.org/yay.git $HOME/yay
  cd $HOME/yay
  makepkg -si --noconfirm --needed
  cd $HOME
  rm -Rf $HOME/yay
fi

# Install Gnome Tweak Tool
if [[ ! -f /usr/bin/gnome-tweaks ]]; then
  echo "Installing Gnome Tweak Tool..."
  sudo pacman -S --noconfirm --needed gnome-tweak-tool
fi

# Install Docker
if [[ ! -f /usr/bin/docker ]]; then
  echo "Installing Docker..."
  sudo pacman -S --noconfirm --needed docker
  sudo usermod -aG docker $USER
fi

# Install Docker Compose
if [[ ! -f /usr/bin/docker-compose ]]; then
  echo "Installing Docker Compose..."
  sudo pacman -S --noconfirm --needed docker-compose
fi

# Install Tilix
if [[ ! -f /usr/bin/tilix ]]; then
  echo "Installing Tilix..."
  sudo pacman -S --noconfirm --needed tilix
fi

# Install VLC
if [[ ! -f /usr/bin/vlc ]]; then
  echo "Installing VLC..."
  sudo pacman -S --noconfirm --needed vlc
fi

# Install Webtorrent Deskop
if [[ ! -f /usr/bin/webtorrent-desktop ]]; then
  echo "Installing Webtorrent Deskop..."
  yay -S --noconfirm --needed webtorrent-desktop
fi

# Install MegaSync
if [[ ! -f /usr/bin/megasync ]]; then
  echo "Installing MegaSync..."
  yay -S --noconfirm --needed megasync
fi

# Install Sublime Text
if [[ ! -f /usr/bin/subl ]]; then
  echo "Installing Sublime Text..."
  curl -O https://download.sublimetext.com/sublimehq-pub.gpg
  sudo pacman-key --add sublimehq-pub.gpg
  sudo pacman-key --lsign-key 8A8F901A
  rm sublimehq-pub.gpg
  echo -e "\n[sublime-text]\nServer = https://download.sublimetext.com/arch/stable/x86_64" | sudo tee -a /etc/pacman.conf
  sudo pacman -Syu --noconfirm --needed sublime-text
fi

# Install Spotify
if [[ ! -f /usr/bin/spotify ]]; then
  echo "Installing Spotify..."
  yay -S --noconfirm --needed spotify-stable
fi

# Install Google Chrome
if [[ ! -f /usr/bin/google-chrome-stable ]]; then
  echo "Installing Google Chrome..."
  yay -S --noconfirm --needed google-chrome
fi

# Install Slack
if [[ ! -f /usr/bin/slack ]]; then
  echo "Installing Slack..."
  yay -S --noconfirm --needed slack-desktop
fi

# Install Powerline Fonts
if [[ ! -f $HOME/.local/share/fonts/ter-powerline-x12b.pcf.gz ]]; then
  echo "Installing Powerline fonts..."
  git clone https://github.com/powerline/fonts.git $HOME/fonts
  cd $HOME/fonts
  ./install.sh
  cd $HOME
  rm -Rf $HOME/fonts
fi

# Install Fonts
echo "Installing fonts..."
sudo pacman -S --noconfirm --needed \
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
yay -S --noconfirm --needed \
  ttf-symbola \
  ttf-emojione \
  ttf-emojione-color \
  ttf-twemoji-color \
  otf-fira-code-git

# Install ZSH
if [[ ! -f /usr/bin/zsh ]]; then
  echo 'Installing ZSH...'
  sudo pacman -S --noconfirm --needed zsh
fi

# Install Oh My ZSH
if [[ ! -d $HOME/.oh-my-zsh ]]; then
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

# Load Tilix settings
dconf load /com/gexperts/Tilix/ < "$DOTFILES_DIR/Tilix.dconf"

# Create Symlinks
ln -sf "$DOTFILES_DIR/.gitconfig" $HOME
ln -sf "$DOTFILES_DIR/.gitignore_global" $HOME
ln -sf "$DOTFILES_DIR/.zshrc" $HOME
ln -sf "$DOTFILES_DIR/.exports" $HOME
ln -sf "$DOTFILES_DIR/.aliases" $HOME
ln -sf "$DOTFILES_DIR/.functions" $HOME
ln -sf "$DOTFILES_DIR/gtk.css" $HOME/.config/gtk-3.0
