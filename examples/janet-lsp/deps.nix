{ fetchgit }:

[
  {
    name = "spork";
    src = fetchgit {
      url = "https://github.com/janet-lang/spork";
      rev = "253a67e89dca695632283ef60f77851311c404c9";
      hash = "sha256-OnfD1w4KCKAQ101+NehSWOdDGgHjhdctb9AXHNzo/28=";
    };
    deps = [ ];
  }
  {
    name = "cmd";
    src = fetchgit {
      url = "https://github.com/CFiggers/cmd";
      rev = "5b9d97d404733dfc32b35c7683940f7031de4bf1";
      hash = "sha256-ZyPpPNF/wtjQcxVrre+KwmfghH31dK1f9jTDH4htn4U=";
    };
    deps = [ ];
  }
  {
    name = "jayson";
    src = fetchgit {
      url = "https://github.com/CFiggers/jayson";
      rev = "4f54041617340c8ff99bc1e6b285b720184965e2";
      hash = "sha256-5HduXYKq4okuaFrnVfGOEOtLLabVYasANsHFOU2lC00=";
    };
    deps = [ ];
  }
  {
    name = "judge";
    src = fetchgit {
      url = "https://github.com/ianthehenry/judge";
      rev = "10754df781b34068e05291951db786933ec6b681";
      hash = "sha256-Idl0I+sXV8/XsRme2qo7wPHbJhUyRZ+1xbyGRiziot4=";
    };
    deps = [
      {
        name = "cmd";
        src = fetchgit {
          url = "https://github.com/ianthehenry/cmd";
          rev = "b4308de361d0f90dd96cc0f9a8dc6881e0e851c6";
          hash = "sha256-FG11D8/+ZDHudi6PXy0tKFYCbHUyy0KOqMoZJyFCm9s=";
        };
        deps = [ ];
      }
    ];
  }
]
