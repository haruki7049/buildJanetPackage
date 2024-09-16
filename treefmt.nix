{
  projectRootFile = "treefmt.nix";
  programs.nixfmt.enable = true;
  programs.shellcheck.enable = true;
  programs.actionlint.enable = true;

  settings.formatter.shellcheck.excludes = [ ".envrc" ];
}
