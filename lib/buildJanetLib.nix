{ pkgs }:

{
  pname,
  version,
  src,
  depsFile,
  doCheck ? false,
  deps ? pkgs.callPackage depsFile { },
}:
let
  stdenv = pkgs.stdenv;

  # vendor is drv.
  vendor = pkgs.callPackage ./vendor {
    vendorPaths = pkgs.callPackage ./vendor/calc-vendor-paths.nix { dep-sources = deps; };
  };
in
stdenv.mkDerivation {
  inherit pname version src;

  buildInputs = [
    pkgs.janet
    pkgs.jpm
    pkgs.git
    vendor
  ];

  JANET_PATH = "${pkgs.janet}/lib";
  JANET_LIBPATH = "${pkgs.janet}/lib";
  JANET_MODPATH = "${vendor}/lib";

  buildPhase = ''
    jpm install --local
  '';

  installPhase = ''
    mkdir $out
    cp -r jpm_tree/* $out
  '';

  configurePhase =
    if doCheck then
      ''
        jpm test
      ''
    else
      "";
}
