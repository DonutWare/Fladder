{
  description = "Fladder - A simple cross-platform Jellyfin client";

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
        packages.fladder = pkgs.flutter335.buildFlutterApplication {
          pname = "fladder";
          version = "0.8.0";
          src = ./.;
          
          # This hash needs to be updated whenever pubspec.lock changes.
          # You can find the correct hash by setting it to lib.fakeHash,
          # running `nix build`, and copying the hash from the error message.
          pubHash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";

          # Add any necessary build-time or runtime dependencies here
          buildInputs = with pkgs; [
            gtk3
            glib
            libepoxy
            util-linux
            libselinux
            libsepol
            libthai
            libdatrie
            xorg.libXdmcp
            xorg.libXtst
            pcre2
            libpulseaudio
            mpv
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

        devShells.default = import ./shell.nix { inherit pkgs; };
      }
    );
}
