{
  programs.foot = {
    enable = true;
    server.enable = true;
    settings = {
      colors = {
        alpha = "0.6";
        background = "323d43";
        foreground = "d3c6aa";
        
        regular0 = "505a60"; # black
        regular1 = "e67e80"; # red
        regular2 = "a7c080"; # green
        regular3 = "dbbc7f"; # yellow
        regular4 = "7fbbb3"; # blue
        regular5 = "d699b6"; # magenta
        regular6 = "83c092"; # cyan
        regular7 = "d3c6aa"; # white
        
        bright0 = "4b565c"; # black
        bright1 = "e67e80"; # red
        bright2 = "a7c080"; # green
        bright3 = "dbbc7f"; # yellow
        bright4 = "7fbbb3"; # blue
        bright5 = "d699b6"; # magenta
        bright6 = "83c092"; # cyan
        bright7 = "d3c6aa"; # white
      };
      main = {
        font = "jetBrainsMono NF ExtraBold:size=11,Symbols Nerd Font,Noto Color Emoji";
        dpi-aware = "yes";
        shell = "fish";
      };
    };
  };
}
