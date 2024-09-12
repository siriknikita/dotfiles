#!/usr/bin/env bash

# Check for internet connection
if ping -c 1 8.8.8.8 &> /dev/null; then
    echo "Internet connection is available."

    # Install stow using pacman
    sudo pacman -S stow

    # Install zsh
    sudo pacman -S zsh

    # ==========================
    # Install necessary plugins
    # ==========================

    # Install zsh-syntax-highlighting
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

    # Install zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

    # Install oh-my-posh
    curl -s https://ohmyposh.dev/install.sh | bash -s

    # Stow the current files and folders
    for dir in */; do
        stow "$dir"
    done
else
    echo "No internet connection. Please check your network settings."
fi
