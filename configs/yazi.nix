{
  programs.yazi = {
    enable = true;
    # flavors = {
    #   everforest = ./everforest.yazi;
    # };
    theme = {
      mgr = {
        cwd = { fg = "#a7c080"; }; # Soft Green
        # Hovered
        hovered = { fg = "#424b50"; bg = "#7fbbb3"; }; # Dark background, Aqua foreground
        preview_hovered = { underline = true; };
        # Find
        find_keyword = { fg = "#83c092"; italic = true; };                # Aqua
        find_position = { fg = "#e67e80"; bg = "reset"; italic = true; }; # Soft red
        # Marker
        marker_selected = { fg = "#a7c080"; bg = "#a7c080"; }; # Soft Green
        marker_copied = { fg = "#83c092"; bg = "#83c092"; };   # Aqua
        marker_cut = { fg = "#e67e80"; bg = "#e67e80"; };      # Soft red
        marker_marked   = { fg = "#dbbc7f"; bg = "#dbbc7f"; };

        # Tab
        tab_active = { fg = "#424b50"; bg = "#83c092"; };   # Dark background; Aqua foreground
        tab_inactive = { fg = "#a7c080"; bg = "#424b50"; }; # Soft Green on dark
        tab_width = 1;
        # Border
        border_symbol = "│";
        border_style = { fg = "#e67e80"; }; # Red

        count_copied   = { fg = "#eff1f5"; bg = "#40a02b"; };
        count_cut      = { fg = "#eff1f5"; bg = "#d20f39"; };
        count_selected = { fg = "#eff1f5"; bg = "#df8e1d"; };

        # Highlighting
        syntect_theme = ./everforest.yazi/everforest.tmTheme;
        
      };
      status = {
        sep_left = { open = ""; close = ""; };
        sep_right = { open = ""; close = ""; };
        separator_open = "";
        separator_close = "";
        separator_style = { fg = "#424b50"; bg = "#424b50"; }; # dark
        # Mode
        mode_normal = { fg = "#424b50"; bg = "#83c092"; bold = true; }; # Dark background, Aqua foreground
        mode_select = { fg = "#424b50"; bg = "#a7c080"; bold = true; }; # Dark background, Soft Green foreground
        mode_unset = { fg = "#424b50"; bg = "#e67e80"; bold = true; };  # Dark background, Soft red foreground
        # Progress
        progress_label = { fg = "#ffffff"; bold = true; };
        progress_normal = { fg = "#83c092"; bg = "#424b50"; }; # Aqua on dark
        progress_error = { fg = "#e67e80"; bg = "#424b50"; };  # Soft red on dark
        # Permissions
        permissions_t = { fg = "#83c092"; }; # Aqua
        permissions_r = { fg = "#7fbbb3"; }; # Blue
        permissions_w = { fg = "#e67e80"; }; # Red
        permissions_x = { fg = "#a7c080"; }; # Green
        permissions_s = { fg = "#d699b6"; }; # Pink
      };
      input = {
        border = { fg = "#83c092"; };    # Aqua
        title = {};
        value = {};
        selected = { reversed = true; };
      };
      select = {
        border = { fg = "#7fbbb3"; }; # Blue;
        active = { fg = "#e67e80"; }; # Soft red;
        inactive = {};
      };
      tasks = {
        border = { fg = "#83c092"; };    # Aqua
        title = {};
        hovered = { underline = true; };
      };
      which = {
        mask = { bg = "#424b50"; };            # Dark background
        cand = { fg = "#a7c080"; };            # Soft Green
        rest = { fg = "#83c092"; };            # Aqua
        desc = { fg = "#e67e80"; };            # Soft red
        separator = "  ";
        separator_style = { fg = "#424b50"; }; # dark
      };
      help = {
        on = { fg = "#e67e80"; };                     # Soft red
        run = { fg = "#a7c080"; };                   # Soft Green
        desc = { fg = "#83c092"; };                   # Aqua
        hovered = { bg = "#424b50"; bold = true; };   # dark background
        footer = { fg = "#424b50"; bg = "#83c092"; }; # Dark background, Aqua foreground
      };
      filetype = {
        rules = [
          # Images
          { mime = "image/*"; fg = "#a7c080"; } # Soft Green
          # Videos
          { mime = "video/*"; fg = "#83c092"; } # Aqua
          { mime = "audio/*"; fg = "#83c092"; } # Aqua
          # Archives
          { mime = "application/zip"; fg = "#e67e80"; }             # Soft red
          { mime = "application/gzip"; fg = "#e67e80"; }            # Soft red
          { mime = "application/x-tar"; fg = "#e67e80"; }           # Soft red
          { mime = "application/x-bzip"; fg = "#e67e80"; }          # Soft red
          { mime = "application/x-bzip2"; fg = "#e67e80"; }         # Soft red
          { mime = "application/x-7z-compressed"; fg = "#e67e80"; } # Soft red
          { mime = "application/x-rar"; fg = "#e67e80"; }           # Soft red
          # Fallback
          { name = "*"; fg = "#83c092"; }  # Aqua
          { name = "*/"; fg = "#83c092"; } # Aqua
        ];
      };
    };

    
  };
}
