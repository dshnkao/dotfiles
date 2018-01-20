{
  allowUnfree = true;
  packageOverrides = pkgs: rec {

    coreEnv = with pkgs; buildEnv {
      name = "coreEnv";
      paths = [
        exa
        fd
        feh
        fzf
        nix-prefetch-git
        nix-prefetch-scripts
        nix-repl
        pass
        ranger
        ripgrep
        rofi
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
        cargo
        clojure
        go
        gradle
        kotlin
        leiningen
        maven
        nodejs
        rustc
      ];
    };
  };
}
