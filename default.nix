{ system ? builtins.currentSystem }:

let nix-thunk = import ./components/nix-thunk { inherit system; };

in nix-thunk.mapSubdirectories (p: import p { inherit system; }) ./components
