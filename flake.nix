{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager.url = "github:rycee/home-manager/master";
    nur.url = "github:nix-community/NUR";

    emacs-overlay.url = "github:nix-community/emacs-overlay/64580e3ac034e2704895a272f341a0729d165b93";
    xmonad.url = "github:xmonad/xmonad";
    xmonad-contrib.url = "github:xmonad/xmonad-contrib";
  };

  outputs = { nixpkgs, nixos-hardware, home-manager, nur, emacs-overlay, xmonad
    , xmonad-contrib, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = { allowUnfree = true; };
        overlays = [
          nur.overlay
          emacs-overlay.overlay
          xmonad.overlay
          xmonad-contrib.overlay
        ];
      };
    in {
      devShell.${system} = import ./shell.nix { inherit pkgs; };
      nixosConfigurations = {
        niffler = nixpkgs.lib.nixosSystem {
          inherit pkgs system;
          modules = [
            ./hosts/niffler
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.jobo = import ./modules/full.nix;
            }
          ];
        };
      };
    };
}
