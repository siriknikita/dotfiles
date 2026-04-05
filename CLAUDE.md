# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a dotfiles repository managed with [GNU Stow](https://www.gnu.org/software/stow/). Each top-level directory is a "stow package" containing config files that get symlinked into `~/.config` (default) or `~` (for `zsh` and `tmux`).

## Key Commands

- **Stow all packages:** `./stow_dotfiles.sh` — loops through all directories and stows them. Packages listed in `HOME_PACKAGES` (zsh, tmux) are stowed to `$HOME`; everything else goes to `~/.config`.
- **Stow a single package:** `stow <package>` (uses `.stowrc` which sets `--target=$HOME/.config`). For home-directory packages: `stow -t $HOME --no-folding <package>`.
- **Full Arch Linux setup:** `./install.sh` — installs system packages from `pacman_packages.txt` and `yay_packages.txt`, then stows everything.
- **Auto-commit & push:** `./commit_changes.sh` — stages all changes, generates a commit message from changed directories/files, and pushes to `origin master`.

## Stow Structure

Each stow package mirrors the target directory structure. Since `.stowrc` sets `--target=$HOME/.config`, a package like `alacritty/` contains `alacritty/alacritty.toml` which becomes `~/.config/alacritty/alacritty.toml`. Some packages have a nested `.config/` directory for the same effect via `install.sh` (which stows to `$HOME` directly).

Files excluded from stowing are listed in `.stow-local-ignore` (scripts, package lists, git files, etc.).

## Git Workflow

- Default remote branch: `master`
- Current local branch: `main`
- The `commit_changes.sh` script pushes to `origin master`
