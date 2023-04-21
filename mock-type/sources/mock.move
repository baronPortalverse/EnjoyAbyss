module mock::collection {

    use sui::object::{UID};
    use std::string::{String};
    use sui::vec_map::{VecMap};

    struct BueBue has key, store {
        id: UID,
        name: String,
        image_url: String,
        properties: VecMap<String, String>
    }
}
