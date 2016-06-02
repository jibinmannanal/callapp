class Client < ActiveRecord::Base
  has_one :contact
  has_many :comments
  belongs_to :organization
  def feed
    Comment.where("client_id = ?", id)
  end
end
