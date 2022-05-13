use std::process::Command;

pub fn new(file: &str) -> impl Fn() -> String + '_ {
    return move || -> String {
        let cmd = Command::new("sh").args(["-c", file]).output().unwrap();

        String::from_utf8(cmd.stdout)
            .unwrap()
            .to_string()
    };
}
