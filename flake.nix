{
  description = "Fernando's NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      username = "fernando";
      linuxHomeDirectory = "/home/${username}";
      supportedSystems = [ "x86_64-linux" ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
      mkPkgs = system: import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      homeManagerModule = {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = {
          inherit username;
          homeDirectory = linuxHomeDirectory;
        };
        home-manager.users.${username} = import ./modules/home/base.nix;
      };
    in
    {
      legacyPackages = forAllSystems mkPkgs;

      devShells = forAllSystems (system: {
        default = import ./shell.nix {
          pkgs = mkPkgs system;
        };
      });

      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit username; };
          modules = [
            home-manager.nixosModules.home-manager
            homeManagerModule
            ./hosts/nixos
          ];
        };

        wayland = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit username; };
          modules = [
            home-manager.nixosModules.home-manager
            homeManagerModule
            ./hosts/wayland
          ];
        };
      };
    };
}
