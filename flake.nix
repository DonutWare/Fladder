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
            util-linux # for libmount
            libx11
            libxcomposite
            libxcursor
            libxdamage
            libxext
            libxtst
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
            mesa-demos
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
            
            # Initialize XDG user directories
            ${pkgs.xdg-user-dirs}/bin/xdg-user-dirs-update
            
            # Set Chrome executable for Flutter web development
            export CHROME_EXECUTABLE="${pkgs.chromium}/bin/chromium"
            
            # Set up library path for Flutter-built binaries
            export LD_LIBRARY_PATH="${pkgs.lib.makeLibraryPath [
              pkgs.gtk3
              pkgs.glib
              pkgs.util-linux
              pkgs.libx11
              pkgs.libxcomposite
              pkgs.libxcursor
              pkgs.libxdamage
              pkgs.libxext
              pkgs.libxtst
              pkgs.libxkbcommon
              pkgs.libepoxy
              pkgs.at-spi2-core
              pkgs.dbus
              pkgs.fontconfig
              pkgs.pango
              pkgs.cairo
              pkgs.gdk-pixbuf
              pkgs.mesa
              pkgs.mesa-demos
              pkgs.libdrm
              pkgs.libGL
              pkgs.libgbm
              pkgs.libpulseaudio
              pkgs.alsa-lib
              pkgs.stdenv.cc.cc
              pkgs.zlib
              pkgs.openssl
              pkgs.systemd
              pkgs.mpv
            ]}:$LD_LIBRARY_PATH"
          '';
        };
      }
    );
}
