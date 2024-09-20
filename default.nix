{ pkgs }:

{
  buildJanetPackage = pkgs.callPackage ./lib/buildJanetPackage.nix { inherit pkgs; };
  buildJanetLib = pkgs.callPackage ./lib/buildJanetLib.nix { inherit pkgs; };
}
