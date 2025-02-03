# Set the location of Oh My Zsh installation
export ZSH=$HOME/.oh-my-zsh

# Add local bin to PATH
export PATH=$HOME/.local/bin:$PATH

# Set the Zsh theme
ZSH_THEME="robbyrussell"

# Enable command auto-correction
ENABLE_CORRECTION="true"

# Enable command auto-completion

DISABLE_UNTRACKED_FILES_DIRTY="true"

# Execute a custom initialization command if defined
if [[ -n $ZSH_INIT_COMMAND ]]; then
  echo "Executing ZSH_INIT_COMMAND: $ZSH_INIT_COMMAND"
  eval "$ZSH_INIT_COMMAND"
fi

# Define and load plugins
plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
)

# Load Oh My Zsh
source $ZSH/oh-my-zsh.sh

# Source custom aliases
source $HOME/.aliases

# Define the variable to hold the path to the configuration file
export OMP_CONFIG="zen"

# Use a case statement to switch between different configurations
case $OMP_CONFIG in
  "zen")
    CONFIG_PATH="$HOME/ohmyposh/.config/ohmyposh/zen.toml"
    ;;
  "emodipt")
    CONFIG_PATH="$HOME/.cache/oh-my-posh/themes/emodipt-extend.omp.json"
    ;;
  *)
    echo "Unknown configuration: $OMP_CONFIG"
    return 1
    ;;
esac

# Functions to initialize all tools
initialize_cli_tools() {
  eval "$(oh-my-posh init zsh --config $CONFIG_PATH)"
  eval "$(zoxide init zsh)"
  eval "$(tmuxifier init -)"
  eval "$(fzf --zsh)"

  # Update PATH for the Google Cloud SDK
  if [ -f "$HOME/Apps/google-cloud-sdk/path.zsh.inc" ]; then
    . "$HOME/Apps/google-cloud-sdk/path.zsh.inc"
  fi

  # Enable shell command completion for gcloud
  if [ -f "$HOME/Apps/google-cloud-sdk/completion.zsh.inc" ]; then
    . "$HOME/Apps/google-cloud-sdk/completion.zsh.inc"
  fi

  # Load NVM (Node Version Manager) tool
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

}

# Call the function to initialize CLI tools
initialize_cli_tools

# Add custom paths to PATH
export PATH="$PATH:/opt/nvim-linux64/bin"
export PATH="$HOME/.tmuxifier/bin:$PATH"
export PATH="$HOME/Automation/Scripts:$PATH"

