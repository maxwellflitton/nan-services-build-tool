use serde::{Deserialize, Deserializer};


pub enum ServiceType {
    GIT,
    DOCKER
}


impl ServiceType {

    fn value(&self) -> String {
        match self {
            ServiceType::GIT => return "git".to_owned(),
            ServiceType::DOCKER => return "docker".to_owned()
        }
    }
}


// impl<'de> Deserialize<'de> for ServiceType {
//     fn deserialize<D>(deserializer: D) -> Result<Self, D::Error>
//     where
//         D: Deserializer<'de>,
//     {
//         let mut d = deserializer.deserialize_enum("ServiceType", &["git", "docker"], ).unwrap();
//     }
// }
