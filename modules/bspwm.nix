{config, options, lib, pkgs, ...}: {
	imports = [ ./core.nix ];

	options.bspwm.enabled = lib.mkEnableOption "Bspwm";

	config = {
		packages.bspwm = true;
		packages.sxhkd = true;
		packages.xprompt = true;
		packages.hsetroot = true;
	};
}
