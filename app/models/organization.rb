class Organization < ActiveRecord::Base
  has_many :clients
  has_many :contacts
  has_many :comments
  def feed1
    Comment.where("organization_id = ?", id)
  end


end
