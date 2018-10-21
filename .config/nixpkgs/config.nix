{
  allowUnfree = true;
  packageOverrides = pkgs: rec {
    # 1.8.16 has broken vpn connection
    networkmanagerapplet = pkgs.networkmanagerapplet.overrideAttrs (oldAttrs: rec {
      src = pkgs.fetchurl {
        url = "mirror://gnome/sources/network-manager-applet/1.8/network-manager-applet-1.8.18.tar.xz";
        sha256 = "0y31g0lxr93370xi74hbpvcy9m81n5wdkdhq8xy2nqp0y4219p13";
      };
    });
    postman = pkgs.postman.overrideAttrs (oldAttrs: rec {
      name = "postman-6.4.2";
      version = "6.4.2";
      src = pkgs.fetchurl {
        url = "https://dl.pstmn.io/download/version/${version}/linux64";
        sha256 = "03p1xc390m16x9rdbsd0a2j1f84rdvl9qjihf5vgqgp17nq9rcha";
        name = "${name}.tar.gz";
      };
    });
  };
}
