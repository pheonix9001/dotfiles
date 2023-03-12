l: s: {
  scripts-drv = s.pkgs.stdenv.mkDerivation {
    name = "dotfile-scripts";
    src = ../scripts;
    installPhase = ''
      mkdir -p $out/bin/scripts
      cp -r * $out/bin/scripts
    '';
    patchPhase = ''
      export keyboards=""
      substituteAllInPlace ./xprompt/keyboards
    '';
  };
  env.syms."~/.scripts" = "${s.scripts-drv}/bin/scripts";
}
