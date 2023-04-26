module examples::check {

    use nft::souffl3::NFT;
    use std::type_name;
    use examples::collection::Gekacha;

    public fun check<C>(
        _nft: &NFT<C>,
    ) {
        let c_type = type_name::get<C>();
        let collection_type = type_name::get<Gekacha>();
        assert!(type_name::into_string(c_type) == type_name::into_string(collection_type), 1)
    }
}