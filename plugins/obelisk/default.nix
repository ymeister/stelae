{ system }:

let src = ./src;

    nix-haskell = import ../nix-haskell { inherit system; };

    obelisk-asset-manifest = nix-haskell {
      name = "obelisk-asset-manifest";
      src = src + "/lib/asset/manifest";
    };

    obelisk-asset-manifest-generate =
      "${obelisk-asset-manifest.haskell-nix.project.hsPkgs.obelisk-asset-manifest.components.exes.obelisk-asset-manifest-generate}/bin/obelisk-asset-manifest-generate";

in {
  inherit src obelisk-asset-manifest obelisk-asset-manifest-generate;

  source-repository-packages = {
    obelisk-asset-manifest = src + "/lib/asset/manifest";
    obelisk-asset-serve-snap = src + "/lib/asset/serve-snap";
    obelisk-backend = src + "/lib/backend";
    obelisk-command = src + "/lib/command";
    obelisk-executable-config-inject = src + "/lib/executable-config/inject";
    obelisk-executable-config-lookup = src + "/lib/executable-config/lookup";
    obelisk-frontend = src + "/lib/frontend";
    obelisk-route = src + "/lib/route";
    obelisk-run = src + "/lib/run";
    obelisk-selftest = src + "/lib/selftest";
    obelisk-snap-extras = src + "/lib/snap-extras";
    tabulation = src + "/lib/tabulation";
  };

  obelisk-generated-static-manifest = static:
    obelisk-asset-manifest.nixpkgs.runCommand "obelisk-generated-static" {
      LANG = "en_US.UTF-8";
      LOCALE_ARCHIVE = "${obelisk-asset-manifest.nixpkgs.glibcLocales}/lib/locale/locale-archive";
    } ''
      ${obelisk-asset-manifest-generate} ${static} $out obelisk-generated-static Obelisk.Generated.Static $out/files
      sed -i -e 's/GHC\.Internal\.Types/GHC.Types/g' $out/src/Obelisk/Generated/Static.hs
    '';
}
