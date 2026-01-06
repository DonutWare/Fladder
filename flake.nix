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
          };
        };

        version = let
          lines = pkgs.lib.splitString "\n" (builtins.readFile ./pubspec.yaml);
          versionLine = pkgs.lib.findFirst (l: pkgs.lib.hasPrefix "version:" l) "version: 0.0.0" lines;
          versionRaw = pkgs.lib.removePrefix "version:" versionLine;
          versionNoBuild = pkgs.lib.head (pkgs.lib.splitString "+" versionRaw);
        in
          pkgs.lib.strings.trim versionNoBuild;

        pubspecLock = builtins.path {
          path = ./pubspec.lock;
          name = "pubspec.lock";
        };
      in {
        packages.fladder = pkgs.flutter335.buildFlutterApplication {
          pname = "fladder";
          inherit version;
          src = pkgs.lib.cleanSource ./.;

          autoPubspecLock = pubspecLock;

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
            media_kit-hash = "sha256-oJQ9sRQI4HpAIzoS995yfnzvx5ZzIubVANzbmxTt6LE=";
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

          buildInputs = with pkgs; [
            mpv-unwrapped
            sqlite
            alsa-lib
            libepoxy
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
              exec = "Fladder";
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
            mainProgram = "Fladder";
          };
        };

        packages.default = self.packages.${system}.fladder;

        formatter = pkgs.nixpkgs-fmt;

        devShells.default = import ./shell.nix {inherit pkgs;};
      }
    );
}
