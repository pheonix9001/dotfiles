#
# Plugins
#

source "%val{config}/plugins/plug.kak/rc/plug.kak"
plug "andreyorst/plug.kak" noload

# Kakborad
plug "lePerdu/kakboard" %{
	hook global WinCreate .* %{kakboard-enable}
}
