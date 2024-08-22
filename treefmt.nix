{
  projectRootFile = "treefmt.nix";
  programs.nixpkgs-fmt.enable = true;
  programs.shellcheck.enable = true;
  programs.actionlint.enable = true;

  settings.formatter.shellcheck.excludes = [ ".envrc" ];
}
