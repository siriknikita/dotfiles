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

alias nvim-lazy="NVIM_APPNAME=LazyVim nvim"

function nvims() {
  items=("neovim" "LazyVim")
  config=$(printf "%s\n" "${items[@]}" | fzf --prompt=" Neovim Config  " --height=~50% --layout=reverse --border --exit-0)
  if [[ -z $config ]]; then
    echo "Nothing selected"
    return 0
  elif [[ $config == "neovim" ]]; then
    config=""
  fi
  NVIM_APPNAME=$config nvim $@
}

function edit_nvim_configs() {
  nvim_configs=("Default" "LazyVim")
  nvim_config=$(printf "%s\n" "${nvim_configs[@]}" | fzf --prompt=" Edit Neovim Config  " --height=~50% --layout=reverse --border --exit-0)

  if [[ -z $nvim_config ]]; then
    echo "Nothing selected"
    return 0
  elif [[ $nvim_config == "Default" ]]; then
    nvim-lazy $HOME/.config/nvim
  elif [[ $nvim_config == "LazyVim" ]]; then
    nvim-lazy $HOME/.config/LazyVim
  fi
}

function edit_configurations() {
  items=("NeoVim" "LazyGit" "TMUX")
  item=$(printf "%s\n" "${items[@]}" | fzf --prompt=" Edit Configuration " --height=~50% --layout=reverse --border --exit-0)
  if [[ -z $item ]]; then
    echo "Nothing selected"
    return 0
  elif [[ $item == "NeoVim" ]]; then
    edit_nvim_configs
  elif [[ $item == "LazyGit" ]]; then
    nvim-lazy $HOME/.config/lazygit/config.yml
  elif [[ $item == "TMUX" ]]; then
    nvim-lazy $HOME/.tmux.conf
  fi
}

# Suggest editing any of these items
function edit() {
  items=("zshrc" "Aliases" "Configruation")
  item=$(printf "%s\n" "${items[@]}" | fzf --prompt=" Edit " --height=~50% --layout=reverse --border --exit-0)
  if [[ -z $item ]]; then
    echo "Nothing selected"
    return 0
  elif [[ $item == "zshrc" ]]; then
    nvim-lazy $HOME/.zshrc
  elif [[ $item == "Aliases" ]]; then
    nvim-lazy $HOME/.aliases
  elif [[ $item == "Configruation" ]]; then
    edit_configurations
  fi
}

# Gets all the aliases from the ~/.aliases, and then suggests to use them
function use() {
  alias=$(cat $HOME/.aliases | grep -E "^alias" | sed -E 's/alias //g' | fzf --prompt=" Use Alias " --height=~50% --layout=reverse --border --exit-0)
  if [[ -z $alias ]]; then
    echo "Nothing selected"
    return 0
  fi
  eval $alias
}

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
  # eval "$(tmuxifier init -)"
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

