{ pkgs-unstable, inputs, ... }: {
  pkgs-wrapped.btop = (
    inputs.wrappers.wrapperModules.btop.apply {
      pkgs = pkgs-unstable;

      "btop.conf".content = ''
        color_theme = "TTY"
        theme_background = False
        truecolor = True
        force_tty = False
      '';
    }
  ).wrapper;
}
