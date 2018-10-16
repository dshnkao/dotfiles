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
  };
}
