{
  description = "Fladder - A simple cross-platform Jellyfin client";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {
          inherit system;
          config = {
            allowUnfree = true;
            android_sdk.accept_license = true;
          };
        };
      in {
        packages.fladder = pkgs.flutter335.buildFlutterApplication {
          pname = "fladder";
          version = "0.8.0";
          src = ./.;

          autoPubspecLock = ./pubspec.lock;

          customSourceBuilders = let
            mkMediaKitSource = subDir: {
              version,
              src,
              ...
            }:
              pkgs.stdenv.mkDerivation {
                pname = "media-kit-source";
                inherit version src;
                installPhase = ''
                  mkdir -p $out
                  cp -r ${subDir}/* $out
                '';
                passthru = {
                  packageRoot = ".";
                };
              };
          in {
            media_kit = mkMediaKitSource "media_kit";
            media_kit_video = mkMediaKitSource "media_kit_video";
            media_kit_libs_video = mkMediaKitSource "libs/universal/media_kit_libs_video";
            media_kit_libs_android_video = mkMediaKitSource "libs/android/media_kit_libs_android_video";
            media_kit_libs_ios_video = mkMediaKitSource "libs/ios/media_kit_libs_ios_video";
            media_kit_libs_macos_video = mkMediaKitSource "libs/macos/media_kit_libs_macos_video";
            media_kit_libs_windows_video = mkMediaKitSource "libs/windows/media_kit_libs_windows_video";
            media_kit_libs_linux = pkgs.callPackage ./nix/media_kit_libs_linux_donutware.nix {
              miMallocVersion = "2.1.2";
              miMallocHash = "sha256-Kxv/b3F/lyXHC/jXnkeG2hPeiicAWeS6C90mKue+Rus=";
            };

            fvp = pkgs.callPackage ./nix/fvp.nix {
              fvpVersion = "0.35.0";
              fvpHash = "sha256-GaHaNYGUANhosX1Aq7ehGeGGwCxu3Ar1NxgTSyPhnhA=";
            };
          };

          gitHashes = let
            media_kit-hash = "sha256-vnzIfVkkBcvqtFuhbf3WzYUTo0ea7+MYgws/+wDpNf0=";
          in {
            media_kit = media_kit-hash;
            media_kit_video = media_kit-hash;
            media_kit_libs_linux = media_kit-hash;
            media_kit_libs_video = media_kit-hash;
            media_kit_libs_android_video = media_kit-hash;
            media_kit_libs_ios_video = media_kit-hash;
            media_kit_libs_macos_video = media_kit-hash;
            media_kit_libs_windows_video = media_kit-hash;
          };

          nativeBuildInputs = with pkgs; [
            copyDesktopItems
          ];

          # Add any necessary build-time or runtime dependencies here
          buildInputs = with pkgs; [
            mpv
            sqlite
            alsa-lib
            libepoxy
            gtk3
            glib
            util-linux
            libselinux
            libsepol
            libthai
            libdatrie
            xorg.libXdmcp
            xorg.libXtst
            pcre2
            libpulseaudio
          ];

          postInstall = ''
            # Install SVG icon
            install -Dm644 icons/fladder_icon.svg \
              $out/share/icons/hicolor/scalable/apps/fladder.svg
          '';

          desktopItems = [
            (pkgs.makeDesktopItem {
              name = "fladder";
              desktopName = "Fladder";
              genericName = "Jellyfin Client";
              exec = "fladder";
              icon = "fladder";
              comment = "A simple cross-platform Jellyfin client";
              categories = [
                "AudioVideo"
                "Video"
                "Player"
              ];
            })
          ];

          meta = with pkgs.lib; {
            description = "A simple cross-platform Jellyfin client";
            homepage = "https://github.com/DonutWare/Fladder";
            license = licenses.gpl3Plus;
            platforms = platforms.linux;
            mainProgram = "fladder";
          };
        };

        packages.default = self.packages.${system}.fladder;

        formatter = pkgs.nixpkgs-fmt;

        devShells.default = import ./shell.nix {inherit pkgs;};
      }
    );
}
