module aby::collection {

    use sui::object::{UID};
    use std::string::{String};
    use sui::vec_map::{VecMap};
    use sui::display::{Display};
    use sui::tx_context::{Self, TxContext};

    struct Abyss has key, store {
        id: UID,
        name: String,
        image_url: String,
        properties: VecMap<String, String>
    }

}
