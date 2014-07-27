class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.integer :shop_id
      t.integer :user_id
      t.datetime :deadline

      t.timestamps
    end
  end
end
