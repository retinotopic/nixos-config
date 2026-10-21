{ lib, pkgs-unstable, ... }: {
  programs.zed-editor = {
    enable = true;

    # This populates the userSettings "auto_install_extensions"
    extensions = [ "nix" "toml" "make" "everforest" ];

    # Everything inside of these brackets are Zed options
    userSettings = {
      hour_format = "hour24";
      auto_update = false;
      disable_ai = true;
      buffer_font_weight = 900;
      buffer_font_family = "JetBrainsMono Nerd Font";
      buffer_font_size = 16;
      terminal = {
        alternate_scroll = "off";
        blinking = "off";
        copy_on_select = false;
        dock = "bottom";
        detect_venv = {
          on = {
            directories = [ ".env" "env" ".venv" "venv" ];
            activate_script = "default";
          };
        };
        font_family = "JetBrainsMono Nerd Font";
        font_features = null;
        font_size = 16;
        line_height = "comfortable";
        option_as_meta = false;
        button = false;
        shell = {
          program = "fish";
        };
        toolbar = {
          title = true;
        };
        working_directory = "current_project_directory";
      };
      project_panel = {
        button = true;
        default_width = 240;
        dock = "left";
        entry_spacing = "comfortable";
        file_icons = true;
        folder_indicator = "icon";
        git_status = true;
        indent_size = 30;
        auto_reveal_entries = true;
        auto_fold_dirs = true;
        bold_folder_labels = false;
        drag_and_drop = true;
        scrollbar = {
          show = null;
          horizontal_scroll = true;
        };
        minimap = {
          show = true;
        };
        sticky_scroll = true;
        show_diagnostics = "all";
        indent_guides = {
          show = "always";
        };
        sort_mode = "directories_first";
        hide_root = false;
        hide_hidden = false;
        starts_open = true;
        auto_open = {
          on_create = true;
          on_paste = true;
          on_drop = true;
        };
      };

      lsp = {
        nix = {
          binary = {
            path_lookup = true;
          };
        };
      };

      helix_mode = true;

      # Tell Zed to use direnv and direnv can use a flake.nix environment
      load_direnv = "shell_hook";
      # base_keymap = "VSCode";

      theme = {
        mode = "dark";
        light = "Everforest Light Soft (blur)";
        dark = "Everforest Dark Soft (blur)";
      };

      show_whitespaces = "all";
      ui_font_size = 16;
      ui_font_weight = 900;
      ui_font_family = "JetBrainsMono Nerd Font";
    };
  };
}

