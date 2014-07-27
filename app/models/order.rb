# == Schema Information
#
# Table name: orders
#
#  id         :integer          not null, primary key
#  drink_id   :integer
#  user_id    :integer
#  group_id   :integer
#  size       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Order < ActiveRecord::Base

  belongs_to :drink
  belongs_to :group
  belongs_to :user

  SIZE_TYPE = %w(small medium large)
  validates :size, presence: true,
                   inclusion: { in: SIZE_TYPE }

end
