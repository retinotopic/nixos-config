{
  programs.yazi = {
    enable = true;
    # flavors = {
    #   everforest = ./everforest.yazi;
    # };
    theme = {
      mgr = {
        cwd = { fg = "#d3c6aa"; }; # Soft Green
        # Hovered
        hovered = { fg = "#424b50"; bg = "#83c092"; }; # Dark background, Aqua foreground
        preview_hovered = { underline = true; };
        # Find
        find_keyword = { fg = "#83c092"; italic = true; };                # Aqua
        find_position = { fg = "#e67e80"; bg = "reset"; italic = true; }; # Soft red
        # Marker
        marker_selected = { fg = "#a7c080"; bg = "#a7c080"; }; # Soft Green
        marker_copied = { fg = "#83c092"; bg = "#7fbbb3"; };   # Aqua
        marker_cut = { fg = "#e67e80"; bg = "#e67e80"; };      # Soft red
        marker_marked   = { fg = "#dbbc7f"; bg = "#dbbc7f"; };

        # Tab
        # tab_active = { fg = "#424b50"; bg = "#83c092"; bold = true; };   # Dark background; Aqua foreground
        # tab_inactive = { fg = "#424b50"; bg = "#dbbc7f"; }; # Soft Green on dark
        # tab_width = 1;
        # Border
        border_symbol = "┃";
        # border_symbol = "│";
        border_style = { fg = "#83c092"; }; # Red

        count_copied   = { fg = "#424b50"; bg = "#83c092"; };
        count_cut      = { fg = "#424b50"; bg = "#e67e80"; };
        count_selected = { fg = "#424b50"; bg = "#a7c080"; };

        # Highlighting
        syntect_theme = ./everforest.yazi/everforest.tmTheme;
        
      };
      tabs = {
        active   = { fg = "#e67e80"; bg = "#d3c6aa"; bold = true; };
        inactive = { fg = "#d3c6aa"; bg = "#e67e80"; };
        sep_inner = { open = ""; close = ""; };
        sep_outer = { open = ""; close = ""; };
      };
      mode = {
        normal_main = { fg = "#e67e80"; bg = "#d3c6aa"; bold = true; };
        normal_alt  = { fg = "#d3c6aa"; bg = "#e67e80"; };

        # Select mode
        select_main = { fg = "#e67e80"; bg = "#d3c6aa"; bold = true; };
        select_alt  = { fg = "#d3c6aa"; bg = "#e67e80"; };

        # Unset mode
        unset_main = { fg = "#e67e80"; bg = "#d3c6aa"; bold = true; };
        unset_alt  = { fg = "#d3c6aa"; bg = "#e67e80"; };

      };
      status = {
        overall = { fg = "#d3c6aa"; }; # Aqua on dark
        sep_left = { open = ""; close = ""; };
        sep_right = { open = ""; close = ""; };
        # Progress
        progress_label = { fg = "#d3c6aa"; };
        progress_normal = { fg = "#d3c6aa";  }; # Aqua on dark
        progress_error = { fg = "#d3c6aa";  };  # Soft red on dark
        # Permissions
        perm_type = { fg = "#d3c6aa"; }; # Aqua
        perm_read = { fg = "#d3c6aa"; }; # Blue
        perm_write = { fg = "#d3c6aa"; }; # Red
        perm_exec = { fg = "#d3c6aa"; }; # Green
        perm_sep = { fg = "#d3c6aa"; }; # dark
      };
      input = {
        border = { fg = "#83c092"; };    # Aqua
        title = {};
        value = {};
        selected = { reversed = true; };
      };
      cmp = {
        border = { fg = "#424b50"; };
      };
      pick = {
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
      notify = {
        title_info = { fg = "#7fbbb3"; };
        title_warn = { fg = "#dbbc7f"; };
        title_error = { fg = "#e67e80"; };
      };
      filetype = {
        rules = [
          # Images #a7c080
          { mime = "image/*"; fg = "#a7c080"; } # Soft Green
          # Videos
          { mime = "video/*"; fg = "#dbbc7f"; } # Aqua
          { mime = "audio/*"; fg = "#d699b6"; } # Aqua
          # Archives
          { mime = "application/zip"; fg = "#e67e80"; }             # Soft red
          { mime = "application/gzip"; fg = "#e67e80"; }            # Soft red
          { mime = "application/x-tar"; fg = "#e67e80"; }           # Soft red
          { mime = "application/x-bzip"; fg = "#e67e80"; }          # Soft red
          { mime = "application/x-bzip2"; fg = "#e67e80"; }         # Soft red
          { mime = "application/x-7z-compressed"; fg = "#e67e80"; } # Soft red
          { mime = "application/x-rar"; fg = "#e67e80"; }           # Soft red
          # Fallback
          { name = "*"; fg = "#7fbbb3"; }  # Aqua
          { name = "*/"; fg = "#7fbbb3"; } # Aqua
        ];
      };
    };
  };
}
