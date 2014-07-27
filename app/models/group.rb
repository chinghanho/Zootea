# == Schema Information
#
# Table name: groups
#
#  id         :integer          not null, primary key
#  shop_id    :integer
#  user_id    :integer
#  deadline   :datetime
#  created_at :datetime
#  updated_at :datetime
#

class Group < ActiveRecord::Base

  # before_validation :set_deadline, on: :create

  has_many :orders
  has_many :drinks, through: :orders
  has_many :users,  through: :orders

  belongs_to :shop
  belongs_to :owner, class_name: 'User', foreign_key: 'user_id'

  scope :ongoing, -> { where('deadline > ?', Time.now) }


  def active?
    deadline > Time.now
  end


  private

    # def set_deadline
    #   self.deadline = Time.zone.now + 12.hours
    # end

end
