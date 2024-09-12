#!/usr/bin/env bash

# Check for internet connection
if ping -c 1 8.8.8.8 &> /dev/null; then
    echo "Internet connection is available."

    # Install stow using pacman
    sudo pacman -S stow

    # Stow the current files and folders
    for dir in */; do
        stow "$dir"
    done
else
    echo "No internet connection. Please check your network settings."
fi
