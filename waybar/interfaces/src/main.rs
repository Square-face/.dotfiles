use std::{
    process::Command,
    sync::{Arc, Mutex},
    thread,
};

fn compute_symbols(volume: Arc<Mutex<u8>>, symbols: Arc<Mutex<(&str, &str)>>) {
    let output = Command::new("pamixer")
        .arg("--get-volume")
        .output()
        .expect("Failed to execute command");

    let output = String::from_utf8_lossy(&output.stdout);
    let temp_vol = output.trim().parse::<u8>().unwrap();

    match temp_vol {
        0 => *symbols.lock().unwrap() = ("󰸈 ", "󰕿 "),
        1..=50 => *symbols.lock().unwrap() = ("󰖁 ", "󰖀 "),
        _ => *symbols.lock().unwrap() = ("󰖁 ", "󰕾 "),
    }
    *volume.lock().unwrap() = temp_vol;
}

fn main() {
    let symbols = Arc::new(Mutex::new(("", "")));
    let volume = Arc::new(Mutex::new(0));

    let symbols_clone = symbols.clone();
    let volume_clone = volume.clone();
    let handle = thread::spawn(move || compute_symbols(volume_clone, symbols_clone));

    let output = Command::new("pamixer")
        .arg("--get-mute")
        .output()
        .expect("Failed to execute command");

    let output = String::from_utf8_lossy(&output.stdout);
    let muted = output.trim() == "true";

    handle.join().unwrap();


    let symbol = match muted {
        true => {symbols.lock().unwrap().0}
        false => {symbols.lock().unwrap().1}
    };

    println!("{{\"tooltip\": \"{}\", \"text\":\"{}% {}\", \"class\":\"wee\", \"percentage\":\"2\"}}", symbol, *volume.lock().unwrap(), symbol);
}

