{
  pkgs,
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
    zotero
    rocmPackages.mpi
    gcc
    unzip
    texliveMedium
    gnumake
    glibc
    grim
    slurp
    swappy
    wl-clipboard
    glibc.static
    hyprmon
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
    silver-searcher
    vscode
  ];

}
