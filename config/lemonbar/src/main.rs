use chrono::Timelike;
use std::error::Error;
use std::io::BufReader;
use std::{process::Command, time::Duration};
use x11rb::protocol::xproto::{AtomEnum, ConnectionExt};
use x11rb::rust_connection::RustConnection;

fn window_module(conn: &RustConnection) -> Result<String, Box<dyn std::error::Error>> {
    let focus = conn.get_input_focus()?.reply()?.focus;
    let name = conn
        .get_property(false, focus, AtomEnum::WM_NAME, AtomEnum::STRING, 0, 256)?
        .reply()?;

    Ok(String::from_utf8_lossy(&name.value).to_string())
}

fn deskmod() -> Result<String, std::io::Error> {
    let desktops = Command::new("bash")
        .arg(env!("HOME").to_owned() + "/.scripts/lemonbar/desktopmodule")
        .output()?
        .stdout;

    Ok(String::from_utf8_lossy(&desktops).to_string())
}

fn time_module() -> String {
    let time = chrono::Local::now().time();

    format!("{}:{}:{}", time.hour(), time.minute(), time.second())
}

fn network_module(rx_bytes: u64, tx_bytes: u64) -> String {
    format!(
        concat!(
            "%{{F#81a1c1}}%{{B-}}%{{R}}",
            " {}K {}K",
            " %{{B-}}%{{F-}}",
        ),
        rx_bytes as f32 / 1000.0,
        tx_bytes as f32 / 1000.0,
    )
}

fn get_network_stat(stat: String) -> Result<u64, Box<dyn Error>> {
    std::fs::read_dir("/sys/class/net/")?.try_fold(0, |bytes, folder| {
        let path_to_read = folder?.path().to_str().ok_or("")?.to_owned() + &stat;
        let read_str = String::from_utf8(std::fs::read(path_to_read)?)?;
        let read_str = read_str.strip_suffix("\n").ok_or("Suffix \n not found")?;
        let read: u64 = read_str.parse()?;
        Ok(bytes + read)
    })
}

fn main() -> Result<(), Box<dyn std::error::Error>> {
    let (conn, _screen_num) = x11rb::connect(None)?;
    let mut rx_bytes = get_network_stat("/statistics/rx_bytes".to_string())?;
    let mut tx_bytes = get_network_stat("/statistics/tx_bytes".to_string())?;

    loop {
        let deskmod = deskmod()?;
        let windows = window_module(&conn)?;
        let time = time_module();

        let (rx_bytes_prev, tx_bytes_prev) = (rx_bytes, tx_bytes);

        (rx_bytes, tx_bytes) = (
            get_network_stat("/statistics/rx_bytes".to_string())?,
            get_network_stat("/statistics/tx_bytes".to_string())?,
        );
        let network = network_module(rx_bytes - rx_bytes_prev, tx_bytes - tx_bytes_prev);
        println!(" {} {} %{{c}}{}%{{r}}{}", deskmod, windows, time, network);

        std::thread::sleep(Duration::from_secs(1));
    }
}
