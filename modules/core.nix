{
  config,
  options,
  lib,
  ...
}: with lib; {
  options.home = mkOption {
    default = "/home/asdf";
    description = "Home directory";
    type = types.str;
  };
  options.packages = mkOption {
    default = {};
    description = "list of packages in the user environment";
    type = types.attrs;
  };
}
