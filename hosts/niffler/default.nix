{ config, pkgs, ... }:

{
  imports = [ ../../modules/wms/gnome.nix ./hardware-configuration.nix ];

  users = {
    defaultUserShell = pkgs.zsh;
    users.jobo = {
      isNormalUser = true;
      extraGroups = [ "wheel" "docker" "networkmanager" "audio" "video" ];
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHm5FAv9Tr1ycXOkeaM/qfyZpOlAFZpkKQhoUwFIUwB8 jonatan.borkowski@pm.me"
      ];
    };
  };

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernel.sysctl = { "vm.swappiness" = 10; };
    kernelPackages = pkgs.linuxPackages_latest;
    cleanTmpDir = true;
  };

  time.timeZone = "Europe/Warsaw";

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "pl";
  };

  services = {
    openssh.enable = true;
    gvfs.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    printing.enable = true;
  };

  fonts = {
    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = [ "JuliaMono" ];
        serif = [ "CMU Concrete" ];
        sansSerif = [ "CMU Sans Serif" ];
      };
    };

    fonts = with pkgs; [
      julia-mono
      cm_unicode
      powerline-fonts
      emacs-all-the-icons-fonts
      font-awesome-ttf
      nerdfonts
      hack-font
      hasklig
    ];
  };

  programs = {
    mtr.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };

  environment.systemPackages = with pkgs; [ coreutils wget git ];

  hardware = {
    bluetooth = {
      enable = true;
      # For Bose QC 35
      settings = { General = { Enable = "Source,Sink,Media,Socket"; }; };
    };
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
    pulseaudio.enable = false;
  };

  # security.rtkit.enable = true;

  networking = {
    hostName = "niffler";
    firewall.enable = false;
    networkmanager.enable = true;
    useDHCP = false;
    interfaces.eno2.useDHCP = true;
    interfaces.wlo1.useDHCP = true;
  };

  virtualisation.docker.enable = true;

  nixpkgs.config.allowUnfree = true;

  nix = {
    autoOptimiseStore = true;
    gc = {
      automatic = true;
      dates = "monthly";
      options = "--delete-older-than 8d";
    };
    optimise = {
      automatic = true;
      dates = [ "weekly" ];
    };
    trustedUsers = [ "jobo" "root" ];
    binaryCaches = [
      "https://nix-community.cachix.org/"
      "https://hydra.iohk.io"
      "https://iohk.cachix.org"
    ];
    binaryCachePublicKeys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="
      "iohk.cachix.org-1:DpRUyj7h7V830dp/i6Nti+NEO2/nhblbov/8MW7Rqoo="
    ];
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
  documentation.man.generateCaches = true;
  system.stateVersion = "22.05";

}
