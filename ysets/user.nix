l: s: with s; {
	# The commands to run to startup the user's window manager
	user.wm.startup = [];
	# The environment variables of the user
	user.envvars = {
		USER_SHELL = shells.${shells.default}.path;
	};
}
