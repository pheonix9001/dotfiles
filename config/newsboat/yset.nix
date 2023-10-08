l: s:
with s; {
	apps.newsboat.enabled = false;
	doc."apps.newsboat.enabled" = "Newsboat as rss feed reader";

    env.pkgs = with pkgs; l.only_if apps.newsboat.enabled [ newsboat ];
	env.syms = l.only_if apps.newsboat.enabled {
		"~/.config/newsboat" = ./.;
	};
}
