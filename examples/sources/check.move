module examples::check {

    use nft::souffl3::NFT;
    use std::type_name;
    use examples::collection::Gekacha;
    use mock::collection::BueBue;

    public fun check<C>(
        _nft: &C,
    ) {
        let c_type = type_name::get<C>();
        let gekacha_type = type_name::get<NFT<Gekacha>>();
        let buebue_type = type_name::get<BueBue>();
        assert!(type_name::into_string(copy c_type) == type_name::into_string(gekacha_type), 1);
        assert!(type_name::into_string(c_type) == type_name::into_string(buebue_type), 1);
    }
}
