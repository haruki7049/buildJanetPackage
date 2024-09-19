{
  pkgs ?
    import
      (builtins.fetchTarball "https://github.com/NixOS/nixpkgs/archive/36a9aeaaa17a2d4348498275f9fe530cd4f9e519.tar.gz")
      { },
  buildJanetPackage-source ? builtins.fetchTarball "https://github.com/haruki7049/buildJanetPackage/archive/refs/tags/0.1.0.tar.gz",
}:

let
  janetBuilder = import buildJanetPackage-source { inherit pkgs; };
in
janetBuilder.buildJanetPackage {
  pname = "simple";
  version = "0.1.0";
  src = ./.;
}
