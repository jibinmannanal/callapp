class Comment < ActiveRecord::Base
  belongs_to :client
  belongs_to :organization
  default_scope -> { order(created_at: :desc) }
  validates :client_id, presence: true
  validates :organization_id, presence: true
  validates :comment, presence: true, length: { maximum: 140 }
end
