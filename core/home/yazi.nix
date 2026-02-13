{ ... }:
{
  programs.yazi = {
    enable = true;
    settings = {
      opener = {
        kate = [
          {
            run = "kate \"$@\"";
            orphan = true;
            desc = "Kate";
          }
        ];
        calc = [
          {
            run = "libreoffice --calc \"$@\"";
            orphan = true;
            desc = "LibreOffice Calc";
          }
        ];
      };
      open = {
        rules = [
          {
            mime = "text/*";
            use = [
              "edit"
              "kate"
              "calc"
            ];
          }
          {
            url = "*.csv";
            use = [
              "calc"
              "kate"
            ];
          }
        ];
      };
    };
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
        {
          on = [ "<Enter>" ];
          run = "shell 'if [ -d \"$1/.git\" ]; then nohup meld \"$1\" > /dev/null 2>&1 & else ya emit enter; fi'";
          desc = "Open git repo in Meld, otherwise enter directory";
        }
      ];
    };
  };
}
