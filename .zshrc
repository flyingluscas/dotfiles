# Setting $PATH
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to the oh-my-zsh installation
export ZSH=$HOME/.oh-my-zsh

# ZSH theme to display
ZSH_THEME='spaceship'

# Oh-my-zsh plugins
plugins=(
  git
  zsh-autosuggestions
)

# Spaceship settings
SPACESHIP_DIR_TRUNC=0
SPACESHIP_DIR_TRUNC_REPO=false
SPACESHIP_PACKAGE_SHOW=false
SPACESHIP_NODE_SHOW=false
SPACESHIP_PHP_SHOW=false
SPACESHIP_DOCKER_SHOW=false
SPACESHIP_BATTERY_SHOW=false

# Sourcing oh-my-zsh and other shell helpers
source $ZSH/oh-my-zsh.sh
source $HOME/.exports
source $HOME/.aliases
source $HOME/.functions
