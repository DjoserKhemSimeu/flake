{
  pkgs,
  inputs,
  ...
}:

{
  home.stateVersion = "25.11";

  home = {
    username = "simeud";
    homeDirectory = "/home/simeud";
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    TERM = "ghostty";
  };

  home.packages = with pkgs; [
    bitwarden-desktop
    google-chrome
    obs-studio
    vlc
    zotero
    rocmPackages.mpi
    gcc
    lshw
    unzip
    texliveMedium
    gnumake
    glibc
    grim
    slurp
    swappy
    wl-clipboard
    wtype
    glibc.static
    (hyprmon.overrideAttrs {
      src = inputs.hyprmon;
    })
    lazygit
    tailscale
    minikube
    python313
    python313Packages.pip
    python313Packages.venvShellHook
    drawio
    docker
    nvtopPackages.nvidia
    catppuccin-discord
    discord
    fastfetch
    openrgb-with-all-plugins
    signal-desktop
    vscode
    antigravity-cli
  ];

}
