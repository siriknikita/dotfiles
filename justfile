# Dotfiles management with GNU Stow

config_target := env("HOME") / ".config"
home_target := env("HOME")

# List available recipes
default:
    @just --list

# Stow all packages
stow-all:
    #!/usr/bin/env bash
    HOME_PACKAGES=("zsh" "tmux")
    for package in $(ls -d */); do
        name=$(basename "$package")
        if [[ " ${HOME_PACKAGES[*]} " =~ " ${name} " ]]; then
            echo "Stowing $name to {{ home_target }}..."
            stow -t "{{ home_target }}" --no-folding "$name"
        else
            echo "Stowing $name to {{ config_target }}..."
            stow "$name"
        fi
    done

# Stow a single package to ~/.config
stow package:
    stow {{ package }}

# Stow a home-directory package (zsh, tmux)
stow-home package:
    stow -t {{ home_target }} --no-folding {{ package }}

# Unstow all packages
unstow-all:
    #!/usr/bin/env bash
    HOME_PACKAGES=("zsh" "tmux")
    for package in $(ls -d */); do
        name=$(basename "$package")
        if [[ " ${HOME_PACKAGES[*]} " =~ " ${name} " ]]; then
            stow -t "{{ home_target }}" --no-folding -D "$name"
        else
            stow -D "$name"
        fi
    done

# Unstow a single package
unstow package:
    stow -D {{ package }}

# Re-stow all packages (unstow then stow, useful for cleanup)
restow-all:
    #!/usr/bin/env bash
    HOME_PACKAGES=("zsh" "tmux")
    for package in $(ls -d */); do
        name=$(basename "$package")
        if [[ " ${HOME_PACKAGES[*]} " =~ " ${name} " ]]; then
            stow -t "{{ home_target }}" --no-folding -R "$name"
        else
            stow -R "$name"
        fi
    done

# Auto-commit and push changes to origin master
commit-push:
    #!/usr/bin/env bash
    changed_items=$(git status --porcelain | awk '{print $2}')
    declare -A folders
    files=()
    for item in $changed_items; do
        if [[ -d $item ]]; then
            root_folder=$(echo $item | cut -d'/' -f1)
            folders["$root_folder"]=1
        else
            depth=$(echo $item | awk -F'/' '{print NF}')
            if [[ $depth -gt 1 ]]; then
                root_folder=$(echo $item | cut -d'/' -f1)
                folders["$root_folder"]=1
            else
                files+=("$item")
            fi
        fi
    done
    commit_message="Add"
    for folder in "${!folders[@]}"; do
        commit_message+=" $folder,"
    done
    for file in "${files[@]}"; do
        commit_message+=" $file,"
    done
    commit_message=${commit_message%,}
    git add .
    git commit -m "$commit_message"
    git push origin master

# Full Arch Linux install (packages + stow)
install:
    #!/usr/bin/env bash
    set -euo pipefail
    RED='\033[0;31m'
    GREEN='\033[0;32m'
    YELLOW='\033[1;33m'
    NC='\033[0m'
    print_status() { echo -e "${GREEN}[*] $1${NC}"; }
    print_error()  { echo -e "${RED}[!] $1${NC}"; }
    print_warning(){ echo -e "${YELLOW}[!] $1${NC}"; }

    print_status "Checking internet connection..."
    if ! ping -c 1 8.8.8.8 &> /dev/null; then
        print_error "No internet connection."
        exit 1
    fi

    print_status "Updating system..."
    sudo pacman -Syu --noconfirm

    if ! command -v go &> /dev/null; then
        print_status "Installing Go..."
        sudo pacman -S --noconfirm go
    fi

    if ! command -v yay &> /dev/null; then
        print_status "Installing yay..."
        git clone https://aur.archlinux.org/yay.git /tmp/yay
        (cd /tmp/yay && makepkg -si --noconfirm)
        rm -rf /tmp/yay
    fi

    is_installed() { pacman -Qi "$1" &> /dev/null; }

    if [ -f "pacman_packages.txt" ]; then
        print_status "Installing pacman packages..."
        while IFS= read -r pkg || [ -n "$pkg" ]; do
            [[ -z "$pkg" || "$pkg" =~ ^#.*$ ]] && continue
            if is_installed "$pkg"; then
                print_warning "$pkg already installed, skipping..."
            else
                print_status "Installing $pkg..."
                sudo pacman -S --noconfirm "$pkg" || print_warning "Failed to install $pkg"
            fi
        done < pacman_packages.txt
    fi

    if [ -f "yay_packages.txt" ]; then
        print_status "Installing AUR packages..."
        while IFS= read -r pkg || [ -n "$pkg" ]; do
            [[ -z "$pkg" || "$pkg" =~ ^#.*$ ]] && continue
            if is_installed "$pkg"; then
                print_warning "$pkg already installed, skipping..."
            else
                print_status "Installing $pkg..."
                yay -S --noconfirm "$pkg" || print_warning "Failed to install $pkg"
            fi
        done < yay_packages.txt
    fi

    just stow-all
    print_status "Installation completed!"
