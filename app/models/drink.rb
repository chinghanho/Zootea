# == Schema Information
#
# Table name: drinks
#
#  id                :integer          not null, primary key
#  shop_id           :integer
#  name              :string(255)
#  small_size_price  :decimal(, )
#  medium_size_price :decimal(, )
#  large_size_price  :decimal(, )
#  created_at        :datetime
#  updated_at        :datetime
#

class Drink < ActiveRecord::Base

  has_many :orders
  has_many :users,  through: :orders
  has_many :groups, through: :orders

  belongs_to :shop


  validates :name,              presence: true

end
