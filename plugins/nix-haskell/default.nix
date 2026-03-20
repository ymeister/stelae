{ system }:

let nix-haskell = import ./thunk { inherit system; };
    nix-thunk = (nix-haskell {}).config.importing.nix-thunk;
    src = nix-thunk.thunkSource ./thunk;

in { __functor = _: nix-haskell; inherit src nix-thunk; }
