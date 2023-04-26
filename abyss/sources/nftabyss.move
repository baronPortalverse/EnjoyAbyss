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

    /// One time witness is only instantiated in the init method
    struct COLLECTION has drop {}

    fun init(witness: COLLECTION, ctx: &mut TxContext) {
        let (abyss_collection, mint_cap_abyss) = collection::create_with_mint_cap<COLLECTION, Abyss>(&witness, option::none(), ctx);
        transfer::public_transfer(mint_cap_abyss, tx_context::sender(ctx));
        transfer::public_share_object(abyss_collection);
    }

    public entry fun create_collection_display_entry(
        publisher: &SharedPublisher,
        cap: &MintCap<Abyss>,
        ctx: &mut TxContext
    ) {
        let display_gekacha = create_collection_display(publisher, cap, ctx);
        let sender = tx_context::sender(ctx);
        transfer::public_transfer(display_gekacha, sender);
    }

    public fun create_collection_display(
        publisher: &SharedPublisher,
        cap: &MintCap<Abyss>,
        ctx: &mut TxContext
    ): Display<NFT<Abyss>> {
        let display_abyss = souffl3::create_display<Abyss>(cap, publisher, ctx);
        display_abyss
    }
}