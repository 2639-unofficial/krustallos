{
  config,
  pkgs,
  ...
}:

{
  # niri recommends the plasma-polkit-agent
  # polkit-gnome is unmaintained, and soteria is not mature enough
  # REF: ${pkgs.kdePackages.polkit-kde-agent-1}/share/systemd/user/plasma-polkit-agent.service
  systemd.user.services.plasma-polkit-agent = {
    Unit = {
      Description = "KDE PolicyKit Authentication Agent for Wayland Desktop";
      PartOf = "graphical-session.target";
      After = "graphical-session.target";
    };
    Service = {
      ExecStart = "${pkgs.kdePackages.polkit-kde-agent-1}/libexec/polkit-kde-authentication-agent-1";
      BusName = "org.kde.polkit-kde-authentication-agent-1";
      Slice = "background.slice";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 5;
    };
    Install = {
      WantedBy = [ config.wayland.systemd.target ];
    };
  };
}
