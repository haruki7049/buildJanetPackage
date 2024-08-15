{ pkgs }:

let
  stdenv = pkgs.stdenv;
in
{
  buildJanetPackage =
    { pname
    , version
    , src
    }:
    stdenv.mkDerivation {
      inherit pname version src;

      buildInputs = [
        pkgs.janet
        pkgs.jpm
      ];

      JANET_LIBPATH = "${pkgs.janet}/lib";

      buildPhase = ''
        jpm build
      '';

      installPhase = ''
        mkdir -p $out/bin
        install -m755 build/${pname} $out/bin/${pname}-${version}
      '';
    };
}
