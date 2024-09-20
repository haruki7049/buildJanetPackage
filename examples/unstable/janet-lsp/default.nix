{
  pkgs ? import <nixpkgs> { },
}:

let
  janetBuilder = import ../../.. { inherit pkgs; };
in
janetBuilder.buildJanetLib {
  pname = "janet-lsp";
  version = "0.0.7";
  src = pkgs.fetchgit {
    url = "https://github.com/cfiggers/janet-lsp";
    rev = "204e22c74f328173cc4f83b80b7b06ec4afb6f19";
    hash = "sha256-hda4pEj5VsQsvTPLEYI34kE5iL8cldMzthpsl2jmU7U=";
    deepClone = true;
  };
  depsFile = ./deps.nix;
}
