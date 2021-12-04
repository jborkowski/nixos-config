{ pkgs, ... }: {

  imports = [
    ../direnv
    ../neovim
    ../firefox
    ../flameshot
    ../emacs
    ../fzf
    ../git
    ../zsh
    ../redshift
  ];

  services = {
    xserver = {
      enable = true;
      layout = "pl";
      xkbOptions = "caps:escape_shifted_capslock";
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };
  };

  environment.systemPackages = with pkgs; [ ripgrep ];
}
