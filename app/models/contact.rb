class Contact < ActiveRecord::Base
  has_one :client
  has_one :organization
  before_save { self.email = email.downcase }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
            format: { with: VALID_EMAIL_REGEX }
  validates :phone_number,:presence => true,
            :numericality => true,
            :length => { :minimum => 10, :maximum => 15 }
end
