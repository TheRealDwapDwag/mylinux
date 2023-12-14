{ config, pkgs, inputs, outputs, lib, ... }:

{
  programs.firefox = {
    enable = true;
    profiles.w8 = {
      # Search Engines
      search.engines = {
        "Nix Packages" = {
          urls = [{
            template = "https://search.nixos.org/packages";
            params = [
              { name = "type"; value = "packages"; }
              { name = "query"; value = "{searchTerms}"; }
            ];
          }];
          icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          definedAliases = [ "@np" ];
        };
        "Brave" = {
          urls = [{
            template = "https://search.brave.com/search?q={searchTerms}&source=web";
          }];
          updateInterval = 24 * 60 * 60 * 1000; # every day
          definedAliases = [ "@b" ];
        };
	      "Youtube" = {
          urls = [{
            template = "https://www.youtube.com/results?search_query={searchTerms}";
	        }];
	        updateInterval = 24 * 60 * 60 * 1000;
	        definedAliases = [ "@yt" ];
	      };
        "Bing".metaData.hidden = true;
        "amazon.com.au".metaData.hidden = true;
        "Google".metaData.hidden = true;
        "eBay".metaData.hidden = true;
        "DuckDuckGo".metadata.hidden = true;
      };
      search.force = true;
      search.default = "Brave";
      search.order = [
        "Brave"
      ];

      # Bookmarks
      bookmarks = [
        {
          name = "wikipedia";
          tags = [ "wiki" ];
          keyword = "wiki";
          url = "https://en.wikipedia.org/wiki/Special:Search?search=%s&go=Go";
        }
        {
          name = "kernel.org";
          url = "https://www.kernel.org";
        }
        {
          name = "Nix sites";
          toolbar = true;
          bookmarks = [
            {
              name = "homepage";
              url = "https://nixos.org/";
            }
            {
              name = "wiki";
              tags = [ "wiki" "nix" ];
              url = "https://nixos.wiki/";
            }
          ];
        }
      ];
      extensions = with inputs.firefox-addons.packages."x86_64-linux"; [
        # betterttv
        darkreader
        istilldontcareaboutcookies
        one-click-wayback
        open-url-in-container
        polish-dictionary
        return-youtube-dislikes
        snowflake
        sponsorblock
        torrent-control
        tridactyl
        ublock-origin
        wayback-machine
      ];
    };
  };
}
