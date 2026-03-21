{ system }:

let src = ./src;
    nix-haskell = import src { inherit system; };
    nix-thunk = (nix-haskell {}).config.importing.nix-thunk;

in { __functor = _: nix-haskell; inherit src nix-thunk; }
