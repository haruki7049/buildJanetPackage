{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    buildJanetPackage.url = "../..";
  };

  outputs = { nixpkgs, flake-utils, buildJanetPackage, ... }:
    flake-utils.lib.eachSystem [ "x86_64-linux" ] (system:
      let
        pkgs = import nixpkgs { inherit system; };
        janetBuilder = import buildJanetPackage { inherit pkgs; };

        simple-flakes = janetBuilder.buildJanetPackage {
          pname = "http-server";
          version = "0.1.0";
          src = ./.;
        };
      in
      {
        devShells.default = pkgs.mkShell {
          packages = [
            pkgs.janet
            pkgs.jpm
          ];
        };

        packages = {
          inherit simple-flakes;
          default = simple-flakes;
        };
      });
}
