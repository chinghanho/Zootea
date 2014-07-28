# == Schema Information
#
# Table name: drinks
#
#  id         :integer          not null, primary key
#  shop_id    :integer
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Drink < ActiveRecord::Base

  has_many :orders
  has_many :users,  through: :orders
  has_many :groups, through: :orders

  belongs_to :shop


  validates :name,              presence: true

end
