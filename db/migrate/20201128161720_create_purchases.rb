class CreatePurchases < ActiveRecord::Migration[6.0]
  def change
    create_table :purchases do |t|
      t.string  :postcode,         null: false
      t.integer :prefecture_id,    null: false
      t.string  :municipality,     null: false
      t.string  :address,          null: false
      t.string  :buildingname,     null: false
      t.string  :phonenumber,      null: false
      t.integer :buyer_id,         foreign_key: true
      t.timestamps
    end
  end
end
