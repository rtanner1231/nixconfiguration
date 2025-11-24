{ ... }:
{
  programs.yazi = {
    enable = true;
    keymap = {
      mgr.prepend_keymap = [
        {
          on = [
            "z"
            "a"
          ];
          run = "shell 'zoxide add \"$0\"'";
          desc = "Add directory to zoxide";
        }
      ];
    };
  };
}
