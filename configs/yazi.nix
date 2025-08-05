{
  programs.yazi = {
    enable = true;
    # flavors = {
    #   everforest = ./everforest.yazi;
    # };
    theme = {
      mgr = {
        cwd = { fg = "#d3c6aa"; };  
        # Hovered
        hovered = { fg = "#424b50"; bg = "#7fbbb3"; };  
        preview_hovered = { fg = "#424b50"; bg = "#7fbbb3"; };  
        # Find
        find_keyword = { fg = "#83c092"; italic = true; }; 
        find_position = { fg = "#e67e80"; bg = "reset"; italic = true; };  
        # Marker
        marker_selected = { fg = "#a7c080"; bg = "#a7c080"; };
        marker_copied = { fg = "#83c092"; bg = "#7fbbb3"; };
        marker_cut = { fg = "#e67e80"; bg = "#e67e80"; };
        marker_marked   = { fg = "#dbbc7f"; bg = "#dbbc7f"; };

        border_symbol = "┃";
        # border_symbol = "│";
        border_style = { fg = "#e67e80"; }; 

        count_copied   = { fg = "#424b50"; bg = "#83c092"; };
        count_cut      = { fg = "#424b50"; bg = "#e67e80"; };
        count_selected = { fg = "#424b50"; bg = "#a7c080"; };

        # Highlighting
        syntect_theme = ./everforest.yazi/everforest.tmTheme;
        
      };
      tabs = {
        active   = { fg = "#d3c6aa"; bg = "#e67e80"; bold = true; };
        inactive = { fg = "#e67e80"; bg = "#d3c6aa"; };
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
        overall = { fg = "#d3c6aa"; }; 
        sep_left = { open = ""; close = ""; };
        sep_right = { open = ""; close = ""; };
        # Progress
        progress_label = { fg = "#424b50"; bg = "#7fbbb3";};
        progress_normal = { fg = "#424b50";bg = "#7fbbb3";  }; 
        progress_error = { fg = "#424b50";bg = "#7fbbb3";  };
        # Permissions
        perm_type = { fg = "#d3c6aa"; }; 
        perm_read = { fg = "#d3c6aa"; }; 
        perm_write = { fg = "#d3c6aa"; }; 
        perm_exec = { fg = "#d3c6aa"; }; 
        perm_sep = { fg = "#d3c6aa"; }; 
      };
      input = {
        border = { fg = "#83c092"; };
        title = {};
        value = {};
        selected = { reversed = true; };
      };
      cmp = {
        border = { fg = "#7fbbb3"; };
        active = { fg = "#424b50"; bg = "#7fbbb3"; };
        inactive = { fg = "#83c092"; };
      };
      pick = {
        border = { fg = "#7fbbb3"; };
        active = { fg = "#424b50"; bg = "#7fbbb3"; };
        inactive = { fg = "#83c092"; };
      };
      tasks = {
        border = { fg = "#83c092"; };
        title = {};
        hovered = { underline = true; };
      };
      which = {
        cols = 3;
        mask = { bg = "#424b50"; };  
        cand = { fg = "#a7c080"; };  
        rest = { fg = "#83c092"; }; 
        desc = { fg = "#e67e80"; };  
        separator = "  ";
        separator_style = { fg = "#424b50"; }; 
      };
      help = {
        on = { fg = "#e67e80"; };  
        run = { fg = "#a7c080"; };  
        desc = { fg = "#83c092"; }; 
        hovered = { bg = "#424b50"; bold = true; };  
        footer = { fg = "#424b50"; bg = "#83c092"; };
      };
      notify = {
        title_info = { fg = "#7fbbb3"; };
        title_warn = { fg = "#dbbc7f"; };
        title_error = { fg = "#e67e80"; };
      };
      filetype = {
        rules = [
          # Images
          { mime = "image/*"; fg = "#dbbc7f"; }  
          # Videos
          { mime = "video/*"; fg = "#a7c080"; } 
          { mime = "audio/*"; fg = "#d699b6"; } 
          # Archives
          { mime = "application/zip"; fg = "#e67e80"; }
          { mime = "application/gzip"; fg = "#e67e80"; }
          { mime = "application/x-tar"; fg = "#e67e80"; }
          { mime = "application/x-bzip"; fg = "#e67e80"; }
          { mime = "application/x-bzip2"; fg = "#e67e80"; }  
          { mime = "application/x-7z-compressed"; fg = "#e67e80"; }  
          { mime = "application/x-rar"; fg = "#e67e80"; }  
          # Fallback
          { name = "*"; fg = "#83c092"; } 
          { name = "*/"; fg = "#83c092"; } 
        ];
      };
    };
  };
}
