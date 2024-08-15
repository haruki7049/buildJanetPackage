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
    };
}
