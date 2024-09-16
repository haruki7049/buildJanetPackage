{
  pkgs ?
    import
      (builtins.fetchTarball "https://github.com/NixOS/nixpkgs/archive/36a9aeaaa17a2d4348498275f9fe530cd4f9e519.tar.gz")
      { },
}:

let
  janetBuilder = import ../../default.nix { inherit pkgs; };
in
janetBuilder.buildJanetPackage rec {
  pname = "janet-lsp";
  version = "0.0.7";
  src = pkgs.fetchFromGitHub {
    owner = "CFiggers";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-hda4pEj5VsQsvTPLEYI34kE5iL8cldMzthpsl2jmU7U=";
  };
  depsFile = ./deps.nix;
}
