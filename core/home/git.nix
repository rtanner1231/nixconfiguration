{ pkgs, profile, ... }:
{
  home.packages = with pkgs; [
    delta
    gh
    meld
    git-credential-oauth
  ];

  programs.lazygit = {
    enable = true;
    settings = {
      git = {
        paging = [
          {
            colorArg = "always";
            pager = "delta --dark --paging=never";
          }
        ];
      };
    };
  };

  programs.git = {
    enable = true;

    settings = {
      user = {
        name = profile.git.userName;
        email = profile.git.userEmail;
      };

      alias = {
        dt = "!git difftool --dir-diff --no-symlinks -t meld";
        mt = "!git mergetool -t meld";
      };

      diff.tool = "meld";
      # interactive = {
      #   diffFilter = "delta --color-only";
      # };
      diff = {
        colorMoved = "default";
      };

      core = {
        editor = "nvim";
      };

      merge.conflictstyle = "diff3";

      difftool.prompt = false;

      mergetool.keepBackup = false;

      credential.helper = [
        "store"
      ];

      "credential.https://bitbucket.org" = {
        helper = "oauth";
        useHttpPath = true;
      };

      "credential.https://github.com" = {
        helper = "!${pkgs.gh}/bin/gh auth git-credential";
      };
      "credential.https://gist.github.com" = {
        helper = "!${pkgs.gh}/bin/gh auth git-credential";
      };
    };

  };

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
    options = {
      navigate = true;
      light = false;
    };
  };
}
