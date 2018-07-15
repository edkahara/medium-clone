class Story < ApplicationRecord
  mount_uploader :banner_image, BannerImageUploader
  mount_uploader :file, ImageUploader

  acts_as_taggable

  belongs_to :user
  has_many :comments, as: :commentable
  has_many :likes, as: :likeable
  has_many :story_likers, :through => :likes, :source => :user
  has_many :bookmarks, as: :bookmarkable
  has_many :story_bookmarkers, :through => :bookmarks, :source => :user

  scope :newest_first, lambda {order("created_at DESC")}
  scope :with_tag, -> (tag) { tagged_with(tag) if tag.present? }
  scope :following_stories, -> (following) {where user_id: following}

  validates_presence_of :title, :message => "is required."
  validates_presence_of :banner_image, on: :create, :message => "is required."
  validates :banner_image, file_size: { less_than: 1.megabytes }
  validates :file, file_size: { less_than: 1.megabytes }
  validates_presence_of :body, :message => "is required."

  extend FriendlyId
  friendly_id :title, use: :slugged

  def should_generate_new_friendly_id?
    title_changed?
  end

  def normalize_friendly_id(string)
    super[0..99]
  end
end
