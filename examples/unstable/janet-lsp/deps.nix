{ fetchgit }:

[
  {
    name = "spork";
    src = fetchgit {
      url = "https://github.com/janet-lang/spork.git";
      rev = "4c77afc17eb5447a1ae06241478afe11f7db607d";
      hash = "sha256-nYSCWX262nhWn9hfd+kqnkH8ydN+DYg/XbCmGkozYZM=";
    };
    deps = [ ];
  }
  {
    name = "judge";
    src = fetchgit {
      url = "https://github.com/ianthehenry/judge.git";
      rev = "10754df781b34068e05291951db786933ec6b681";
      hash = "sha256-1zvr1WsllZFeKPb4EgdvTpp67lo1T/M8dEXGNHzOHj0=";
    };
    deps = [
      {
        name = "cmd";
        src = fetchgit {
          url = "https://github.com/ianthehenry/cmd";
          rev = "v1.1.0";
          hash = "sha256-FG11D8/+ZDHudi6PXy0tKFYCbHUyy0KOqMoZJyFCm9s=";
        };
        deps = [ ];
      }
    ];
  }
  {
    name = "jayson";
    src = fetchgit {
      url = "https://github.com/CFiggers/jayson.git";
      rev = "4f54041617340c8ff99bc1e6b285b720184965e2";
      hash = "sha256-961JRjy/JB0mDGTVbMofBf6vwu95TcUnnb7GxYkQ9EI=";
    };
    deps = [ ];
  }
  {
    name = "cmd";
    src = fetchgit {
      url = "https://github.com/CFiggers/cmd.git";
      rev = "5b9d97d404733dfc32b35c7683940f7031de4bf1";
      hash = "sha256-N4ct9H/0sx//2ml/b4HaY57FF7Dit1ogD0NuRbXmu04=";
    };
    deps = [ ];
  }
]
