l: s: with s; {
	# Nushell as a shell
	shells.nushell.enabled = false;
	shells.nushell.path = "${pkgs.nushell}/bin/nu";

	env.pkgs = l.only_if shells.nushell.enabled [
		s.pkgs.nushell
	];
	switch-to-script = l.only_if shells.nushell.enabled [
	  "cp -r ${./.} ~/.config/nushell"
	  "chmod +rw ~/.config/nushell"
	  "chmod +rw ~/.config/nushell/*"
	];
	switch-from-script = l.only_if shells.nushell.enabled [
		"rm -rf ~/.config/nushell"
	];
}
