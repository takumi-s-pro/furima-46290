FactoryBot.define do
  factory :buy_address do
    token         { 'tok_' + Faker::Alphanumeric.alphanumeric(number: 28) }
    postal_code   { '123-4567' }
    prefecture_id { Faker::Number.between(from: 1, to: 48) }
    city          { Faker::Address.city }
    address       { Faker::Address.street_address }
    building_name { Faker::Address.secondary_address }
    phone_number  { Faker::Number.decimal_part(digits: 11) }
  end
end
