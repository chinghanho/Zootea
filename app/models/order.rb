# == Schema Information
#
# Table name: orders
#
#  id          :integer          not null, primary key
#  drink_id    :integer
#  user_id     :integer
#  group_id    :integer
#  price       :decimal(, )
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#

class Order < ActiveRecord::Base

  belongs_to :drink
  belongs_to :group
  belongs_to :user

  validates_presence_of :price

end
