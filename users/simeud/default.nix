{ pkgs, ... }:

{

  programs.zsh.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.simeud = {
    isNormalUser = true;
    description = "simeud";
    useDefaultShell = true;
    extraGroups = [
      "networkmanager"
      "wheel"
      "openrazer"
    ];
  };

}
