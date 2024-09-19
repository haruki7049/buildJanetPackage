{
  pkgs ?
    import
      (builtins.fetchTarball "https://github.com/NixOS/nixpkgs/archive/36a9aeaaa17a2d4348498275f9fe530cd4f9e519.tar.gz")
      { },
  buildJanetPackage-source ? builtins.fetchTarball {
    url = "https://github.com/haruki7049/buildJanetPackage/archive/refs/tags/0.1.0.tar.gz";
    sha256 = "17pwy76lv0jn6ynm1051zlfcj4lk5q108wn4i69d7m0jgrwpw7nb";
  },
}:

let
  janetBuilder = import buildJanetPackage-source { inherit pkgs; };
in
janetBuilder.buildJanetPackage {
  pname = "simple";
  version = "0.1.0";
  src = ./.;
}
