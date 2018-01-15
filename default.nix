{ pkgs ? import <nixpkgs> {} }:
  pkgs.stdenv.mkDerivation {
    name = "ghcjs";
    src = pkgs.fetchFromGitHub {
      owner = "ghcjs";
      repo = "ghcjs";
      rev = "f851f1d85009ecb251b9d6a6c18ebabf6992e4cd";
      sha256 = "0fq9h7p02aw2nzpiqc3b8sn6ajw84yj306dsaw1ddaa70b6dfixm";
      fetchSubmodules = true;
    };
    preConfigure = ''
      cd ghc && ./boot && ./configure && make
    '';
    buildInputs = with pkgs; [ ncurses
      haskellPackages.alex haskellPackages.happy
      perl git autoconf automake haskellPackages.ghc iconConvTools
    ];
    build = ''
      $src/utils/makePackages.sh
    '';
  }
