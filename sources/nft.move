module nft::souffl3 {

    use std::vector;
    use sui::address;
    use sui::package;
    use sui::transfer;
    use sui::object::{Self, UID};
    use std::string::{utf8, String};
    use sui::vec_map::{Self, VecMap};
    use sui::display::{Self, Display};
    use sui::tx_context::{TxContext};
    use sui::package::Publisher;
    use nft_protocol::mint_cap::MintCap;

    const ENOT_ADMIN: u64 = 0;

    struct NFT<phantom T> has key, store {
        id: UID,
        name: String,
        image_url: String,
        properties: VecMap<String, String>
    }

    struct NFTMintCap has key, store {
        id: UID
    }

    struct SharedPublisher has key, store {
        id: UID,
        publisher: Publisher
    }

    /// One time witness is only instantiated in the init method
    struct SOUFFL3 has drop {}

    fun init(witness: SOUFFL3, ctx: &mut TxContext) {
        let publisher = package::claim(witness, ctx);

        let shared_publisher = SharedPublisher {
            id: object::new(ctx),
            publisher
        };
        transfer::public_share_object(shared_publisher);
    }

    public fun create_display<T>(
        _cap: &MintCap<T>,
        publisher: &SharedPublisher,
        ctx: &mut TxContext
    ): Display<NFT<T>> {


        let display_t = display::new<NFT<T>>(&publisher.publisher, ctx);
        display::add<NFT<T>>(&mut display_t, utf8(b"name"), utf8(b"{name}"));
        display::add<NFT<T>>(&mut display_t, utf8(b"image_url"), utf8(b"{image_url}"));
        display::update_version(&mut display_t);

        display_t

    }

    public fun mint_nft_with_cap<T>(
        name: String,
        image_url: String,
        _mint_cap: &MintCap<T>,
        property_keys: vector<String>,
        property_values: vector<String>,
        ctx: &mut TxContext,
    ): NFT<T> {
        let len = vector::length(&property_keys);
        assert!(len == vector::length(&property_values), 1);

        let properties = vec_map::empty<String, String>();
        let i = 0;
        while (i < len) {
            let key = vector::pop_back(&mut property_keys);
            let val = vector::pop_back(&mut property_values);
            vec_map::insert(&mut properties, key, val);
            i = i + 1;
        };

        NFT<T> {
            id: object::new(ctx),
            name,
            image_url,
            properties
        }
    }

    public fun set_collection_info<T>(
        display: &mut Display<NFT<T>>,
        collection_name: String,
        cover_image_url: String,
        symbol: String,
        description: String,
        creator: address,
        _ctx: &mut TxContext
    ) {

        display::add<NFT<T>>(display, utf8(b"collection_name"), collection_name);
        display::add<NFT<T>>(display, utf8(b"collection_image"), cover_image_url);
        display::add<NFT<T>>(display, utf8(b"symbol"), symbol);
        display::add<NFT<T>>(display, utf8(b"creator"), address::to_string(creator));
        display::add<NFT<T>>(display, utf8(b"description"), description);
        display::update_version(display);

    }

    fun publisher_borrow(publisher: &SharedPublisher): &Publisher {
        &publisher.publisher
    }

}
