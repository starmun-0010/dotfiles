{
  description = "Flaky";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixgl.url = "github:nix-community/nixGL";
  };

  outputs = { self, nixpkgs, home-manager, nixgl, ... }:
  let
    lib = nixpkgs.lib;
    hlib = home-manager.lib;
    system = "x86_64-linux";
    pkgs = import nixpkgs { system = system; overlays = [ nixgl.overlay ]; config = { allowUnfree = true; }; };
  in{
    nixosConfigurations = {
      machine = lib.nixosSystem {
        inherit system;
	modules = [ ./configuration.nix 
          home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.muqsit = import ./chezmoi/machine.nix;
          }
	];
      };
    };
    homeConfigurations = {
      muqsit = hlib.homeManagerConfiguration {
        inherit pkgs;
	modules = [ ./chezmoi/machine.nix ];
      };

     deck = hlib.homeManagerConfiguration {
       inherit pkgs;
       extraSpecialArgs = {
	 inherit nixgl;
       };
       modules = [ ./chezmoi/deck.nix ];
     };
     hermes = hlib.homeManagerConfiguration {
       inherit pkgs;
       extraSpecialArgs = {
	 inherit nixgl;
       };
       modules = [ ./chezmoi/hermes.nix ];
     };

   };
  };
}
