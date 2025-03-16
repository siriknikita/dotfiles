#!/bin/bash

# Set the target directory to be ~/.config by default
TARGET="$HOME/.config"
HOME_TARGET="$HOME"

# Define a list of packages that should go to the home directory
declare -A HOME_PACKAGES=(
  ["zsh"]="home"
  ["tmux"]="home"
)

# Function to stow the package
stow_package() {
  local package=$1
  local target=$2
  echo "Stowing $package to $target..."

  if [ "$target" == "home" ]; then
    # For files that need to live in the home directory
    stow -t "$HOME" --no-folding "$package"
    echo "$package stowed to home directory."
  else
    # For normal stowing to $TARGET (usually ~/.config)
    stow "$package"
    echo "$package stowed to $TARGET."
  fi
}

# Main logic to stow all the packages
main() {
  # Loop through all directories in your dotfiles repo
  for package in $(ls -d */); do
    # Remove trailing slash from directory name
    package_name=$(basename "$package")

    # If the package is not in the HOME_PACKAGES list, stow it in ~/.config
    if [[ ! -v "HOME_PACKAGES[$package_name]" ]]; then
      stow_package "$package_name" "$TARGET"
    else
      stow_package "$package_name" "home"
    fi
  done
}

# Run the main function
main
