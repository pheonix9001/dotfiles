use chrono::Timelike;
use std::error::Error;
use std::io::BufReader;
use std::{process::Command, time::Duration};
use x11rb::connection::Connection;
use x11rb::protocol::xproto::{AtomEnum, ConnectionExt};
use x11rb::rust_connection::RustConnection;

fn main() -> Result<(), Box<dyn Error>> {
    let (conn, screen_num) = x11rb::connect(None)?;
    let root = conn.setup().roots[screen_num].root;
    let mut rx_bytes = get_network_stat("/statistics/rx_bytes".to_string())?;
    let mut tx_bytes = get_network_stat("/statistics/tx_bytes".to_string())?;

    loop {
        let deskmod = deskmod(&conn, root)?;
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

x11rb::atom_manager! {
    pub DesktopAtoms:

    AtomCollectionCookie {
        _NET_NUMBER_OF_DESKTOPS,
        _NET_CURRENT_DESKTOP,
    }
}

fn get_atom<A, B>(
    conn: &RustConnection,
    win: u32,
    atom: A,
    atomtype: B,
) -> Result<Vec<u8>, Box<dyn Error>>
where
    u32: From<B>,
    u32: From<A>,
{
    Ok(conn
        .get_property(false, win, atom, atomtype, 0, 256)?
        .reply()?
        .value)
}

fn window_module(conn: &RustConnection) -> Result<String, Box<dyn Error>> {
    let focus = conn.get_input_focus()?.reply()?.focus;
    let name = get_atom(&conn, focus, AtomEnum::WM_NAME, AtomEnum::STRING)?;

    Ok(String::from_utf8_lossy(&name).to_string())
}

fn deskmod(conn: &RustConnection, root: u32) -> Result<String, Box<dyn Error>> {
    let atoms = DesktopAtoms::new(conn)?.reply()?;

    let num_of_desks = get_atom(&conn, root, atoms._NET_NUMBER_OF_DESKTOPS, AtomEnum::ANY)?[0];
    let current_desk = get_atom(&conn, root, atoms._NET_CURRENT_DESKTOP, AtomEnum::ANY)?[0];

    let desks = (0..num_of_desks).fold("".to_string(), |desks, desk| {
        if desk != current_desk {
            format!("{}·", desks)
        } else {
            format!(
                "{} %{{+u}}%{{F#eceff4}}%{{B#3b4252}} · %{{B-}}%{{F-}}%{{-u}}",
                desks
            )
        }
    });
    return Ok(desks);
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
