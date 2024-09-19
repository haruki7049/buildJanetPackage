{
  pkgs,
  pname,
  executableFiles,
  binscriptFiles,
  doCheck,
  vendor,
}:

let
  lib = pkgs.lib;
  length = builtins.length;
in

{
  installPhase =
    "mkdir -p $out/bin\n"
    + (
      if length executableFiles != 0 && length binscriptFiles != 0 then
        throw "TODO: using binscriptFiles and executableFiles is not implemented"
      else if length executableFiles != 0 && length binscriptFiles == 0 then
        ''
          ${lib.strings.concatLines (map (v: "install -m755 build/${v} $out/bin/${v}") executableFiles)}
        ''
      else if length executableFiles == 0 && length binscriptFiles != 0 then
        ''
          ${lib.strings.concatLines (map (v: "install -m755 jpm_tree/bin/${v} $out/bin/${v}") binscriptFiles)}
        ''
      else
        ''
          install -m755 build/${pname} $out/bin/${pname}
        ''
    );

  buildPhase =
    if length binscriptFiles != 0 then
      ''
        mkdir -p jpm_tree/lib
        cp -r ${vendor}/lib/* jpm_tree/lib
        jpm install --local
      ''
    else
      ''
        jpm build
      '';

  configurePhase =
    if doCheck then
      ''
        jpm test
      ''
    else
      "";

  JANET_MODPATH = "${vendor}/lib";
}
