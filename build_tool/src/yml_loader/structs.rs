use serde::Deserialize;


#[derive(Deserialize, Debug)]
pub struct Service {
    pub name: String,
    pub service_type: String,
    pub url: String
}


#[derive(Deserialize, Debug)]
pub struct Services {
    pub services: Vec<Service>
}


