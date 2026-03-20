{ system }:

let nix-thunk = import ../../deps/nix-thunk {};

in {
  src = nix-thunk.thunkSource ./thunk;
}
