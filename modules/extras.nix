{config, options, lib, ...}: {
	options.broot.enabled = lib.mkEnableOption "Broot for fuzzy searching";
	options.fzf.enabled = lib.mkEnableOption "Fzf for fuzzy searching";

    config = {
	    packages.broot = config.broot.enabled;
	    packages.fzf = config.fzf.enabled;
	    packages.fd = config.fzf.enabled;
    };
}
