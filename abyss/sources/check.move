module aby::check {

    use nft::souffl3::NFT;
    use std::type_name;
    use aby::collection::Abyss;

    public fun check<C>(
        _nft: &NFT<C>,
    ) {
        let c_type = type_name::get<C>();
        let collection_type = type_name::get<Abyss>();
        assert!(type_name::into_string(c_type) == type_name::into_string(collection_type), 1)
    }
}