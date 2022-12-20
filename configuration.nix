{config, lib, options, ...}: {
	imports = [ ./modules/core.nix ./modules/bspwm.nix ];

    bspwm.enabled = true;

    packages.neofetch = true;
    packages.zathura = true;
}
