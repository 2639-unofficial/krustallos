{
  description = "A nix flake configuration";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = inputs @ { self, nixpkgs, ... }: {
    # NixOS configuration entrypoint
    nixosConfigurations = {
      mfm8s = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/mfm8s/configuration.nix
        ];
      };
    };
  };
}
