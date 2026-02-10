# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a dotfiles repository for Arch Linux with Hyprland (Wayland compositor). All configurations are located in the `dotfiles/` subdirectory and should be symlinked or copied to `~/.config/`.

## Installation

Run `./install.sh` from the repository root. This script:
1. Installs required packages via pacman and AUR (via yay)
2. Sets up ZSH, tmux, fnm, and other tools
3. Copies configuration files to `~/.config/`

## Architecture

### Modular Configuration Pattern

Most configurations use a modular approach where the main config file sources additional files:

- **Hyprland** (`~/.config/hypr/hyprland.conf`): Sources files from `~/.config/hypr/conf/` for monitors, keyboard, binds, animations, window rules, etc.
- **ZSH** (`~/.zshrc`): Sources all files from `~/.config/zshrc/` directory (numbered prefixes control load order)
- **tmux** (`~/.config/tmux/tmux.conf`): Single file with plugins managed by TPM

### ZSH Configuration Files

Files in `~/.config/zshrc/` are loaded in alphabetical order:
- `00-init` - Environment variables, exports
- `env` - Local environment (proxy settings, etc.) - **not committed**, use `env.example` as template
- `20-customization` - oh-my-zsh plugins and completion
- `25-aliases` - Shell aliases
- `30-autostart` - Tool initialization (starship, zoxide, atuin, fnm)

### Key Directories

- `dotfiles/.config/hypr/` - Hyprland compositor configuration
- `dotfiles/.config/hyprdots/scripts/` - Helper scripts (screenshots, screen recording, menus)
- `dotfiles/.config/tmux/plugins/` - tmux plugins (managed by TPM)
- `dotfiles/.config/waybar/` - Status bar configuration
- `dotfiles/.config/zshrc/` - Modular ZSH configuration
- `install/` - Installation scripts for Arch Linux

### Environment Variables

Sensitive or machine-specific environment variables should go in `~/.config/zshrc/env`:
```bash
cp ~/.config/zshrc/env.example ~/.config/zshrc/env
```

## tmux Plugins

Plugins are installed in `~/.config/tmux/plugins/` and managed by TPM. To install/update plugins:
```bash
~/.config/tmux/plugins/tpm/bin/install_plugins
```

Key prefix is `Ctrl+A` (not the default `Ctrl+B`).

## Shell Tools

- **Editor**: `zeditor` (Zed)
- **Prompt**: Starship
- **Directory navigation**: zoxide (`cd` alias)
- **History**: Atuin
- **Node version manager**: fnm
- **File listing**: eza (aliases: `ls`, `ll`, `lt`)
- **File viewing**: bat (alias: `cat`)

## Comments Language

Comments in configuration files are written in Russian.
