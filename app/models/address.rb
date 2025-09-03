class Address < ApplicationRecord
  belongs_to :buy
  belongs_to_active_hash :prefecture
end
