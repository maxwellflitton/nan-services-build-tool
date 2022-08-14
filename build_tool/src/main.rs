use std::env;

mod yml_loader;
mod build_pipeline;

use yml_loader::processes::load_services_file;


fn main() {
    let path = env::current_dir().unwrap().to_str().unwrap().to_owned() + "/nano.yml";
    let services = load_services_file(path).unwrap();
}
