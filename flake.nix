{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    treefmt-nix.url = "github:numtide/treefmt-nix";
  };

  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "aarch64-darwin"
        "aarch64-linux"
        "x86_64-darwin"
        "x86_64-linux"
      ];
      imports = [ inputs.treefmt-nix.flakeModule ];

      flake = {
        buildJanetPackage = pkgs: import ./lib/buildJanetPackage.nix { inherit pkgs; };
      };

      perSystem =
        { pkgs, ... }:
        let
          examples = {
            simple = pkgs.callPackage ./examples/unstable/simple { };
            http-server = pkgs.callPackage ./examples/unstable/http-server { };
            deps-parser = pkgs.callPackage ./examples/unstable/deps-parser { };
            simple-v0-1-0 = pkgs.callPackage ./examples/v0.1.0/simple { };
          };
        in
        {
          treefmt = {
            projectRootFile = "flake.nix";
            programs.nixfmt.enable = true;
            programs.zig.enable = true;
            programs.shellcheck.enable = true;
            programs.actionlint.enable = true;

            settings.formatter.shellcheck.excludes = [
              ".envrc"
              "docs/pages/.envrc"
            ];
          };

          checks = {
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
        };
    };
}
