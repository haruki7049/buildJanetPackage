{
  pkgs ?
    import
      (builtins.fetchTarball "https://github.com/NixOS/nixpkgs/archive/36a9aeaaa17a2d4348498275f9fe530cd4f9e519.tar.gz")
      { },
}:

let
  janetBuilder = import ../../../default.nix { inherit pkgs; };
in
janetBuilder.buildJanetPackage {
  pname = "http-server";
  version = "0.1.0";
  src = ./.;
  depsFile = ./deps.nix;
}
