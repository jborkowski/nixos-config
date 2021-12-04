{ config, lib, pkgs, inputs, ... }: {
  programs.home-manager.enable = true;
  home.username = "jobo";
  home.homeDirectory = "/home/jobo";

  home.packages = with pkgs; [
    # Archives
    unrar
    zip
    unzip

    # Media
    sxiv
    calibre
    spotify
    playerctl
    alsa-utils
    pamixer
    pulsemixer
    youtube-dl

    # Communication
    pidgin
    slack
    discord
    betterdiscordctl
    signal-desktop

    # Other
    ungoogled-chromium
  ];

  home.stateVersion = "22.05";
}
