use chrono;
use chrono::Timelike;

pub fn time_module() -> String {
	let  now = chrono::Local::now();
	let time = now.time();

	format!("{}:{}:{}", time.hour(), time.minute(), time.second())
}

