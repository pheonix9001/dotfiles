use assert_cmd::prelude::*;
use std::{error::Error, process::Command};

#[test]
fn run_lemonbar() -> Result<(), Box<dyn Error>> {
    let cmd = Command::cargo_bin("controllemonbar")?;
    let _ = Command::new("/bin/bash")
        .arg("-c")
        .arg(format!("{} | lemonbar -gx15 -f\"Iosevka:pixelsize=13:antialias=true\" -B#2e3440 -F#d8dee9 -U#88c0d0 -o2", cmd.get_program().to_str().ok_or("")?))
        .output()?;

    Ok(())
}
