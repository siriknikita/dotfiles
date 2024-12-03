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

# PATH variable

source $ZSH/oh-my-zsh.sh
source $HOME/.aliases

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# eval "$(oh-my-posh init zsh --config ~/.cache/oh-my-posh/themes/emodipt-extend.omp.json)"
eval "$(oh-my-posh init zsh --config ~/ohmyposh/.config/ohmyposh/zen.toml)"
eval "$(zoxide init zsh)"
# eval "$(fzf --zsh)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export PATH="$PATH:/opt/nvim-linux64/bin"
export PATH="$HOME/.tmuxifier/bin:$PATH"

eval "$(tmuxifier init -)"

# source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/mykyta/Apps/google-cloud-sdk/path.zsh.inc' ]; then . '/home/mykyta/Apps/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/mykyta/Apps/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/mykyta/Apps/google-cloud-sdk/completion.zsh.inc'; fi
