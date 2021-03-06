<?xml version="1.0"?>
<!DOCTYPE fontconfig SYSTEM "urn:fontconfig:fonts.dtd">
<fontconfig>
	<!--
	replace mononoki with Liga mononki Nerd Font
	-->
	<match target="font">
		<test name="family" qual="any">
			<string>mononoki</string>
		</test>
		<edit name="family" mode="assign">
			<string>mononoki Nerd Font</string>
		</edit>
	</match>

	<match target="font">
		<test name="family" qual="any">
			<string>mononoki Nerd Font</string>
		</test>
		<!--
			Make mononoki more compressed
		-->
		<edit name="matrix" mode="assign">
			<times>
				<name>matrix</name>
				<matrix>
					<double>0.95</double><double>0</double>
					<double>0</double><double>1</double>
				</matrix>
			</times>
		</edit>

		<!--
			enable anti-aliasing on mononoki
		-->
		<edit name="antialias" mode="assign">
			<bool>true</bool>
		</edit>
	</match>
</fontconfig>
<!-- vim: ft=xml
-->
