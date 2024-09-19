{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
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
      perSystem =
        { pkgs, ... }:
        let
          zig = pkgs.zig_0_13;
        in
        {
          devShells.default = pkgs.mkShell {
            packages = [
              # Nix
              pkgs.nil

              # Ziglang
              zig
              pkgs.zls
            ];

            shellHook = ''
              export PS1="\n[nix-shell\w]$ "
            '';
          };
        };
    };
}
