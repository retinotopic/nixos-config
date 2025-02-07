{
    programs.helix = {
    enable = true;
    themes = {
    base16 = let
          bg0 = "#323d43";
          bg1 = "#3c474d";
          bg2 = "#465258";
          bg3 = "#505a60";
          bg4 = "#576268";
          bg5 = "#5f6d67";
          bg_visual = "#5d4251";
          bg_red = "#59454b";
          bg_green = "#48584d";
          bg_blue = "#3d5665";
          bg_yellow = "#55544a";
          
          fg = "#d3c6aa";
          red = "#e67e80";
          orange = "#e69875";
          yellow = "#dbbc7f";
          green = "#a7c080";
          aqua = "#83c092";
          blue = "#7fbbb3";
          purple = "#d699b6";
          grey0 = "#7a8478";
          grey1 = "#859289";
          grey2 = "#9da9a0";
    in {
          "type" = "yellow";
          "constant" = "purple";
          "constant.numeric" = "purple";
          "constant.character.escape" = "orange";
          "string" = "green";
          "string.regexp" = "blue";
          "comment" = "grey0";
          "variable" = "fg";
          "variable.builtin" = "blue";
          "variable.parameter" = "fg";
          "variable.other.member" = "fg";
          "label" = "aqua";
          "punctuation" = "grey2";
          "punctuation.delimiter" = "grey2";
          "punctuation.bracket" = "fg";
          "keyword" = "red";
          "keyword.directive" = "aqua";
          "operator" = "orange";
          "function" = "green";
          "function.builtin" = "blue";
          "function.macro" = "aqua";
          "tag" = "yellow";
          "namespace" = "aqua";
          "attribute" = "aqua";
          "constructor" = "yellow";
          "module" = "blue";
          "special" = "orange";
          
          "markup.heading.marker" = "grey2";
          "markup.heading.1" = { fg = "red"; modifiers = ["bold"]; };
          "markup.heading.2" = { fg = "orange"; modifiers = ["bold"]; };
          "markup.heading.3" = { fg = "yellow"; modifiers = ["bold"]; };
          "markup.heading.4" = { fg = "green"; modifiers = ["bold"]; };
          "markup.heading.5" = { fg = "blue"; modifiers = ["bold"]; };
          "markup.heading.6" = { fg = "fg"; modifiers = ["bold"]; };
          "markup.list" = "red";
          "markup.bold" = { modifiers = ["bold"]; };
          "markup.italic" = { modifiers = ["italic"]; };
          "markup.link.url" = { fg = "blue"; modifiers = ["underlined"]; };
          "markup.link.text" = "purple";
          "markup.quote" = "grey2";
          "markup.raw" = "green";
          
          "diff.plus" = "green";
          "diff.delta" = "orange";
          "diff.minus" = "red";
          
          "ui.background" = { bg = "bg0"; };
          "ui.background.separator" = "grey0";
          "ui.cursor" = { fg = "bg0"; bg = "fg"; };
          "ui.cursor.match" = { fg = "orange"; bg = "bg_yellow"; };
          "ui.cursor.insert" = { fg = "bg0"; bg = "grey1"; };
          "ui.cursor.select" = { fg = "bg0"; bg = "blue"; };
          "ui.cursorline.primary" = { bg = "bg1"; };
          "ui.cursorline.secondary" = { bg = "bg1"; };
          "ui.selection" = { bg = "bg3"; };
          "ui.linenr" = "grey0";
          "ui.linenr.selected" = "fg";
          "ui.statusline" = { fg = "grey2"; bg = "bg3"; };
          "ui.statusline.inactive" = { fg = "grey0"; bg = "bg1"; };
          "ui.statusline.normal" = { fg = "bg0"; bg = "grey2"; modifiers = ["bold"]; };
          "ui.statusline.insert" = { fg = "bg0"; bg = "yellow"; modifiers = ["bold"]; };
          "ui.statusline.select" = { fg = "bg0"; bg = "blue"; modifiers = ["bold"]; };
          "ui.bufferline" = { fg = "grey0"; bg = "bg1"; };
          "ui.bufferline.active" = { fg = "fg"; bg = "bg3"; modifiers = ["bold"]; };
          "ui.popup" = { fg = "grey2"; bg = "bg2"; };
          "ui.window" = { fg = "grey0"; bg = "bg0"; };
          "ui.help" = { fg = "fg"; bg = "bg2"; };
          "ui.text" = "fg";
          "ui.text.focus" = "fg";
          "ui.menu" = { fg = "fg"; bg = "bg3"; };
          "ui.menu.selected" = { fg = "bg0"; bg = "green"; };
          "ui.virtual.whitespace" = { fg = "bg4"; };
          "ui.virtual.indent-guide" = { fg = "bg4"; };
          "ui.virtual.ruler" = { bg = "bg3"; };
          
          "hint" = "blue";
          "info" = "aqua";
          "warning" = "yellow";
          "error" = "red";
          "diagnostic" = { underline = { style = "curl"; }; };
          "diagnostic.hint" = { underline = { color = "blue"; style = "dotted"; }; };
          "diagnostic.info" = { underline = { color = "aqua"; style = "dotted"; }; };
          "diagnostic.warning" = { underline = { color = "yellow"; style = "curl"; }; };
          "diagnostic.error" = { underline = { color = "red"; style = "curl"; }; };
        }; 
    };  
    settings = {
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
        character = "|"; # Some characters that work well: "▏", "┆", "┊", "⸽"
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
















