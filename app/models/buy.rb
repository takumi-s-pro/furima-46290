class Buy < ApplicationRecord
  attr_accessor :token
  
  belongs_to :user
  belongs_to :item
  has_one :address, dependent: :destroy
  accepts_nested_attributes_for :address


end
