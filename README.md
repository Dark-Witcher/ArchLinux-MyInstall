# arch-base

A personal Arch Linux baseline for rebuilding my preferred command-line and terminal environment on a fresh installation.

This repository is intentionally opinionated. It is not a general-purpose Arch Linux installer or desktop environment configuration.

## What it does

The installer:

1. Updates the Arch Linux system.
2. Installs the required official packages.
3. Installs `paru` if it is not already available.
4. Installs `oh-my-posh` from the AUR.
5. Installs the shell and terminal configuration files.
6. Installs Fastfetch and its configuration.
7. Installs USBGuard, without automatically enabling or configuring its policy.

## Installed packages

### Official Arch Linux packages

- `base-devel`
- `bash-completion`
- `fzf`
- `fastfetch`
- `zoxide`
- `usbguard`
- `git`
- `rsync`
- `wezterm`

### AUR

- `oh-my-posh`

`paru` is bootstrapped directly from the AUR when it is not already installed.

## Configuration

The repository contains the following configuration:

```text
.bashrc
.aliases

alacritty/
└── alacritty.toml
    └── themes/

fastfetch/
├── config.jsonc
└── Logo.txt

oh-my-posh/
└── Themes/
    └── kali.omp.json

wezterm/
└── wezterm.lua
```

The installer deploys these to:

```text
~/.bashrc
~/.aliases
~/.config/alacritty/
~/.config/fastfetch/
~/.config/oh-my-posh/
~/.config/wezterm/
```

WezTerm is the primary terminal configuration. The Alacritty configuration is retained for compatibility and occasional use.

## Installation

Clone the repository:

```bash
git clone git@github.com:Dark-Witcher/arch-base.git
cd arch-base
```

Run the installer:

```bash
./install.sh
```

The installer requires `sudo` access and an active internet connection.

## USBGuard

USBGuard is installed as part of the baseline, but the service is **not enabled automatically**.

USB authorization policies are hardware-specific. Enabling USBGuard without first reviewing the resulting policy can lock out legitimate devices, including keyboards, mice, storage devices, or other required hardware.

Configure and test the USBGuard policy manually before enabling the service.

## Design principles

### Minimal baseline

This repository contains only the software and configuration considered part of my baseline environment.

Desktop-specific configuration such as Hyprland, Waybar, Swaylock, Wlogout, wallpapers, and other session-specific components is intentionally excluded.

### Idempotent installation

The installer uses `pacman --needed`, `paru --needed`, and `rsync` where appropriate so that running it again does not unnecessarily reinstall packages or depend on destructive directory moves.

Existing files with the same names are overwritten by the repository versions. Unmanaged files in the destination directories are preserved.

### Personal and opinionated

This is a personal environment repository.

The shell configuration, aliases, terminal settings, Fastfetch layout, and Oh My Posh theme reflect my own workflow and preferences. They are provided as a baseline, not as a claim that these are universally good defaults.

## Repository structure

```text
arch-base/
├── .aliases
├── .bashrc
├── alacritty/
├── fastfetch/
├── install.sh
├── LICENSE.md
├── oh-my-posh/
├── README.md
└── wezterm/
```

## License

See [LICENSE.md](LICENSE.md).
