# buildJanetPackage

## Usage
Write below files, then use `nix build .#http-server`

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
        lib = pkgs.lib;
        janetBuilder = import buildJanetPackage { inherit pkgs; };

        http-server = janetBuilder.buildJanetPackage {
          pname = "http-server";
          version = "0.1.0";
          src = lib.cleanSource ./.;
          depsFile = ./deps.nix;
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
          inherit http-server;
          default = http-server;
        };
      });
}
```
```nix
# deps.nix

[
  {
    name = "circlet";
    url = "https://github.com/janet-lang/circlet/archive/2e84f542bffde5e0b08789a804fa80f2ebe5771e.tar.gz";
    hash = "sha256-amG8h214LkUxaWDP70n1io2CuifHOyZuz/wIxO1zPes=";
  }
]
```
```janet
# main.janet

(import circlet)

(defn myserver
 "A simple HTTP server" [request]
 {:status 200
  :headers {"Content-Type" "text/html"} :body "<!doctype html><html><body><h1>Hello.</h1></body></html>"})

(defn main [& args]
  (circlet/server myserver 8000))
```
```janet
# project.janet

(declare-project
  :name "http-server"
  :dependencies ["https://github.com/janet-lang/circlet.git"])

(declare-executable
  :name "http-server"
  :entry "main.janet"
  :install true)
```

# Example
See ./examples/
