{ pkgs }:

{
  buildJanetPackage =
    {
      pname,
      version,
      src,
      depsFile,
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
        jpm build
      '';

      installPhase = ''
        mkdir -p $out/bin
        install -m755 build/${pname} $out/bin/${pname}
      '';
    };
}
