{
  pkgs,
  lib ? pkgs.lib,
  stdenv ? pkgs.stdenv,
  vendorPaths,
}:

stdenv.mkDerivation {
  name = "vendor";

  src = lib.cleanSource ./.;

  dontBuild = true;

  installPhase = ''
    mkdir -p $out/lib
    mkdir -p $out/bin
    ${lib.strings.concatLines (map (v: "cp -r ${v}/.* ${v}/* $out") vendorPaths)}
  '';
}
