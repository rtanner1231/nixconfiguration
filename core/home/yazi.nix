{ ... }:
{
  programs.yazi = {
    enable = true;
    keymap = {
      manager.prepend_keymap = [
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
