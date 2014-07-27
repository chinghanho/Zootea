class CreateDrinks < ActiveRecord::Migration
  def change
    create_table :drinks do |t|
      t.integer :shop_id
      t.string :name
      t.decimal :small_size_price
      t.decimal :medium_size_price
      t.decimal :large_size_price

      t.timestamps
    end
  end
end
