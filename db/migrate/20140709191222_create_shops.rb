class CreateShops < ActiveRecord::Migration
  def change
    create_table :shops do |t|
      t.string :name
      t.string :address
      t.string :tel
      t.string :menu

      t.timestamps
    end
  end
end
