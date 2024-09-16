{
  pkgs,
  lib ? pkgs.lib,
  stdenv ? pkgs.stdenv,
  deps,
}:

let
  deps-fetcher =
    {
      name,
      url,
      hash,
    }:
    stdenv.mkDerivation {
      inherit name;

      src = pkgs.fetchurl { inherit url hash; };

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

  vendorSet = builtins.listToAttrs (
    map (v: {
      name = v.name;
      value = deps-fetcher { inherit (v) name url hash; };
    }) deps
  );

  vendorPaths = map (v: v.outPath) (builtins.attrValues vendorSet);
in

stdenv.mkDerivation {
  name = "vendor";

  src = lib.cleanSource ./.;

  dontBuild = true;

  installPhase = ''
    mkdir -p $out/lib
    ${lib.strings.concatLines (map (v: "cp -r ${v}/lib/* $out/lib") vendorPaths)}
  '';
}
