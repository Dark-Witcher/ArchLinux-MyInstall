#!/bin/bash

set -euo pipefail

# -----------------------------------------------------------------------------
# Arch Linux personal environment bootstrap
# -----------------------------------------------------------------------------

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

OFFICIAL_PACKAGES=(
    base-devel
    bash-completion
    fzf
    fastfetch
    zoxide
    usbguard
    git
    rsync
    wezterm
)

AUR_PACKAGES=(
    oh-my-posh
)

echo "========================================"
echo " Arch Linux Environment Setup"
echo "========================================"
echo

# -----------------------------------------------------------------------------
# System update
# -----------------------------------------------------------------------------

echo "==> Updating system..."
sudo pacman -Syu --noconfirm

# -----------------------------------------------------------------------------
# Official Arch packages
# -----------------------------------------------------------------------------

echo
echo "==> Installing official Arch packages..."

sudo pacman -S --needed --noconfirm "${OFFICIAL_PACKAGES[@]}"

# -----------------------------------------------------------------------------
# Paru
# -----------------------------------------------------------------------------

if command -v paru >/dev/null 2>&1; then
    echo
    echo "==> paru is already installed."
else
    echo
    echo "==> Installing paru..."

    BUILD_DIR="$(mktemp -d)"

    trap 'rm -rf "$BUILD_DIR"' EXIT

    git clone https://aur.archlinux.org/paru.git "$BUILD_DIR/paru"

    cd "$BUILD_DIR/paru"

    makepkg -si --noconfirm

    cd "$SCRIPT_DIR"

    rm -rf "$BUILD_DIR"
    trap - EXIT
fi

# -----------------------------------------------------------------------------
# AUR packages
# -----------------------------------------------------------------------------

echo
echo "==> Installing AUR packages..."

paru -S --needed --noconfirm "${AUR_PACKAGES[@]}"

# -----------------------------------------------------------------------------
# Configuration files
# -----------------------------------------------------------------------------

echo
echo "==> Installing shell configuration..."

rsync -a "$SCRIPT_DIR/.bashrc" "$HOME/.bashrc"
rsync -a "$SCRIPT_DIR/.aliases" "$HOME/.aliases"

echo
echo "==> Installing application configuration..."

mkdir -p "$HOME/.config"

rsync -a "$SCRIPT_DIR/alacritty/" "$HOME/.config/alacritty/"
rsync -a "$SCRIPT_DIR/wezterm/" "$HOME/.config/wezterm/"
rsync -a "$SCRIPT_DIR/fastfetch/" "$HOME/.config/fastfetch/"
rsync -a "$SCRIPT_DIR/oh-my-posh/" "$HOME/.config/oh-my-posh/"

# -----------------------------------------------------------------------------
# USBGuard
# -----------------------------------------------------------------------------

echo
echo "==> USBGuard installed."
echo
echo "    USBGuard has NOT been enabled automatically."
echo "    Generate and review a policy before starting the service."
echo

# -----------------------------------------------------------------------------
# Complete
# -----------------------------------------------------------------------------

echo "========================================"
echo " Installation completed."
echo "========================================"
