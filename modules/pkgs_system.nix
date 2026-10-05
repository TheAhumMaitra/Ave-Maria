{ config, pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    vim
    git
    glib
    wget
    curl
    nixfmt
    sbctl
  ];

}
