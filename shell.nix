{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = [
    pkgs.bun
  ];

  shellHook = ''
    echo "Bun.js development shell is ready!"
  '';
}
