{ system ? builtins.currentSystem }:

let nix-thunk = import ./plugins/nix-thunk { inherit system; };

in nix-thunk.mapSubdirectories (p: import p { inherit system; }) ./plugins
