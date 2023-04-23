#!/bin/bash

# Get dotfiles installation directory
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Install YAY
if [[ ! -f /usr/bin/yay ]]; then
  echo "Installing YAY..."
  sudo pacman -S --noconfirm --needed base-devel
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

# Install Visual Studio Code
if [[ ! -f /usr/bin/code ]]; then
  echo "Installing Visual Studio Code..."
  yay -S --noconfirm --needed visual-studio-code-bin
fi

# Install Spotify
if [[ ! -f /usr/bin/spotify ]]; then
  echo "Installing Spotify..."
  curl -sS https://download.spotify.com/debian/pubkey_0D811D58.gpg | gpg --import -
  yay -S --noconfirm --needed spotify
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

# Install MacOS Fonts
if [[ ! -d $HOME/.fonts ]]; then
  echo 'Installing MacOS Fonts...'

  mkdir $DOTFILES_DIR/fonts
  mkdir $HOME/.fonts

  curl -o $DOTFILES_DIR/fonts/SF-Pro.dmg https://devimages-cdn.apple.com/design/resources/download/SF-Pro.dmg
  curl -o $DOTFILES_DIR/fonts/SF-Mono.dmg https://devimages-cdn.apple.com/design/resources/download/SF-Mono.dmg

  yay -S --noconfirm --needed p7zip

  7z -o$DOTFILES_DIR/fonts x $DOTFILES_DIR/fonts/SF-Pro.dmg
  7z -o$DOTFILES_DIR/fonts/SFProFonts x $DOTFILES_DIR/fonts/SFProFonts/SF\ Pro\ Fonts.pkg
  7z -o$DOTFILES_DIR/fonts/SFProFonts x $DOTFILES_DIR/fonts/SFProFonts/Payload\~

  7z -o$DOTFILES_DIR/fonts x $DOTFILES_DIR/fonts/SF-Mono.dmg
  7z -o$DOTFILES_DIR/fonts/SFMonoFonts x $DOTFILES_DIR/fonts/SFMonoFonts/SF\ Mono\ Fonts.pkg
  7z -o$DOTFILES_DIR/fonts/SFMonoFonts x $DOTFILES_DIR/fonts/SFMonoFonts/Payload\~

  mv --force $DOTFILES_DIR/fonts/SFProFonts/Library/Fonts/* $HOME/.fonts
  mv --force $DOTFILES_DIR/fonts/SFMonoFonts/Library/Fonts/* $HOME/.fonts

  rm -Rf $DOTFILES_DIR/fonts
fi

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

# Install NVM
if [[ ! -d $HOME/.nvm ]]; then
  echo "Installing NVM..."
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
fi

# Install Gnome Themes Extra
yay -S --noconfirm --needed gnome-themes-extra

# Install AWS CLI v2 and Terraform
yay -S --noconfirm --needed aws-cli-v2-bin terraform

# Load Tilix settings
dconf load /com/gexperts/Tilix/ < "$DOTFILES_DIR/Tilix.dconf"

# Load Gnome Settings
dconf load /org/gnome/ < "$DOTFILES_DIR/Gnome.dconf"

# Create Symlinks
ln -sf "$DOTFILES_DIR/.gitconfig" $HOME
ln -sf "$DOTFILES_DIR/.gitignore_global" $HOME
ln -sf "$DOTFILES_DIR/.zshrc" $HOME
ln -sf "$DOTFILES_DIR/.exports" $HOME
ln -sf "$DOTFILES_DIR/.aliases" $HOME
ln -sf "$DOTFILES_DIR/.functions" $HOME
ln -sf "$DOTFILES_DIR/gtk.css" $HOME/.config/gtk-3.0
