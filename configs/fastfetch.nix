{
  programs.fastfetch = {
      enable = true;
      settings = {
        logo = {
          type = "file";
          source = ./nixos.txt;
          color = {
              "1" = "blue";
              "2" = "cyan";
              "3" = "red";
              "4" = "yellow";
          };
        };
        modules = [
          "title"
          "separator"
          "os"
          "kernel"
          "shell"
          "wm"
          "cursor"
          "terminal"
          "colors"
        ];
      };  
    };
}
