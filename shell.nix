{ pkgs ? import (builtins.fetchTarball {
  # Descriptive name to make the store path easier to identify
  # need to use nixos-release
  name = "nixpkgs-unstable";
  # Commit hash for release-19.09 
  # uses hugo version 0.58
  url =
    "https://github.com/nixos/nixpkgs/archive/867d3dd394624590ad84cead79a5a7a0a20b39c5.tar.gz";
  # Hash obtained using `nix-prefetch-url --unpack <url>j
  sha256 = "1888768m8nnv7n4cl1d9xbn9hq94006pyzsnpsr0wydn3fh9svkj";
}) { } }:
pkgs.mkShell {
  # buildInputs is for dependencies you'd need "at run time",
  # were you to to use nix-build not nix-shell and build whatever you were working on
  nativeBuildInputs = [ pkgs.hugo pkgs.go_1_17 ];
}

