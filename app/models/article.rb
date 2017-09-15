class Article <ActiveRecord::Base
  belongs_to :user, optional: true
  has_many :article_categories
  has_many :comments, dependent: :destroy
  has_many :categories, through: :article_categories
  mount_uploader :picture, PictureUploader
  mount_uploader :video, VideoUploader
  validates :title, presence: true, length: {minimum: 3, maximum: 5000}
  validates :description, presence: true, length: {minimum: 10, maximum: 100000}
  validates :user_id, presence: true
  default_scope -> { order(updated_at: :desc)}
  acts_as_votable

  #def score
   # self.get_upvotes.size - self.get_downvotes.size
  #end

  def self.search(search)
    where("title LIKE ?", "%#{search}%")
  end
end