# My NixOS Configuration

![screenshot](screenshot.png)

My modular NixOS configuration with Home Manager integration.

## Structure

```
| nix /
|-flake.nix (Where everything starts)
|-assets/ (profile pic, sddm background, etc)
|-hosts/ (Configs for my machines: desktop, laptop)
|-modules/ (Pieces I want to be able to switch in and out)
|--system/ (System level configs like bootloader, GPU drivers)
|--home/ (Most of the juice is here. Managed by home manager. Program configs and such)
```

## Base setup

**OS:** NixOS

**Display Manager:** SDDM with the [Chili Theme](https://github.com/MarianArlt/sddm-chili) and a custom wallpaper to match my theme.

**Window Manager:** HyprLand

### Desktop Environment

Since HyprLand is just a window manager, I had to choose everything else you expect a computer to have. I went with a lot of the KDE
tools since they played a lot nicer with stylix for theming as well as just respecting the XDG environment variables.

- **File Manager**: Thunar
- **Image Viewer**: GwenView
- **Generic Text Editor**: Kate 
- **Video Player**: MPV 
- **PDF Viewer**: Okular 
- **Audio Player**: Elisa 
- **Archive/Zip Manager**: Ark
- **App Launcher:** Wofi

### Ecosystem

- **HyprPanel:** The nice top bar you see in the screenshot
- **Hyprpaper:** Just sets my wallpapers

## System Packages

- **Cachix:** Binary caches for faster builds
- **Stylix:** One of the best things to ever happen to nix. Theme everything consistenly with one config

## Terminal Tools

- Zsh: Funally made the switch after more than a decade of using bash
- bat: Better cat
- yazi
- starship: Cool and customizable terminal prompt 
- ripgrep

## Dev tools

- VsCode
- Datagrip

## Theming

- Consistent **Gruvbox** color scheme across all applications thanks to stylix

## Extra Features

- [Solaar](https://pwr-solaar.github.io/Solaar/) to manage my logitech mouse.