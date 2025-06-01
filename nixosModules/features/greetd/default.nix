{pkgs, ...}: {
  services.greetd = {
    enable = true;
    settings = {
      default_session = ''        ${pkgs.greetd.tuigreet}/bin/tuigreet \
              --remember \
              --remember-session \
              --asterisks \
              --time'';
      user = "luwpy";
    };
  };
}
