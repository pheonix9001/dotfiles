l: s: with s; {
	doc."user.wm.startup" = "The commands to run to startup the user's window manager";
	user.wm.startup = [];
	doc."user.envvars" = "The environment variables of the user";
	user.envvars = {
		USER_SHELL = shells.${shells.default}.path;
	};
}
