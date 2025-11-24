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

            # Linux Desktop Development Dependencies
            gtk3
            glib
            pcre2
            util-linux # for libmount
            libselinux
            libsepol
            libthai
            libdatrie
            xorg.libXdmcp
            xorg.libXtst
            libxkbcommon
            epoxy
            at-spi2-core
            dbus
          ];

          # Set up environment variables if needed
          shellHook = ''
            echo "Welcome to the Fladder development environment!"
            echo "Flutter version managed by fvm."
            
            # Ensure fvm bin is in path
            export PATH="$PWD/.fvm/flutter_sdk/bin:$PATH"
          '';
        };
      }
    );
}
