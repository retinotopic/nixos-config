{
  programs.helix = {
    enable = true;
    settings = {
        theme = "everforest_dark";
        editor = {
            mouse = true;
            auto-completion = true;
            cursorline = false;
            cursorcolumn = false;
            auto-format = true;
            auto-save = true;
            idle-timeout = 300;
            completion-trigger-len = 2;
            auto-info = true;
            shell = ["sh" "-c"];
            bufferline = "multiple";
            gutters = ["diff" "diagnostics" "line-numbers" "spacer"];
            true-color = true;
        };
        editor.indent-guides = {
            render = true;
            character = "┆"; # Some characters that work well: "▏", "┆", "┊", "⸽"
            skip-levels = 1;
        };
        keys.normal = {
            esc = ["collapse_selection" "keep_primary_selection"];
        };
        editor.whitespace.characters = {
            nbsp = "⍽";
            tab = "→";
            newline = "⏎";
            # tabpad = "·"; # Tabs will look like "→···" (depending on tab width)
        };
        editor.cursor-shape = {
            insert = "bar";
            normal = "block";
            select = "underline";
        };
        editor.file-picker = {
            hidden = false;
        };
        editor.statusline = {
            left = ["mode" "spinner" "total-line-numbers" "workspace-diagnostics" ];
            center = ["file-name"];
            right = ["diagnostics" "selections" "position" "file-encoding" "file-line-ending" "file-type"];
            separator = "│";
            mode.normal = "NORMAL";
            mode.insert = "INSERT";
            mode.select = "SELECT";
        };
        editor.lsp = {
            display-messages = true;
            auto-signature-help = true;
            display-signature-help-docs = true;
        };
    };
  };
}
