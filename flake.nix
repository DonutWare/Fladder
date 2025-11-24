{
  description = "Fladder development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config = {
            allowUnfree = true;
            android_sdk.accept_license = true;
          };
        };
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            # Flutter Version Management
            fvm

            # Common Build Tools
            git
            curl
            unzip
            cmake
            ninja
            clang
            pkg-config
            chromium

            # Linux Desktop Development Dependencies
            gtk3
            glib
            pcre2
            util-linux # for libmount
            libselinux
            libsepol
            libthai
            libdatrie
            xorg.libX11
            xorg.libXcomposite
            xorg.libXcursor
            xorg.libXdamage
            xorg.libXdmcp
            xorg.libXext
            xorg.libXfixes
            xorg.libXi
            xorg.libXrender
            xorg.libXtst
            libxkbcommon
            libepoxy
            at-spi2-core
            dbus
            fontconfig
            pango
            cairo
            gdk-pixbuf
            
            # Graphics and Mesa
            mesa
            libdrm
            libGL
            libgbm
            
            # Audio
            libpulseaudio
            alsa-lib
            
            # System libraries
            stdenv.cc.cc
            zlib
            openssl
            nss
            nspr
            cups
            expat
            systemd
            xdg-user-dirs

            # Media playback
            mpv
          ];

          shellHook = ''
            echo "Welcome to the Fladder development environment!"
            echo "Flutter version managed by fvm."
            
            # Ensure fvm bin is in path
            export PATH="$PWD/.fvm/flutter_sdk/bin:$PATH"
            
            # Set up XDG directories for path_provider
            export XDG_DATA_HOME="''${XDG_DATA_HOME:-$HOME/.local/share}"
            export XDG_CONFIG_HOME="''${XDG_CONFIG_HOME:-$HOME/.config}"
            export XDG_CACHE_HOME="''${XDG_CACHE_HOME:-$HOME/.cache}"
            
            # Initialize XDG user directories
            ${pkgs.xdg-user-dirs}/bin/xdg-user-dirs-update
            
            # Set Chrome executable for Flutter web development
            export CHROME_EXECUTABLE="${pkgs.chromium}/bin/chromium"
            
            # Set up library path for Flutter-built binaries
            export LD_LIBRARY_PATH="${pkgs.lib.makeLibraryPath [
              pkgs.gtk3
              pkgs.glib
              pkgs.pcre2
              pkgs.util-linux
              pkgs.libselinux
              pkgs.libsepol
              pkgs.libthai
              pkgs.libdatrie
              pkgs.xorg.libX11
              pkgs.xorg.libXcomposite
              pkgs.xorg.libXcursor
              pkgs.xorg.libXdamage
              pkgs.xorg.libXdmcp
              pkgs.xorg.libXext
              pkgs.xorg.libXfixes
              pkgs.xorg.libXi
              pkgs.xorg.libXrender
              pkgs.xorg.libXtst
              pkgs.libxkbcommon
              pkgs.libepoxy
              pkgs.at-spi2-core
              pkgs.dbus
              pkgs.fontconfig
              pkgs.pango
              pkgs.cairo
              pkgs.gdk-pixbuf
              pkgs.mesa
              pkgs.libdrm
              pkgs.libGL
              pkgs.libgbm
              pkgs.libpulseaudio
              pkgs.alsa-lib
              pkgs.stdenv.cc.cc
              pkgs.zlib
              pkgs.openssl
              pkgs.nss
              pkgs.nspr
              pkgs.cups
              pkgs.expat
              pkgs.systemd
              pkgs.mpv
            ]}:$LD_LIBRARY_PATH"
          '';
        };
      }
    );
}
