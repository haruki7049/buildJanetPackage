{
  pkgs ?
    import
      (builtins.fetchTarball "https://github.com/NixOS/nixpkgs/archive/36a9aeaaa17a2d4348498275f9fe530cd4f9e519.tar.gz")
      { },
}:

let
  janetBuilder = import ../../../default.nix { inherit pkgs; };
in
janetBuilder.buildJanetPackage rec {
  pname = "janet-lsp";
  version = "0.0.7";
  src = pkgs.fetchgit {
    url = "https://github.com/CFiggers/${pname}";
    rev = "204e22c74f328173cc4f83b80b7b06ec4afb6f19";
    hash = "sha256-1rP8sZ9ymboCKRn/sTksu7rkfoyGaMGnXU8sbVTckJI=";
    leaveDotGit = true;
  };
  depsFile = ./deps.nix;
}
