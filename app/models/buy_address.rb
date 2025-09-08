class BuyAddress
  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture_id, :city, :address, :building_name, :phone_number,
                :user_id, :item_id, :token

  with_options presence: true do
    validates :postal_code, format: { with: /\A\d{3}-\d{4}\z/, message: "is invalid. Include hyphen(-)" }
    validates :city, :address, :token, :user_id, :item_id
    validates :phone_number, format: { with: /\A\d{10,11}\z/, message: "is invalid" }
  end
  validates :prefecture_id, numericality: { other_than: 0, message: "can't be blank" }

  def save
    item = Item.find(item_id)
    buy = Buy.create(user_id: user_id, item_id: item_id)

    Address.create(
      postal_code: postal_code,
      prefecture_id: prefecture_id,
      city: city,
      address: address,
      building_name: building_name,
      phone_number: phone_number,
      buy_id: buy.id 
    )
  end
end
