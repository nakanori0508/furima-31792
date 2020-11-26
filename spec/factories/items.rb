FactoryBot.define do
  factory :item do
    # モデルファイルにアソシエーションの記述があってもだめ。テストの時はFactoryBot内にもアソシエーションの記述をしないとアソシエーションできていないことになる
    association :user

    name              {"テスト"}
    explan            {"テスト説明"}
    category_id       {2}
    status_id         {2}
    shipfee_id        {2}
    prefecture_id     {2}
    dayship_id        {2}
    price             {500}


    # 画像をpublic/imagesフォルダのsample1のコピー.jpgを使用
    # after(:build)はrspecがないと使えない。ActiveStorageで画像のテストをする時はこのやり方がいい
    after(:build) do |item|
      item.image.attach(io: File.open('public/images/sample1のコピー.jpg'), filename: 'sample1のコピー.jpg')
    end
  end
end
