module clutchy::collection {

    use std::option;
    use sui::transfer;
    use sui::object::{UID};
    use std::string::{String};
    use sui::vec_map::{VecMap};
    use sui::display::{Display};
    use sui::tx_context::{Self, TxContext};
    use nft_protocol::mint_cap::{MintCap};
    use nft_protocol::collection;

    struct Clutchy has key, store {
        id: UID,
        name: String,
        image_url: String,
        properties: VecMap<String, String>
    }

}
