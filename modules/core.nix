{
  config,
  options,
  lib,
  ...
}: {
  options.home = lib.mkOption {
    default = "/home/asdf";
    description = "Home directory";
    type = lib.types.str;
  };
  options.packages = lib.mkOption {
	  default = [];
	  description = "list of packages in the user environment";
	  type = lib.types.attrs;
  };
}
