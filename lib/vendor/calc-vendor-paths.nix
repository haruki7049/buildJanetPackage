{ pkgs, dep-sources }:

let
  deps-fetcher =
    {
      name,
      src,
      deps,
    }:
    let
      vendor =
        if builtins.length deps != 0 then
          pkgs.callPackage ./default.nix {
            vendorPaths = pkgs.callPackage ./calc-vendor-paths.nix { dep-sources = deps; };
          }
        else
          null;
    in
    pkgs.stdenv.mkDerivation {
      inherit name src;

      buildInputs = [
        pkgs.janet
        pkgs.jpm
        vendor
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
      value = deps-fetcher { inherit (v) name src deps; };
    }) dep-sources
  );
in

map (v: v.outPath) (builtins.attrValues vendorSet)
