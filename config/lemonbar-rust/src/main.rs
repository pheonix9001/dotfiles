mod misc;
mod shell;
mod window;

use std::thread;
use std::time;

fn main() {
    let deskmod = shell::new("~/.scripts/lemonbar/desktopmodule");

    println!("{}", misc::time_module());

    loop {
        // left modules
        print!(" {} ", deskmod());
        print!("{}", window::window_module());

        // center modules
        print!("{}", "%{c}");
        print!("{}", misc::time_module());

        print!("\n");
        thread::sleep(time::Duration::from_secs(1));
    }
}
