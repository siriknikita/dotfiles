# Dotfiles

Personal configuration files managed with [GNU Stow](https://www.gnu.org/software/stow/). Primarily targets **Arch Linux with Hyprland**, but cross-platform configs (terminal, editor, shell) work on any system.

## What's Included

### Cross-Platform (Linux / macOS)

| Package | Description |
|---------|-------------|
| `zsh` | Zsh config with Oh My Zsh, zsh-autosuggestions, zsh-syntax-highlighting, fzf-powered selectors for editing configs and using aliases |
| `tmux` | Tmux config with `Ctrl+S` prefix, vim-style navigation, Catppuccin Mocha theme, TPM plugins |
| `nvim` | Neovim config (custom `init.lua`) |
| `nvim-lazy` | LazyVim-based Neovim setup with plugins for Rust, Python, Copilot, Markdown, testing, and more |
| `alacritty` | Alacritty terminal with Tokyo Night color scheme, JetBrains Mono Nerd Font, Catppuccin theme variants |
| `ohmyposh` | Oh My Posh prompt themes (`zen`, `base`) |
| `cursor` | Cursor editor profile |
| `yazi` | Yazi file manager config |

### Arch Linux / Hyprland Only

| Package | Description |
|---------|-------------|
| `hypr` | Hyprland window manager config, hyprpaper, mocha colorscheme, wlsunset script |
| `hyprland` | Additional Hyprland config directory |
| `hyprland-per-window-layout` | Per-window keyboard layout for Hyprland |
| `hyprmocha` | Catppuccin Mocha theme for Hyprland |
| `hyprpaper` | Wallpaper config for Hyprland |
| `waybar` | Waybar status bar with Catppuccin Mocha styling |
| `wofi` | Wofi application launcher styling |
| `wlsunset` | Blue light filter (wlsunset) config |
| `backgrounds` | Wallpaper images |

## Prerequisites

- **GNU Stow** — `brew install stow` (macOS) or `sudo pacman -S stow` (Arch)
- **Zsh** with [Oh My Zsh](https://ohmyz.sh/) installed
- **Oh My Posh** — for the shell prompt
- **fzf**, **zoxide** — used in zsh config
- **TPM** (Tmux Plugin Manager) — for tmux plugins: `git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm`
- **JetBrains Mono Nerd Font** — used by Alacritty and terminal configs

## Installation

### Full Arch Linux Setup

Installs all system packages and stows everything:

```bash
./install.sh
```

This will:
1. Update the system via `pacman`
2. Install `yay` (AUR helper) if missing
3. Install packages from `pacman_packages.txt` and `yay_packages.txt`
4. Stow all config directories to `$HOME`

### Selective Setup (Any System)

Stow only the packages you need. By default, configs are symlinked into `~/.config` (configured in `.stowrc`):

```bash
# Stow a single package to ~/.config
stow alacritty

# Packages that live in $HOME (zsh, tmux) need a different target
stow -t $HOME --no-folding zsh
stow -t $HOME --no-folding tmux
```

Or use the helper script to stow everything at once:

```bash
./stow_dotfiles.sh
```

This script automatically routes `zsh` and `tmux` to `$HOME` and everything else to `~/.config`.

### Unstowing (Removing Symlinks)

To cleanly remove symlinks before deleting the repo:

```bash
# Unstow a single package
stow -D alacritty

# Unstow home-directory packages
stow -t $HOME -D zsh
stow -t $HOME -D tmux

# Unstow everything
for dir in */; do stow -D "$(basename "$dir")"; done
```

## Neovim Setup

There are two Neovim configurations:

- **`nvim`** — Custom minimal config at `~/.config/nvim`
- **`nvim-lazy`** — Full LazyVim distribution at `~/.config/LazyVim`

Switch between them using the `nvims` shell function (defined in `.zshrc`), or use the `nvim-lazy` alias directly:

```bash
nvim-lazy file.txt    # Opens with LazyVim config
n file.txt            # Same (alias)
nvims file.txt        # FZF picker to choose config
```

## Shell Utilities

The `.zshrc` provides several fzf-powered functions:

- `edit` — Interactive selector to edit zshrc, aliases, or app configs (NeoVim, LazyGit, Tmux)
- `nvims` — Switch between Neovim configurations
- `use` — Browse and execute aliases via fzf
- `fzff` — Open a file found with fzf in Neovim

## Other Scripts

- **`commit_changes.sh`** — Auto-generates a commit message from changed files/directories and pushes to `origin master`

## Stow Directory Structure

Each package mirrors the target directory. Since `.stowrc` sets `--target=$HOME/.config`, a file at:

```
alacritty/alacritty/alacritty.toml
```

becomes a symlink at:

```
~/.config/alacritty/alacritty.toml
```

Home-directory packages (`zsh`, `tmux`) contain dotfiles directly (e.g., `zsh/.zshrc` → `~/.zshrc`).

Files excluded from stowing are listed in `.stow-local-ignore`.
