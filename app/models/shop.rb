# == Schema Information
#
# Table name: shops
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  address    :string(255)
#  tel        :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Shop < ActiveRecord::Base

  mount_uploader :menu, AttachmentUploader

  validates :name, presence: true
  validates :tel, presence: true

  has_many :drinks
  has_many :groups

end
