class CreateBuys < ActiveRecord::Migration[7.1]
  def change
    create_table :buys do |t|
      t.references :user, null: false, foreign_key: true
      t.references :item, null: false, foreign_key: true
      t.integer :price  ,null: false
      
      t.timestamps
    end
  end
end
