{ pkgs, ... }: {
    programs.fuzzel = {
      enable = true;

      settings = {
        main = {
          font          = "jetBrainsMono NF ExtraBold:size=14,Symbols Nerd Font,Noto Color Emoji";
          terminal      = "${pkgs.foot}/bin/foot";
          layer         = "overlay";
        };
        border = {
          width = 10;
          radius = 0;
        };
        colors = {
          background      = "7fbbb3b3";# blue
          # border          = "e67e80ff";# red
          # selection       = "83c0927f";# aqua
          border          = "83c092ff";# aqua
          selection       = "e67e807f";# aqua
          
          text            = "293136ff";# black
          input           = "293136ff";# black
          placeholder     = "293136ff";# black
          match           = "293136ff";# black

          selection-match = "293136ff";# black
          selection-text  = "293136ff";# black
        };
      };
    };
}
