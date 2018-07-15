class Like < ApplicationRecord
  belongs_to :user
  belongs_to :likeable, polymorphic: true

  scope :newest_first, lambda {order("created_at DESC")}
end
