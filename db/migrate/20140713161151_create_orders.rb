class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :drink_id
      t.integer :user_id
      t.integer :group_id
      t.string :size

      t.timestamps
    end
  end
end
