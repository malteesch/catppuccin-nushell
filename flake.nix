{
  description = "Catppuccin port for nushell";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };


  outputs = { nixpkgs, flake-utils, ... }: flake-utils.lib.eachDefaultSystem (system:
  let
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    packages.default = pkgs.stdenv.mkDerivation {
      pname = "catppuccin-nushell";
      version = "0.0.1";
      src = ./.;
      __noChroot = true;
      buildPhase = ''
        ${pkgs.lib.getExe pkgs.catppuccin-whiskers} catppuccin.nu.tera > catppuccin.nu
      '';
      installPhase = ''
        mkdir -p $out
        mv catppuccin.nu $out/catppuccin.nu
      '';
    };
  });
}
