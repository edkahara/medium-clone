class Comment < ApplicationRecord
  mount_uploader :file, ImageUploader

  scope :newest_first, lambda {order("created_at DESC")}

  belongs_to :user
  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable
  has_many :likes, as: :likeable
  has_many :comment_likers, through: :likes, source: :user
  has_many :bookmarks, as: :bookmarkable
  has_many :comment_bookmarkers, through: :bookmarks, source: :user

  validates :file, file_size: { less_than: 1.megabytes }
  validates_presence_of :body
end
