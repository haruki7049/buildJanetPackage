{
  pkgs ?
    import
      (builtins.fetchTarball "https://github.com/NixOS/nixpkgs/archive/36a9aeaaa17a2d4348498275f9fe530cd4f9e519.tar.gz")
      { },
}:

let
  stdenv = pkgs.stdenv;
  lib = pkgs.lib;
  fetchFromGitHub = pkgs.fetchFromGitHub;
  spork = stdenv.mkDerivation rec {
    pname = "spork";
    version = "0-unstable-2024-09-12";

    src = fetchFromGitHub {
      owner = "janet-lang";
      repo = pname;
      rev = "253a67e89dca695632283ef60f77851311c404c9";
      hash = "sha256-+XZaTThLm75IsifMM0IAPasZwCv42MmI9+e2sy+jl1o=";
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

  vendor = stdenv.mkDerivation {
    name = "vendor";

    src = lib.cleanSource ./.;

    dontBuild = true;

    installPhase = ''
      mkdir -p $out/lib
      cp -r ${spork}/lib/* $out/lib
      cp -r ${pkgs.jpm}/lib/janet/* $out/lib
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
