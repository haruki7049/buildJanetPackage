{ pkgs, dep-sources }:

let
  deps-fetcher =
    {
      name,
      src,
    }:
    pkgs.stdenv.mkDerivation {
      inherit name src;

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
      value = deps-fetcher {
        inherit (v)
          name
          src
          ;
      };
    }) dep-sources
  );
in

map (v: v.outPath) (builtins.attrValues vendorSet)
