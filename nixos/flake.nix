{
  description = "Flaky";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.11";
    nixpkgs-unstable.url="nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs-unstable";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, ... }:
  let
    lib = nixpkgs.lib;
    hlib = home-manager.lib;
    system = "x86_64-linux";
    pkgs = import nixpkgs { system = system; config = { allowUnfree = true; }; }; 
    pkgs-un = import nixpkgs-unstable { system = system; config = { allowUnfree = true; }; };
  in{
    nixosConfigurations = {
      machine = lib.nixosSystem {
        inherit system;
	modules = [ ./configuration.nix 
          home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.muqsit = import ./home.nix;
          home-manager.extraSpecialArgs = {inherit pkgs-un; };
          }
	];
      };
    };
    homeConfigurations = {
      muqsit = hlib.homeManagerConfiguration {
        inherit pkgs;
	extraSpecialArgs = {
          inherit pkgs-un;
        };
	modules = [ ./chezmoi/machine.nix ];
      };
    
     deck = hlib.homeManagerConfiguration {
       inherit pkgs;
       extraSpecialArgs = {
         inherit pkgs-un;
       };
       modules = [ ./chezmoi/deck.nix ];
     };
   };
  };
}
