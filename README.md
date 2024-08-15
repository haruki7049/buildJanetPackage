# buildJanetPackage

## Usage
```bash
nix build .#example
```

Write below files:

```nix
# flake.nix

{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    buildJanetPackage.url = "github:haruki7049/buildJanetPackage";
  };

  outputs = { nixpkgs, flake-utils, buildJanetPackage, ... }:
    flake-utils.lib.eachSystem [ "x86_64-linux" ] (system:
      let
        pkgs = import nixpkgs { inherit system; };
        janetBuilder = import buildJanetPackage { inherit pkgs; };

        example = janetBuilder.buildJanetPackage {
          pname = "example";
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
          inherit example;
          default = example;
        };
      });
}
```
```janet
# main.janet

(defn main
  [& args]
  (print "example"))
```
```janet
# project.janet
(declare-project
  :name "example")

(declare-executable
  :name "example"
  :entry "main.janet"
  :install true)
```

# Example
See ./examples/
