{ pkgs ? import (builtins.fetchTarball {
  # Descriptive name to make the store path easier to identify
  # need to use nixos-release
  name = "nixos-release-19.09";
  # Commit hash for release-19.09 
  # uses hugo version 0.58
  url =
    "https://github.com/nixos/nixpkgs/archive/76daad86a7910b4ff1dd4cb3b3a3441b4f50295e.tar.gz";
  # Hash obtained using `nix-prefetch-url --unpack <url>j
  sha256 = "0sczfdanfhxhysfxsrxmam3hhcn0ngz6l7g0f0dflk6dwd61rkwa";
}) { } }:
pkgs.mkShell {
  # buildInputs is for dependencies you'd need "at run time",
  # were you to to use nix-build not nix-shell and build whatever you were working on
  nativeBuildInputs = [ pkgs.hugo ];
}

