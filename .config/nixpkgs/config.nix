{
  allowUnfree = true;
  packageOverrides = pkgs: rec {

    sqlite = pkgs.sqlite.override {
      interactive = true;
      readline = pkgs.readline;
    };
    coreEnv = with pkgs; buildEnv {
      name = "coreEnv";
      paths = [
        exa
        fd
        feh
        fzf
        multimarkdown
        neovim
        nix-prefetch-git
        nix-prefetch-scripts
        nix-repl
        pass
        ranger
        ripgrep
        rofi
        traceroute
        zathura
      ];
    };

    baseEnv = with pkgs; buildEnv {
      name = "baseEnv";
      paths = [
        ag
        aspell
        aspellDicts.en
        cloc
        evince
        ffmpeg
        file
        htop
        httpie
        imagemagick
        jq
        ktorrent
        # libreoffice
        neofetch
        nmap
        pandoc
        pdftk
        pmount
        rlwrap
        scrot
        smartmontools
        sqlite
        stow
        stress
        texlive.combined.scheme-full
        tree
        unrar
        unzip
        vlc
        weechat
        youtube-dl
        zip
      ];
    };

    coreDev = with pkgs; buildEnv {
      name = "coreDev";
      paths = [
        ammonite
        binutils
        cabal2nix
        git
        gnumake
        haskellPackages.cabal-install
        haskellPackages.ghc
        haskellPackages.hindent
        haskellPackages.hlint
        haskellPackages.styx
        haskellPackages.ghcid
        nodePackages.tern
        openjdk8
        patchelf
        python
        python36
        sbt
        scala
        shellcheck
        vscode
      ];
    };

    baseDev = with pkgs; buildEnv {
      name = "baseDev";
      paths = [
        clojure
        fsharp
        go
        gradle
        idris
        kotlin
        leiningen
        maven
        nodejs
        rustracer
        rustup # rustc, cargo, rustup all in one
      ];
    };

    # stuff likely to break when upgrade
    nonFree = with pkgs; buildEnv {
      name = "nonFree";
      paths = [
        jetbrains.idea-community
        skypeforlinux
        spotify
        steam
        steam-run
      ];
    };
  };
}
