{ config, pkgs, ... }:

{
  imports = [ ]; # No extra modules for now

  networking.hostName = "desktop-gtx1080";
  time.timeZone = "UTC";
  i18n.defaultLocale = "en_US.UTF-8";

  services.xserver.videoDrivers = [ "nvidia" ];

  environment.systemPackages = with pkgs; [
    nvidia-dkms
    nvidia-utils
  ];

  boot.kernelParams = [
    "nvidia-drm.modeset=1"
    "nvidia_drm.fbdev=0"
    "NVreg_PreserveVideoMemoryAllocations=1"
  ];

  boot.blacklistedKernelModules = [ "nouveau" ];
  services.xserver.enable = false;
}
