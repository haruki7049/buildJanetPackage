{
  pkgs ? import <nixpkgs> { },
}:

let
  janetBuilder = import ../../.. { inherit pkgs; };
  lib = pkgs.lib;
in
janetBuilder.buildJanetLib {
  pname = "simple-lib";
  version = "0.1.0";
  src = lib.cleanSource ./.;
  depsFile = ./deps.nix;
}
