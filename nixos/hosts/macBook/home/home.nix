{ config, pkgs, inputs, outputs, lib, ... }:

with import <nixpkgs> {};

{
  nixpkgs.config.allowUnfree = true;

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "w8";
  home.homeDirectory = "/home/w8";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
    btop
    efibootmgr
    neofetch
    tor-browser-bundle-bin
    waybar
    ranger
    discord
    # eww
    # nerdfonts.override { fonts = [ "Iosevka" ]; } # Install specific nerdfont package
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/w8/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  programs = {
    neovim = {
      enable = true;
    };
    #Alacritty
    alacritty = {
      enable = true;
      settings = {
        window = {
	  padding = {
            x = 10;
            y = 10;
          };
	  dynamic_padding = true;
	  opacity = 0.91;
	};
        font.normal = {
          family = "Iosevka Nerd Font";
          style = "Regular";
        };
      };
    };
    #Firefox
    firefox = {
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

        # Extensions
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
  };

  # services.flatpak = {
    # enable = true;
    # packages = [
      # "flathub:app/com.discordapp.Discord/x86_64/stable"
    # ];
  # };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
