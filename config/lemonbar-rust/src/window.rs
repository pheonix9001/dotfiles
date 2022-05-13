use std::process::Command;

pub fn window_module() -> String {
    let output = Command::new("xdotool")
        .args(["getactivewindow"])
        .output()
        .unwrap();
    let output_str = String::from_utf8(output.stdout).unwrap();

    let name = Command::new("xdotool")
        .args(["getwindowname", output_str.as_str()])
        .output()
        .unwrap();
    let name_str = String::from_utf8(name.stdout).unwrap_or("".to_string());

		let mut out_str = name_str.strip_suffix("\n").unwrap_or("").to_string();
		out_str.truncate(80);
		out_str
}
