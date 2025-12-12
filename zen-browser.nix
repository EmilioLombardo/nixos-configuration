{ zen-browser-flake, pkgs, lib, ... }:
let
  extension = shortId: guid: {
    name = guid;
    value = {
      install_url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/${shortId}/latest.xpi";
      installation_mode = "normal_installed";
    };
  };

  prefs = {
    # Check these out at about:config
    "extensions.autoDisableScopes" = 0;
    "extensions.pocket.enabled" = false;
    "browser.ctrlTab.sortByRecentlyUsed" = true;
    # "zen.ctrlTab.show-pending-tabs" = true;
    "browser.aboutConfig.showWarning" = false;
    "browser.search.suggest.enabled" = true;
    # ...
  };

  extensions = [
    # To add additional extensions, find it on addons.mozilla.org, find
    # the short ID in the url (like https://addons.mozilla.org/en-US/firefox/addon/!SHORT_ID!/)
    # Then go to https://addons.mozilla.org/api/v5/addons/addon/!SHORT_ID!/ to get the guid
    (extension "ublock-origin" "uBlock0@raymondhill.net")
    (extension "sponsorblock" "sponsorBlocker@ajay.app")
    (extension "youtube-recommended-videos" "myallychou@gmail.com") # unhook
    (extension "karaktersnitt-for-studentweb" "{ed445e9e-ee55-4a38-9692-83a6012845d0}")
    (extension "markdown-viewer-chrome" "markdown-viewer@outofindex.com")
    (extension "indie-wiki-buddy" "{cb31ec5d-c49a-4e5a-b240-16c767444f62}")
  ];

in
{
  environment.systemPackages = [
    (pkgs.wrapFirefox
      zen-browser-flake.packages.${pkgs.stdenv.hostPlatform.system}.zen-browser-unwrapped
      {
        extraPrefs = lib.concatLines (
          lib.mapAttrsToList (
            name: value: ''lockPref(${lib.strings.toJSON name}, ${lib.strings.toJSON value});''
          ) prefs
        );

        extraPolicies = {
          DisableTelemetry = true;
          ExtensionSettings = builtins.listToAttrs extensions;

          SearchEngines = {
            Default = "ddg";
            Add = [
              { # kagi -> Kagi {{{
                Name = "Kagi";
                URLTemplate = "https://kagi.com/search?q={searchTerms}";
                IconURL = "https://kagi.com/favicon.ico";
                Alias = "@k";
              }# }}}
              { # np -> Nix packages {{{
                Name = "nixpkgs packages";
                URLTemplate = "https://search.nixos.org/packages?query={searchTerms}";
                IconURL = "https://wiki.nixos.org/favicon.ico";
                Alias = "@np";
              }# }}}
              { # no -> NixOS options {{{
                Name = "NixOS options";
                URLTemplate = "https://search.nixos.org/options?query={searchTerms}";
                IconURL = "https://wiki.nixos.org/favicon.ico";
                Alias = "@no";
              }# }}}
              { # nw -> NixOS Wiki {{{
                Name = "NixOS Wiki";
                URLTemplate = "https://wiki.nixos.org/w/index.php?search={searchTerms}";
                IconURL = "https://wiki.nixos.org/favicon.ico";
                Alias = "@nw";
              }# }}}
              { # ng -> noogle {{{
                Name = "noogle";
                URLTemplate = "https://noogle.dev/q?term={searchTerms}";
                IconURL = "https://noogle.dev/favicon.ico";
                Alias = "@ng";
              }# }}}
            ];
          };
        };
      }
    )
  ];
}

# vim: foldmethod=marker sw=2
