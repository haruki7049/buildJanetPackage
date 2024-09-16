{ pkgs }:

{
  buildJanetPackage =
    {
      pname,
      version,
      src,
      depsFile,
      deps ? import depsFile,
    }:
    let
      stdenv = pkgs.stdenv;
      lib = pkgs.lib;

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

      vendor = stdenv.mkDerivation {
        name = "vendor";

        src = lib.cleanSource ./.;

        dontBuild = true;

        installPhase = ''
          mkdir -p $out/lib
          ${lib.strings.concatLines (map (v: "cp -r ${v}/lib/* $out/lib") vendorPaths)}
        '';
      };
    in
    stdenv.mkDerivation {
      inherit pname version src;

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
        install -m755 build/${pname} $out/bin/${pname}-${version}
      '';
    };
}
