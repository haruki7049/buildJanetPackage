{ fetchgit }:

[
  {
    name = "spork";
    src = fetchgit {
      url = "https://github.com/janet-lang/spork";
      rev = "253a67e89dca695632283ef60f77851311c404c9";
      hash = "sha256-+XZaTThLm75IsifMM0IAPasZwCv42MmI9+e2sy+jl1o=";
    };
    deps = [ ];
  }
  {
    name = "jpm";
    src = fetchgit {
      url = "https://github.com/janet-lang/jpm";
      rev = "d93b7c243645d31410a81fb9ab8f7a5e5608f0d0";
      hash = "sha256-dXu6r+mSS3p7nsOmwfoJH2Sc9okU1S7wYRswdEmSJfg=";
    };
    deps = [ ];
  }
]
