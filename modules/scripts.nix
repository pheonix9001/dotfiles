{
  config,
  lib,
  options,
  pkgs,
  crane-lib,
  ...
}: {
  options.scripts-drv = lib.mkOption {
    type = lib.types.package;
  };

  config.scripts-drv = pkgs.stdenv.mkDerivation {
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
  config.symlinks."~/.scripts" = "${config.scripts-drv}/bin/scripts";
}
