{
  pkgs,
  dep-sources,
}:

let
  deps-fetcher =
    {
      name,
      url,
      hash,
    }:
    pkgs.stdenv.mkDerivation {
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
    }) dep-sources
  );
in

map (v: v.outPath) (builtins.attrValues vendorSet)
