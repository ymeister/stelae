{ ... }:

let src = ./src;

in {
  extraCabalProject = [
    (builtins.readFile (src + "/lib/cabal.project.config"))
  ];

  overrides = [
    ({ config, lib, pkgs, ... }:
      let optionalPackages = lib.filterAttrs (name: _: config.packages ? ${name});
      in {
        packages = optionalPackages {
          cli-git.components.library.build-tools = with pkgs; [ git ];
          cli-nix.components.library.build-tools = with pkgs; [ nix nix-prefetch-git ];
          obelisk-command.components.library.build-tools = with pkgs; [ ghcid jre openssh ];
        };
      })
  ];
}
