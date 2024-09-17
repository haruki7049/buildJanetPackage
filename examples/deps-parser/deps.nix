{ fetchgit }:

[
  {
    name = "spork";
    src = fetchgit {
      url = "https://github.com/janet-lang/spork";
      rev = "253a67e89dca695632283ef60f77851311c404c9";
      hash = "sha256-I5cOrJ9/3p2LAimQxnJR6etdxvLuZFfundOucgz5nok=";
    };
    deps = [ ];
  }
  {
    name = "jpm";
    src = fetchgit {
      url = "https://github.com/janet-lang/jpm";
      rev = "d93b7c243645d31410a81fb9ab8f7a5e5608f0d0";
      hash = "sha256-MslOSQ2ZOajk7GHU+lHQM1tznswjkzC8mQc6c3QpPIA=";
    };
    deps = [ ];
  }
]
