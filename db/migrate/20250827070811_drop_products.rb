class DropProducts < ActiveRecord::Migration[7.1]
  def change
    drop_table :comments
    drop_table :items
    drop_table :users
  end
end
