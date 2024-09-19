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
  pname = "spork";
  version = "0.1.0";
  src = pkgs.fetchgit {
    url = "https://github.com/janet-lang/spork";
    rev = "4c77afc17eb5447a1ae06241478afe11f7db607d";
    hash = "sha256-nYSCWX262nhWn9hfd+kqnkH8ydN+DYg/XbCmGkozYZM=";
  };
  depsFile = ./deps.nix;

  binscriptFiles = [
    "janet-format"
    "janet-netrepl"
  ];
}
