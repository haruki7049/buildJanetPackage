{
  pkgs ?
    import
      (builtins.fetchTarball "https://github.com/NixOS/nixpkgs/archive/36a9aeaaa17a2d4348498275f9fe530cd4f9e519.tar.gz")
      { },
}:

let
  stdenv = pkgs.stdenv;
  lib = pkgs.lib;

  deps = import ./deps.nix;

  deps-fetcher = { name, url, hash }: stdenv.mkDerivation {
    inherit name;

    src = pkgs.fetchurl {
      inherit url hash;
    };

    buildInputs = [
      pkgs.janet
      pkgs.jpm
    ];

    buildPhase = ''
      jpm install --local
    '';

    installPhase = ''
      mkdir -p $out/lib
      cp -r jpm_tree/lib/* $out/lib
    '';
  };

  vendors = builtins.listToAttrs (map (v: { name = v.name; value = deps-fetcher { inherit (v) name url hash; }; }) deps);

  vendor = stdenv.mkDerivation {
    name = "vendor";

    src = lib.cleanSource ./.;

    dontBuild = true;

    installPhase = ''
      mkdir -p $out/lib
      cp -r ${vendors.spork}/lib/* $out/lib
      cp -r ${vendors.jpm}/lib/* $out/lib
    '';
  };
in

stdenv.mkDerivation rec {
  pname = "deps-parser";
  version = "0.1.0";
  src = lib.cleanSource ./.;

  buildInputs = [
    pkgs.janet
    pkgs.jpm
    vendor
  ];

  JANET_PATH = "${pkgs.janet}/lib";
  JANET_LIBPATH = "${pkgs.janet}/lib";
  JANET_MODPATH = "${vendor}/lib";

  buildPhase = ''
    jpm build
  '';

  installPhase = ''
    mkdir -p $out/bin
    install -m755 build/${pname} $out/bin/${pname}
  '';
}
