# Set the location of Oh My Zsh installation
export ZSH="$HOME/.oh-my-zsh"

# Add local bin to PATH
export PATH="$HOME/.local/bin:$PATH"

export MANPAGER='NVIM_APPNAME=LazyVim nvim +Man!'

# Set the Zsh theme
ZSH_THEME="robbyrussell"

# Enable command auto-correction
ENABLE_CORRECTION="true"

# Disable dirty Git status checking for performance
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
source "$ZSH/oh-my-zsh.sh"

# Source custom aliases
source "$HOME/.aliases"

# Custom alias
alias nvim-lazy="NVIM_APPNAME=LazyVim nvim"

# Choose between Neovim configs
function nvims() {
  items=("neovim" "LazyVim")
  config=$(printf "%s\n" "${items[@]}" | fzf --prompt=" Neovim Config  " --height=~50% --layout=reverse --border --exit-0)
  [[ -z $config ]] && echo "Nothing selected" && return 0
  [[ $config == "neovim" ]] && config=""
  NVIM_APPNAME=$config nvim "$@"
}

# Edit Neovim configurations
function edit_nvim_configs() {
  nvim_configs=("Default" "LazyVim")
  nvim_config=$(printf "%s\n" "${nvim_configs[@]}" | fzf --prompt=" Edit Neovim Config  " --height=~50% --layout=reverse --border --exit-0)
  [[ -z $nvim_config ]] && echo "Nothing selected" && return 0
  case $nvim_config in
    "Default") nvim-lazy "$HOME/.config/nvim" ;;
    "LazyVim") nvim-lazy "$HOME/.config/LazyVim" ;;
  esac
}

# Edit general configurations
function edit_configurations() {
  items=("NeoVim" "LazyGit" "TMUX")
  item=$(printf "%s\n" "${items[@]}" | fzf --prompt=" Edit Configuration " --height=~50% --layout=reverse --border --exit-0)
  [[ -z $item ]] && echo "Nothing selected" && return 0
  case $item in
    "NeoVim") edit_nvim_configs ;;
    "LazyGit") nvim-lazy "$HOME/.config/lazygit/config.yml" ;;
    "TMUX") nvim-lazy "$HOME/.tmux.conf" ;;
  esac
}

# Main edit selector
function edit() {
  items=("zshrc" "Aliases" "Configuration")
  item=$(printf "%s\n" "${items[@]}" | fzf --prompt=" Edit " --height=~50% --layout=reverse --border --exit-0)
  [[ -z $item ]] && echo "Nothing selected" && return 0
  case $item in
    "zshrc") nvim-lazy "$HOME/.zshrc" ;;
    "Aliases") nvim-lazy "$HOME/.aliases" ;;
    "Configuration") edit_configurations ;;
  esac
}

# Use an alias via FZF
function use() {
  alias=$(grep -E "^alias" "$HOME/.aliases" | sed -E 's/^alias //' | fzf --prompt=" Use Alias " --height=~50% --layout=reverse --border --exit-0)
  [[ -z $alias ]] && echo "Nothing selected" && return 0
  eval "$alias"
}

# Oh My Posh configuration selection
export OMP_CONFIG="zen"

case $OMP_CONFIG in
  "zen")
    CONFIG_PATH="$HOME/.config/ohmyposh/zen.toml"
    ;;
  "emodipt")
    CONFIG_PATH="$HOME/.cache/oh-my-posh/themes/emodipt-extend.omp.json"
    ;;
  *)
    echo "Unknown configuration: $OMP_CONFIG"
    return 1
    ;;
esac

# 1. Init once (NO --status here!)
eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/zen.toml)"

# 2. Dynamic prompt update with status code (Windsurf-safe)
function set_prompt() {
  local last_status=$?
  PROMPT="$(oh-my-posh print primary --config $HOME/.config/ohmyposh/zen.toml --shell zsh --status=$last_status)"
}
precmd_functions+=(set_prompt)

# Initialize CLI tools
initialize_cli_tools() {
  eval "$(zoxide init zsh)"
  eval "$(fzf --zsh)"

  # Google Cloud SDK paths
  [ -f "$HOME/Apps/google-cloud-sdk/path.zsh.inc" ] && source "$HOME/Apps/google-cloud-sdk/path.zsh.inc"
  [ -f "$HOME/Apps/google-cloud-sdk/completion.zsh.inc" ] && source "$HOME/Apps/google-cloud-sdk/completion.zsh.inc"

  # Load NVM
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"
}

initialize_cli_tools

# Add custom paths
export PATH="$PATH:/opt/nvim-linux64/bin"
export PATH="$HOME/.tmuxifier/bin:$PATH"
export PATH="$HOME/Automation/Scripts:$PATH"

