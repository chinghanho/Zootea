class CreateDrinks < ActiveRecord::Migration
  def change
    create_table :drinks do |t|
      t.integer :shop_id
      t.string :name

      t.timestamps
    end
  end
end
