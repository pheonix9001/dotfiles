{config, lib, options, ...}: {
	imports = [ ./modules/core.nix ./modules/bspwm.nix ./modules/extras.nix ];

    bspwm.enabled = true;
    broot.enabled = true;
    fzf.enabled = true;

    packages.neofetch = true;
    packages.zathura = true;
}
