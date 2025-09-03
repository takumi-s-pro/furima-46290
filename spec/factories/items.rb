FactoryBot.define do
  factory :item do
    name                 { Faker::Commerce.product_name }
    description          { Faker::Lorem.sentence }
    category_id          { Faker::Number.between(from: 2, to: 11) } # 「---」以外を選択
    condition_id         { Faker::Number.between(from: 2, to: 7) }
    postage_id           { Faker::Number.between(from: 2, to: 3) }
    prefecture_id        { Faker::Number.between(from: 2, to: 48) }
    shipping_day_id      { Faker::Number.between(from: 2, to: 4) }
    price                { Faker::Number.between(from: 300, to: 9_999_999) }

    # Userモデルとのアソシエーション
    association :user

    # 画像を添付する処理
    after(:build) do |item|
      # StringIOを使って小さなPNGを作る
      item.image.attach(
        io: StringIO.new(
          Base64.decode64(
            'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mP8Xw8AAukB9kIUpD4AAAAASUVORK5CYII='
          )
        ),
        filename: 'test_image.png',
        content_type: 'image/png'
      )
    end
  end
end
