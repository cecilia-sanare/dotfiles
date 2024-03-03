# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)

{ config, lib, pkgs, platform, vscode-extensions, ... }:

let
  stable-packages = with pkgs.stable; [
    vlc
    slack
    zoom-us
    spotify
    figma-linux
    obs-studio
    rustdesk # Teamviewer alternative
    caprine-bin # Facebook Messenger App
  ];

  unstable-packages = with pkgs; [
    xivlauncher
    heroic
    tuba
    smart-open
  ];
in
{
  imports = [
    ../../../mixins/home-manager/ssh
    ../../../mixins/home-manager/git
    ../../../mixins/home-manager/apps/discord.nix
    ../../../mixins/home-manager/apps/firefox.nix
    ../../../mixins/home-manager/presets/gaming.nix
  ];

  home.shellAliases = {
    "so" = "smart-open";
  };

  home.packages = stable-packages ++ unstable-packages;

  programs.git = {
    userName = "Cecilia Sanare";
    userEmail = "ceci@sanare.dev";
  };

  programs.firefox.profiles.ceci.bookmarks = [
    {
      name = "";
      tags = [ "git" "sourcecode" ];
      url = "https://github.com/cecilia-sanare";
    }
    {
      name = "";
      tags = [ "youtube" ];
      url = "https://youtube.com";
    }
  ];

  dotfiles.desktop = {
    enable = true;

    favorites = [
      "firefox.desktop"
      "codium.desktop"
      "discord.desktop"
    ];

    picture = {
      url = "https://avatars.githubusercontent.com/u/9692284?v=4";
      sha256 = "11gdxhgk9xqfh1936vg3gq3nqqj0d6fwgpc3zzh5c64y94g96vaj";
    };
  };
}
