#
# Plugins
#

source "%val{config}/plugins/plug.kak/rc/plug.kak"
plug "andreyorst/plug.kak" noload

# Nord
# plug "abuffseagull/nord.kak" theme %{ colorscheme nord }

plug "nesyamun/nord-kakoune" %{
}

# Kakboard
plug "lePerdu/kakboard" %{
	hook global WinCreate .* %{kakboard-enable}
}
