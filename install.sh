#!/usr/bin/env bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print status messages
print_status() {
    echo -e "${GREEN}[*] $1${NC}"
}

print_error() {
    echo -e "${RED}[!] $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}[!] $1${NC}"
}

# Check for internet connection
print_status "Checking internet connection..."
if ! ping -c 1 8.8.8.8 &> /dev/null; then
    print_error "No internet connection. Please check your network settings."
    exit 1
fi
print_status "Internet connection is available."

# Update system
print_status "Updating system..."
sudo pacman -Syu --noconfirm || {
    print_error "Failed to update system"
    exit 1
}

# Install Go if not already installed
if ! command -v go &> /dev/null; then
    print_status "Installing Go..."
    sudo pacman -S --noconfirm go || {
        print_error "Failed to install Go"
        exit 1
    }
fi

# Install yay if not already installed
if ! command -v yay &> /dev/null; then
    print_status "Installing yay..."
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    (cd /tmp/yay && makepkg -si --noconfirm) || {
        print_error "Failed to install yay"
        exit 1
    }
    rm -rf /tmp/yay
fi

# Function to check if a package is installed
is_package_installed() {
    pacman -Qi "$1" &> /dev/null
}

# Install packages from pacman_packages.txt if it exists
if [ -f "pacman_packages.txt" ]; then
    print_status "Installing packages from pacman_packages.txt..."
    while IFS= read -r package || [ -n "$package" ]; do
        # Skip empty lines and comments
        [[ -z "$package" || "$package" =~ ^#.*$ ]] && continue
        
        if is_package_installed "$package"; then
            print_warning "Package $package is already installed, skipping..."
        else
            print_status "Installing $package..."
            sudo pacman -S --noconfirm "$package" || print_warning "Failed to install $package"
        fi
    done < pacman_packages.txt
else
    print_warning "pacman_packages.txt not found, skipping pacman packages installation"
fi

# Install packages from yay_packages.txt if it exists
if [ -f "yay_packages.txt" ]; then
    print_status "Installing packages from yay_packages.txt..."
    while IFS= read -r package || [ -n "$package" ]; do
        # Skip empty lines and comments
        [[ -z "$package" || "$package" =~ ^#.*$ ]] && continue
        
        if is_package_installed "$package"; then
            print_warning "Package $package is already installed, skipping..."
        else
            print_status "Installing $package..."
            yay -S --noconfirm "$package" || print_warning "Failed to install $package"
        fi
    done < yay_packages.txt
else
    print_warning "yay_packages.txt not found, skipping AUR packages installation"
fi

# Base directory where the directories are located
BASE_DIR="$HOME/dotfiles"

# Target directory where symlinks should be created
TARGET_DIR="$HOME"

# Define the list of directories to stow
directories=($(find "$BASE_DIR" -maxdepth 1 -mindepth 1 -type d -not -name ".git" -printf "%f\n"))

# Stow configurations
print_status "Stowing configuration files..."
for dir in "${directories[@]}"; do
    if [ -d "$BASE_DIR/$dir" ]; then
        print_status "Stowing $dir..."
        stow -d "$BASE_DIR" -t "$TARGET_DIR" "$dir" || {
            print_error "Failed to stow $dir"
            continue
        }
    else
        print_warning "Directory $BASE_DIR/$dir does not exist, skipping."
    fi
done

print_status "Installation completed!"
