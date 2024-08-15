{ pkgs }:

pkgs.callPackage ./lib/buildJanetPackage.nix { inherit pkgs; }
