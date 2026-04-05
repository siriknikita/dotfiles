# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a dotfiles repository managed with [GNU Stow](https://www.gnu.org/software/stow/). Each top-level directory is a "stow package" containing config files that get symlinked into `~/.config` (default) or `~` (for `zsh` and `tmux`).

## Key Commands

All commands are managed via [`just`](https://github.com/casey/just). Run `just` to see available recipes.

- **Stow all packages:** `just stow-all` — stows all directories. Home packages (zsh, tmux) go to `$HOME`; everything else to `~/.config`.
- **Stow a single package:** `just stow <package>` or `just stow-home <package>` (for zsh/tmux).
- **Unstow:** `just unstow <package>` or `just unstow-all`.
- **Re-stow (cleanup):** `just restow-all`.
- **Full Arch Linux setup:** `just install` — installs system packages from `pacman_packages.txt` and `yay_packages.txt`, then stows everything.
- **Auto-commit & push:** `just commit-push` — stages all changes, generates a commit message from changed directories/files, and pushes to `origin master`.

## Stow Structure

Each stow package mirrors the target directory structure. Since `.stowrc` sets `--target=$HOME/.config`, a package like `alacritty/` contains `alacritty/alacritty.toml` which becomes `~/.config/alacritty/alacritty.toml`. Some packages have a nested `.config/` directory for the same effect via `install.sh` (which stows to `$HOME` directly).

Files excluded from stowing are listed in `.stow-local-ignore` (scripts, package lists, git files, etc.).

## Git Workflow

- Default branch: `main`
- `just commit-push` pushes to `origin main`
