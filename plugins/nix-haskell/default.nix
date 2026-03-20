{ system }:

let nix-thunk = import ../../deps/nix-thunk {};
    src = nix-thunk.thunkSource ./thunk;
    nix-haskell = import src { inherit system; };

in nix-haskell // { inherit src; }
