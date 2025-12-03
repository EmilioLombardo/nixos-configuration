{ config, pkgs, ... }:

{
  system.nixos.label = "Desktop";

  programs.hyprland = {
    enable = true;
    withUWSM = true; # recommended for most users
    xwayland.enable = true; # Xwayland can be disabled.
  };
  services.upower.enable = true;

  # services.greetd = {
  #   enable = true;
  #   settings.default_session = {
  #     command = "uwsm start hyprland-uwsm";
  #     user = "emilio";
  #   };
  # };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
  # programs.dconf = {
  #   enable = true;
  #   profiles.user.databases = [
  #     {
  #       settings = {
  #         "org/gnome/desktop/input-sources" = {
  #           xkb-options = [ "altwin:swap_lalt_lwin" "ctrl:swapcaps" ];
  #         };
  #       };
  #     }
  #   ];
  # };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "no";
    variant = "";
    options = "altwin:swap_lalt_lwin,ctrl:swapcaps";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Install firefox.
  programs.firefox.enable = true;

  # Steam stuff
  programs.steam.enable = true;
  #programs.steam.gamescopeSession.enable = true;
  #programs.gamemode.enable = true;
  # TODO: Lutris?

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    uwsm
    kitty
    pavucontrol
    libnotify
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
  ];

}
