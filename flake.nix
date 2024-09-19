{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    treefmt-nix.url = "github:numtide/treefmt-nix";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
      treefmt-nix,
      ...
    }:
    {
      buildJanetPackage = pkgs: import ./lib/buildJanetPackage.nix { inherit pkgs; };
    }
    // flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
        treefmtEval = treefmt-nix.lib.evalModule pkgs ./treefmt.nix;
        examples = {
          simple = pkgs.callPackage ./examples/unstable/simple/default.nix { };
          http-server = pkgs.callPackage ./examples/unstable/http-server/default.nix { };
          deps-parser = pkgs.callPackage ./examples/unstable/deps-parser/default.nix { };
          simple-v0-1-0 = pkgs.callPackage ./examples/v0.1.0/simple/default.nix { };
        };
      in
      {
        formatter = treefmtEval.config.build.wrapper;

        checks = {
          formatting = treefmtEval.config.build.check self;
          inherit (examples)
            simple
            simple-v0-1-0
            http-server
            deps-parser
            ;
        };

        devShells.default = pkgs.mkShell {
          packages = [
            # Nix
            pkgs.nil

            # Janet
            pkgs.janet
            pkgs.jpm
          ];
        };
      }
    );
}
