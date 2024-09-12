export ZSH=$HOME/.oh-my-zsh
export PATH=$HOME/.local/bin:$PATH

ZSH_THEME="robbyrussell"

#
# Allow parent to initialize shell
#
# This is awesome for opening terminals in VSCode.
#
if [[ -n $ZSH_INIT_COMMAND ]]; then
  echo "Executing ZSH_INIT_COMMAND: $ZSH_INIT_COMMAND"
  eval "$ZSH_INIT_COMMAND"
fi

# Disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

plugins=(
	git
	zsh-autosuggestions
  # zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh
source $HOME/.aliases

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# eval "$(oh-my-posh init zsh --config ~/.cache/oh-my-posh/themes/emodipt-extend.omp.json)"
eval "$(oh-my-posh init zsh --config ~/.config/ohmyposh/zen.toml)"
eval "$(zoxide init zsh)"
# eval "$(fzf --zsh)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export PATH="$PATH:/opt/nvim-linux64/bin"

# source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
