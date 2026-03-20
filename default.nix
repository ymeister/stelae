{ system ? builtins.currentSystem }:

let nix-thunk = import ./deps/nix-thunk {};

in nix-thunk.mapSubdirectories (p: import p { inherit system; }) ./plugins
