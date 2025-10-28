{ config, pkgs, ... }:

{
  system.nixos.label = "Server";

  services.xserver.enable = false;
  services.upower.enable = false;
  services.pipewire.enable = false;
  services.printing.enable = false;

  # services.logind.lidSwitchExternalPower = "ignore";
  services.logind.settings.Login.HandleLidSwitchExternalPower = "ignore";

  boot.kernelParams = [ 
    "consoleblank=300"
  ];

  hardware.bluetooth.enable = false;

  # environment.systemPackages = with pkgs; [
  #   
  # ];


}
