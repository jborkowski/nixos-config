{ config, lib, pkgs, ... }:
let
  # ((emacsPackagesNgGen emacsPgtkGcc).emacsWithPackages (epkgs: [ epkgs.vterm ]))
  epackages = (epkgs:
    with epkgs;
    [
      # # Package managements
      # use-package
      # auto-compile

      # # Cache
      # gcmh
      # no-littering

      # # Editor
      # avy
      # ace-window
      # god-mode
      # multiple-cursors
      # expand-region

      # # Apperance
      # minions
      # kaolin-themes
      # all-the-icons
      # all-the-icons-dired
      # all-the-icons-completion

      # # Completion framework
      # vertico
      # orderless
      # marginalia
      # consult
      # embark
      # embark-consult

      # # Org
      # org
      # org-bullets
      # org-roam
      # hl-todo
      # olivetti

      # # Tools
      # org-msg
      # elfeed
      # project
      # magit
      # diff-hl
      # eshell-syntax-highlighting
      # eshell-toggle
      # vterm
      # which-key
      # helpful
      # rainbow-mode

      # # Development
      # envrc
      # dumb-jump
      # eglot
      # consult-eglot
      # corfu
      # cape

      # ## Languages
      # flymake-shellcheck
      # nix-mode
      # js2-mode
      # js2-refactor
      # web-mode
      # typescript-mode
      # json-mode
      # haskell-mode
      # hindent
      # toml-mode
      # yaml-mode
      # lua-mode
      # markdown-mode
      vterm
    ]);
  myEmacs = with pkgs;
    ((emacsPackagesNgGen emacsGcc).emacsWithPackages epackages);
in {
  home-manager.users.jobo.programs = {
    emacs = {
      enable = true;
      package = myEmacs;
      # overrides = self: super: { org = self.elpaPackages.org; };
    };
  };
  home-manager.users.jobo.services = { emacs.enable = true; };
  home-manager.users.jobo.home.packages = with pkgs; [
    ## Dependencies
    coreutils
    binutils
    fd
    ripgrep
    zstd
    imagemagick # for image-dired

    ## Module dependencies
    ### :checkers spell, grammar
    (aspellWithDicts (ds: with ds; [ en en-computers en-science pl ]))
    languagetool
    ### :term vterm
    libvterm
    gnumake
    cmake
    gcc
    ### :tty
    xclip
    ### :lang markdown
    pandoc
    ### :lang org
    graphviz
    sqlite

    ## :lang sh
    shellcheck
    ## :lang javascript, webm json
    jq
    nodejs
    nodePackages.npm
    nodePackages.typescript-language-server
    # :lang rust
    rustfmt
    rust-analyzer
    # :lang latex & :lang org (latex previews)
    texlive.combined.scheme-medium
    zstd # for undo-fu-session/undo-tree compression
    fd # faster projectile indexing

    (ripgrep.override { withPCRE2 = true; })
    gnutls # for TLS connectivity

  ];
}
