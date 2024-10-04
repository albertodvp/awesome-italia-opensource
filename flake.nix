{
  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };
  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      flake = { };
      systems = [ "x86_64-linux" ];
      perSystem = { config, pkgs, ... }: {
        devShells.default = pkgs.mkShell {
          packages = [
            # NOTE: this is currently a copy from requirements.txt
            # This list is not expected to change a lot, this duplication
            # is a good tradeoff with seplicity
            pkgs.pre-commit
            pkgs.python312Packages.boto3
            pkgs.python312Packages.click
            pkgs.python312Packages.fastjsonschema
            pkgs.python312Packages.geopandas
            pkgs.python312Packages.geopy
            # TODO: this does not exit (yet)
            # pkgs.python312Packages.snakemd
          ];
          shellHook = ''
            pre-commit install
          '';
        };
      };
    };
}

