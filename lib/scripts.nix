{
  pkgs,
  pname,
  executableFiles,
  binscriptFiles,
}:

let
  lib = pkgs.lib;
in

{
  installPhase = "mkdir -p $out/bin\n"
    +
    (if builtins.length executableFiles != 0 && builtins.length binscriptFiles != 0 then
      throw "TODO: binscriptFiles is not implemented"
    else if builtins.length executableFiles != 0 && builtins.length binscriptFiles == 0 then
      ''
        ${lib.strings.concatLines (map (v: "install -m755 build/${v} $out/bin/${v}") executableFiles)}
      ''
    else if builtins.length executableFiles == 0 && builtins.length binscriptFiles != 0 then
      throw "TODO: binscriptFiles is not implemented"
    else
      ''
        install -m755 build/${pname} $out/bin/${pname}
      '');
}
