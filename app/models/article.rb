class Article <ActiveRecord::Base
  belongs_to :user, optional: true
  has_many :article_categories
  has_many :categories, through: :article_categories
  mount_uploader :picture, PictureUploader
  mount_uploader :video, VideoUploader
  validates :title, presence: true, length: {minimum: 3, maximum: 50}
  validates :description, presence: true, length: {minimum: 10, maximum: 5000}
  validates :user_id, presence: true
end