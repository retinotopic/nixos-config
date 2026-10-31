{ config, pkgs-unstable, inputs, ... }: {
  pkgs-wrapped.fuzzel = (inputs.wrappers.wrapperModules.fuzzel.apply {
    pkgs = pkgs-unstable;

    settings = {
      main = {
        font          = "jetBrainsMono NF ExtraBold:size=14,Symbols Nerd Font,Noto Color Emoji";
        terminal      = "${config.pkgs-wrapped.foot}/bin/foot";
        layer         = "overlay";
      };
      border = {
        width = 10;
        radius = 0;
      };
      colors = {
        background      = "7fbbb3bf";# blue
        # border          = "e67e80ff";# red
        # selection       = "83c0927f";# aqua
        border          = "83c092bf";# aqua
        selection       = "e67e807f";# red
        
        text            = "424b50ff";# black
        input           = "424b50ff";# black
        placeholder     = "424b50ff";# black
        match           = "424b50ff";# black

        selection-match = "424b50ff";# black
        selection-text  = "424b50ff";# black
      };
    };
  }).wrapper;
}
