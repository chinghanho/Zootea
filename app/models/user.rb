# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string(255)      default(""), not null
#  username        :string(255)      default(""), not null
#  name            :string(255)      default(""), not null
#  password_digest :string(255)      default(""), not null
#  remember_token  :string(255)      default(""), not null
#  created_at      :datetime
#  updated_at      :datetime
#

class User < ActiveRecord::Base

  before_save { self.email = email.downcase }
  before_create :create_remember_token

  validates :username, presence: true, length: { maximum: 50 }
  validates :name,     presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
                    format:   { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  has_secure_password

  validates :password, length: { minimum: 6 }, if: :password

  has_many :orders
  has_many :groups
  has_many :drinks, through: :orders
  has_many :joined_groups, through: :orders, source: :group

  def drinks_amount
    amount = 0
    orders.each { |order| amount += order.drink["#{order.size}_size_price"].to_i }
    amount
  end

  def admin?
    CONFIG['admin_emails'] && CONFIG['admin_emails'].include?(email)
  end

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private

    def create_remember_token
      self.remember_token = User.digest(User.new_remember_token)
    end

end
