{
  programs.fastfetch = {
      enable = true;
      settings = {
        logo = {
          type = "file";
          source = ./nixos.txt;
          color = {
              "1" = "white";
              "2" = "blue";
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
