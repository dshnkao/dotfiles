{
  allowUnfree = true;
  packageOverrides = pkgs: rec {

    # temporary fix
    neovim = pkgs.neovim.override { 
      withRuby = false;
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
        libreoffice
        neofetch
        nmap
        pandoc
        pdftk
        pmount
        scrot
        skypeforlinux smartmontools
        spotify
        sqlite
        steam
        steam-run
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
        gcc
        git
        gnumake
        haskellPackages.cabal-install
        haskellPackages.ghc
        haskellPackages.hindent
        haskellPackages.hlint
        haskellPackages.styx
        haskellPackages.ghcid
        jetbrains.idea-community
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
  };
}
