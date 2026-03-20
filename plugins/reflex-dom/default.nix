{ system }:

let nix-thunk = import ../nix-thunk { inherit system; };

in {
  src = nix-thunk.thunkSource ./thunk;
}
