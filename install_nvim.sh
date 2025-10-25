#!/usr/bin/env bash

set -e

# Define paths
NVIM_CONFIG="$HOME/.config/nvim"
BACKUP_DIR="$HOME/.dotfiles_backup"
DOTFILES_NVIM="$HOME/.dotfiles/nvim"
BACKUP_TARGET="$BACKUP_DIR/nvim"

# Create backup directory if it doesn't exist
mkdir -p "$BACKUP_DIR"

# Backup existing config if it's not a symlink
if [ -e "$NVIM_CONFIG" ] && [ ! -L "$NVIM_CONFIG" ]; then
    if [ -e "$BACKUP_TARGET" ]; then
        echo "⚠️ Backup already exists at $BACKUP_TARGET"
    else
        echo "📦 Backing up $NVIM_CONFIG to $BACKUP_TARGET"
        mv "$NVIM_CONFIG" "$BACKUP_TARGET"
    fi
fi

# Remove existing symlink or leftover folder
if [ -e "$NVIM_CONFIG" ]; then
    echo "🧹 Removing existing $NVIM_CONFIG"
    rm -rf "$NVIM_CONFIG"
fi

# Create symlink
echo "🔗 Creating symlink: $NVIM_CONFIG → $DOTFILES_NVIM"
ln -s "$DOTFILES_NVIM" "$NVIM_CONFIG"

echo "✅ Neovim config symlinked successfully."
