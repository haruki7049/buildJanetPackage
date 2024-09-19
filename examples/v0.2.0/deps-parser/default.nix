{
  pkgs ?
    import
      (builtins.fetchTarball "https://github.com/NixOS/nixpkgs/archive/36a9aeaaa17a2d4348498275f9fe530cd4f9e519.tar.gz")
      { },
  buildJanetPackage-source ? builtins.fetchTarball {
    url = "https://github.com/haruki7049/buildJanetPackage/archive/refs/tags/0.2.0.tar.gz";
    sha256 = "0kvqk7a5xjir11vqimvkc9h995h8b1cl0hjs4855phhyxz1960q4";
  },
}:

let
  janetBuilder = import buildJanetPackage-source { inherit pkgs; };
  lib = pkgs.lib;
in
janetBuilder.buildJanetPackage {
  pname = "deps-parser";
  version = "0.1.0";
  src = lib.cleanSource ./.;
  depsFile = ./deps.nix;
}
