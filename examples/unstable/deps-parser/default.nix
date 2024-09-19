{
  pkgs ?
    import
      (builtins.fetchTarball "https://github.com/NixOS/nixpkgs/archive/36a9aeaaa17a2d4348498275f9fe530cd4f9e519.tar.gz")
      { },
}:

let
  janetBuilder = import ../../../default.nix { inherit pkgs; };
  lib = pkgs.lib;
in
janetBuilder.buildJanetPackage {
  pname = "deps-parser";
  version = "0.1.0";
  src = lib.cleanSource ./.;
  depsFile = ./deps.nix;
}
