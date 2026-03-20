{ system }:

let nix-thunk = import ../../deps/nix-thunk {};
    nix-haskell = (import ../nix-haskell { inherit system; }).nix-haskell;

    src = nix-thunk.thunkSource ./thunk;

    obelisk-asset-manifest = nix-haskell {
      name = "obelisk-asset-manifest";
      src = src + "/lib/asset/manifest";
    };

    obelisk-asset-manifest-generate =
      "${obelisk-asset-manifest.haskell-nix.project.hsPkgs.obelisk-asset-manifest.components.exes.obelisk-asset-manifest-generate}/bin/obelisk-asset-manifest-generate";

in {
  inherit src obelisk-asset-manifest obelisk-asset-manifest-generate;

  obelisk-generated-static-manifest = static:
    obelisk-asset-manifest.nixpkgs.runCommand "obelisk-generated-static" {
      LANG = "en_US.UTF-8";
      LOCALE_ARCHIVE = "${obelisk-asset-manifest.nixpkgs.glibcLocales}/lib/locale/locale-archive";
    } ''
      ${obelisk-asset-manifest-generate} ${static} $out obelisk-generated-static Obelisk.Generated.Static $out/files
      sed -i -e 's/GHC\.Internal\.Types/GHC.Types/g' -e 's/hashedPath/staticPath/g' $out/src/Obelisk/Generated/Static.hs
    '';
}
