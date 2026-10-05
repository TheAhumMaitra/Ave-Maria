{ config, pkgs, ... }:
{

  networking.hostName = "nixos"; # Define your hostname.

  # Bootloader.
  boot.loader.limine = {
    enable = true;
    style = {
      wallpapers = [ "/boot/background.jpg" ];
    };
  };
  boot.loader.systemd-boot.enable = false;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Enable flatpak
  services.flatpak.enable = true;

  # Fish as default shell
  programs.fish = {
    enable = true;
  };

  # Aliases
  environment.shellAliases = {
    nrs = "sudo nixos-rebuild switch";
    nrb = "sudo nixos-rebuild boot";
    nrsf = "sudo nixos-rebuild switch --flake /etc/nixos#nixos";
    zen-browser = "app.zen_browser.zen";
    nds = "nix develop /etc/nixos";
    c = "clear";
  };

  #Setup Gsettings schema
  environment.variables = {
    GSETTINGS_SCHEMA_DIR = "${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}/glib-2.0/schemas";
  };

  # Enable default window manager
  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };

  # Enable sudo-rs
  security.sudo-rs.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  #Git Setup
  programs.git = {
    enable = true;
    config = {
      user.name = "Ahum Maitra";
      user.email = "theahummaitra@gmail.com";
    };
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "gb";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "uk";

  users.users.ahummaitra = {
    isNormalUser = true;
    description = "Ahum Maitra";
    shell = pkgs.fish;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };
  # Enable authentication manager
  security.polkit.enable = true;

  # Start it
  systemd.user.services.polkit-gnome-authentication-agent-1 = {
    description = "polkit-gnome-authentication-agent-1";
    wantedBy = [ "graphical-session.target" ];
    wants = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable flakes
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
}
