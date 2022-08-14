use super::structs::Services;
use serde_yaml;


pub fn load_services_file(file_path: String) -> Result<Services, String> {
    let file = std::fs::File::open(file_path);

    match file {
        Ok(file_result) => {
            let serialized_data: Services = serde_yaml::from_reader(file_result).unwrap();
            return Ok(serialized_data)
        },
        Err(error_string) => {
            Err(error_string.to_string())
        }
    }
}
