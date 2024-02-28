# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)

{ config, pkgs, ... }: 

let 
  stable-packages = with pkgs; [
    vlc
    firefox
    slack
    zoom-us
    spotify
    figma-linux
    obs-studio
    rustdesk # Teamviewer alternative
    caprine-bin # Facebook Messenger App
    heroic
    protontricks
    xivlauncher
    smart-open
  ];

  unstable-packages = with pkgs.unstable; [];
in {
  imports = [
    ../../../mixins/home-manager/ssh
    ../../../mixins/home-manager/git
    ../../../mixins/home-manager/apps/discord.nix
    ../../../mixins/home-manager/presets/gaming.nix
  ];

  home.shellAliases = {
    "so" = "smart-open";
    "code" = "codium";
  };

  home.packages = stable-packages ++ unstable-packages;

  programs.git = {
    userName = "Cecilia Sanare";
    userEmail = "ceci@sanare.dev";
  };

  dotfiles.desktop = {
    enable = true;
    background = "file://${pkgs.nixos-artwork.wallpapers.nineish-dark-gray.src}";
    favorites = [
      "org.gnome.Nautilus.desktop"
      "firefox.desktop"
      "codium.desktop"
      "discord.desktop"
    ];
  };

  dotfiles.apps.vscodium = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      jnoortheen.nix-ide
      rust-lang.rust-analyzer
      hashicorp.terraform
      esbenp.prettier-vscode
      arrterian.nix-env-selector
    ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "EditorConfig";
        publisher = "EditorConfig";
        version = "0.16.4";
        sha256 = "j+P2oprpH0rzqI0VKt0JbZG19EDE7e7+kAb3MGGCRDk=";
      }
    ];
  };
}
