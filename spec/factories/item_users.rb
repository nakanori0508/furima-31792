FactoryBot.define do
  factory :item_user do
    postcode           {"111-1111"}
    municipality       {"テスト市区町村"}
    address            {"テスト番地"}
    phonenumber        {"12345678901"}
    user_id            {1}
    item_id            {1}
    token              {"aaaa"}

  end
end
