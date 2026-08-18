{
  inputs = {

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin = {
      url = "github:catppuccin/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia/legacy-v4";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprmon = {
      url = "github:erans/hyprmon";
      flake = false;
    };
  };
  outputs =
    inputs@{
      self,
      nixpkgs,
      nix-index-database,
      catppuccin,
      ...
    }:
    {
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt-tree;

      nixosConfigurations.simeud = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [

          ./configuration.nix
          nix-index-database.nixosModules.default
          { programs.nix-index-database.comma.enable = true; }

          catppuccin.nixosModules.catppuccin
          {
            catppuccin.enable = true;
            catppuccin.autoEnable = true;
          }

          ./users/simeud/default.nix
          inputs.home-manager.nixosModules.home-manager

          {
            home-manager.useGlobalPkgs = true;
            home-manager.backupFileExtension = "backup";
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.users.simeud = {
              imports = [
                # index
                nix-index-database.homeModules.nix-index
                # actual user module
                ./users/simeud/home.nix
                catppuccin.homeModules.catppuccin

                ./modules/home-manager
              ];
            };

          }
        ];
      };
    };
}
