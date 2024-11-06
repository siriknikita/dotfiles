#!/usr/bin/env bash

# Define the list of directories
directories=("backgrounds" "hyprland" "hyprmocha" "hyprpaper" "waybar" "wofi")

# Base directory where the directories are located (adjust if needed)
BASE_DIR="$HOME/dotfiles"

# Target directory where symlinks should be created (often the home directory)
TARGET_DIR="$HOME"

# Loop through each directory and apply stow
for dir in "${directories[@]}"; do
    # Check if the directory exists in BASE_DIR
    if [ -d "$BASE_DIR/$dir" ]; then
        echo "Stowing $dir..."
        stow -d "$BASE_DIR" -t "$TARGET_DIR" "$dir"
    else
        echo "Directory $BASE_DIR/$dir does not exist, skipping."
    fi
done

echo "All specified directories have been processed."

# # Check for internet connection
# if ping -c 1 8.8.8.8 &> /dev/null; then
#     echo "Internet connection is available."
#
#     # ==========================
#     # Install necessary plugins
#     # ==========================
#
#     # Install zsh-syntax-highlighting
# #     git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
# #
# #     # Install zsh-autosuggestions
# #     git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
# #
# #     # Install oh-my-posh
# #     curl -s https://ohmyposh.dev/install.sh | bash -s
# #
# #     # Stow the current files and folders
# #     for dir in */; do
# #         stow "$dir"
# #     done
# else
#     echo "No internet connection. Please check your network settings."
# fi
#
