class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :profile_photo, ProfilePhotoUploader

  has_many :stories, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes
  has_many :liked_stories, through: :likes, source: :likeable, source_type: 'Story'
  has_many :liked_comments, through: :likes, source: :likeable, source_type: 'Comment'
  has_many :bookmarks
  has_many :bookmarked_stories, through: :bookmarks, source: :bookmarkable, source_type: 'Story'
  has_many :bookmarked_comments, through: :bookmarks, source: :bookmarkable, source_type: 'Comment'
  has_many :follower_relationships, class_name: 'Relationship', :foreign_key => :following_id
  has_many :followers, :through => :follower_relationships, :source => :follower  
  has_many :following_relationships, class_name: 'Relationship', :foreign_key => :follower_id
  has_many :following, :through => :following_relationships, :source => :following

  validates_presence_of :name, :message => "is required."
  validates_presence_of :username, :message => "is required."
  validates_format_of :username, :with => /^[a-z0-9._]*$/i, multiline: true, :message => "Username can only use letters, numbers, underscores and periods."
  validates :profile_photo, file_size: { less_than: 1.megabytes }
end
