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
    hyprmon
    lazygit
    tailscale
    minikube
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
