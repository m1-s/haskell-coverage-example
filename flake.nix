{
  description = "Haskell.nix Coverage Example";

  inputs = {
    haskellNix.url = "github:input-output-hk/haskell.nix";
    nixpkgs.follows = "haskellNix/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, haskellNix }:
    flake-utils.lib.eachSystem [ flake-utils.lib.system.x86_64-linux ] (system:
      let
        overlays = [ haskellNix.overlay ];
        project = pkgs.haskell-nix.cabalProject {
          src = pkgs.haskell-nix.haskellLib.cleanGit {
            name = "haskell-nix-project";
            src = ./.;
          };
          compiler-nix-name = "ghc8107";
          modules = [{
            packages.b.components.library.doCoverage = true;
          }];
        };
        pkgs = import nixpkgs { inherit system overlays; inherit (haskellNix) config; };
      in
      {
        packages = project;
      }
    );
}
