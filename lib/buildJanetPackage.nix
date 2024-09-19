{ pkgs }:

{
  buildJanetPackage =
    {
      pname,
      version,
      src,
      depsFile,
      doCheck ? false,
      deps ? pkgs.callPackage depsFile { },
      executableFiles ? [ ], # [ "executable-bin" "test-bin" ]
    }:
    let
      stdenv = pkgs.stdenv;
      lib = pkgs.lib;

      # vendor is drv.
      vendor = pkgs.callPackage ./vendor {
        vendorPaths = pkgs.callPackage ./vendor/calc-vendor-paths.nix { dep-sources = deps; };
      };
    in
    stdenv.mkDerivation {
      inherit pname version src;

      buildInputs = [
        pkgs.janet
        pkgs.jpm
        pkgs.git
        vendor
      ];

      JANET_PATH = "${pkgs.janet}/lib";
      JANET_LIBPATH = "${pkgs.janet}/lib";
      JANET_MODPATH = "${vendor}/lib";

      configurePhase =
        if doCheck then
        ''
          jpm test
        ''
        else
        "";

      buildPhase = ''
        jpm build
      '';

      installPhase =
        if builtins.length executableFiles != 0 then
        ''
          mkdir -p $out/bin
          ${lib.strings.concatLines (map (v: "install -m755 build/${v} $out/bin/${v}") executableFiles)}
        ''
        else
        ''
          mkdir -p $out/bin
          install -m755 build/${pname} $out/bin/${pname}
        '';
    };
}
