{ system ? builtins.currentSystem }:

let mapSubdirectories = f: dir:
      let entries = builtins.readDir dir;
      in builtins.mapAttrs (name: _: f (dir + "/${name}"))
        (builtins.listToAttrs
          (builtins.filter ({ name, ... }: let t = entries.${name}; in t == "directory" || t == "symlink")
            (map (name: { inherit name; value = null; }) (builtins.attrNames entries))));

in mapSubdirectories (p: import p { inherit system; }) ./components
