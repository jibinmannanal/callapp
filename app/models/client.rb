class Client < ActiveRecord::Base
  has_many :contact
  has_many :comments
  belongs_to :organization
  def feed
    Comment.where("client_id = ?", id)
  end
end
