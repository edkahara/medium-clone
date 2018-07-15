class Bookmark < ApplicationRecord
  belongs_to :user
  belongs_to :bookmarkable, polymorphic: true

  scope :newest_first, lambda {order("created_at DESC")}
end
