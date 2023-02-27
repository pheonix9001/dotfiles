{
  config,
  options,
  lib,
  pkgs,
  ...
}:
with lib; {
  options.home = mkOption {
    default = "/home/asdf";
    description = "Home directory of the user";
    type = types.str;
  };
  options.packages = mkOption {
    default = {};
    description = "List of packages in the user environment";
    type = types.attrsOf types.package;
  };
  options.symlinks = mkOption {
    default = {};
    description = "All the symlinks that will be created";
    type = types.attrsOf types.path;
  };
  options.dotfiles-drv = mkOption {
    description = "The derivation of the dotfiles";
    type = types.package;
  };

  options.switch-to-script = mkOption {
    default = let
      symlinks-as-list = mapAttrsToList (n: v: "ln -sf ${v} ${n}") config.symlinks;
    in
      foldl' (v: a: "${a}\n${v}") "" symlinks-as-list;

    description = "The bash script that will be generated to switch to the config";
    type = types.str;
  };
  options.switch-from-script = mkOption {
    default = foldl (a: v: "${a}\nrm -rf ${v}") "" (attrNames config.symlinks);
    description = "The bash script that switch back from the config";
    type = types.str;
  };
}
