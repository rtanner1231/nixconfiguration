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

    userName = profile.git.userName;
    userEmail = profile.git.userEmail;

    aliases = {
      dt = "!git difftool --dir-diff --no-symlinks -t meld";
      mt = "!git mergetool -t meld";
    };

    delta = {
      enable = true;
      options = {
        navigate = true;
        light = false;
      };
    };

    extraConfig = {
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
}
