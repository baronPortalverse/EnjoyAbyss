module aby::collection {

    use std::option;
    use sui::transfer;
    use sui::object::{UID};
    use std::string::{String};
    use sui::vec_map::{VecMap};
    use sui::display::{Display};
    use sui::tx_context::{Self, TxContext};
    use nft_protocol::mint_cap::{MintCap};
    use nft_protocol::collection;
    use nft::souffl3::{Self, NFT, SharedPublisher};

    struct Abyss has key, store {
        id: UID,
        name: String,
        image_url: String,
        properties: VecMap<String, String>
    }


}