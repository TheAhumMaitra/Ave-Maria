{ config, pkgs, ... }:

{

  # Enable SDDM
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  # Disable pulseaudio
  services.pulseaudio.enable = false;

  # Enable rtkit for video/audio real time
  security.rtkit.enable = true;

  # Enable Pipreware
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true; # Required for 32-bit games (e.g., Steam)
    pulse.enable = true; # Emulates PulseAudio

    # WirePlumber is the default session manager and is enabled by default,
    # but you can declare it explicitly like this:
    wireplumber.enable = true;

    # Optional: Uncomment if you use professional audio/JACK apps
    # jack.enable = true;
  };

  # Get all required fonts
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    dejavu_fonts
    noto-fonts
    noto-fonts-color-emoji
  ];

  # Get default emoji font
  fonts.fontconfig = {
    defaultFonts = {
      emoji = [ "Noto Color Emoji" ];
    };
  };

}
