{ config, pkgs, ... }:

{
  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Enable networking
  networking.networkmanager.enable = true;

  # Time zone & locale
  time.timeZone = "Australia/Hobart";
  i18n.defaultLocale = "en_AU.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_AU.UTF-8";
    LC_IDENTIFICATION = "en_AU.UTF-8";
    LC_MEASUREMENT = "en_AU.UTF-8";
    LC_MONETARY = "en_AU.UTF-8";
    LC_NAME = "en_AU.UTF-8";
    LC_NUMERIC = "en_AU.UTF-8";
    LC_PAPER = "en_AU.UTF-8";
    LC_TELEPHONE = "en_AU.UTF-8";
    LC_TIME = "en_AU.UTF-8";
  };
  
  # No sudo password for wheel users
  security.sudo.wheelNeedsPassword = false;

  # Disable TPM
  systemd.tpm2.enable = false;
  boot.initrd.systemd.tpm2.enable = false;

  # Define a user account.
  users.users.albert = {
    isNormalUser = true;
    description = "albert";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;

  services.displayManager.ly.enable = true;

  programs.hyprland = {
  enable = true;
  withUWSM = true;
};

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];
   
  system.stateVersion = "25.05";

  security.polkit.enable = true;

  # Explicitly use dbus-broker as the system bus implementation
  services.dbus.implementation = "broker";

  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [ "albert" ];
  };
}
