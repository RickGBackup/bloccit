class Topic < ActiveRecord::Base
  has_many :posts, dependent: :destroy
  has_many :sponsored_posts, dependent: :destroy
  
  validates :name, presence: true, length: {minimum: 5}
  validates :description, presence: true, length: {minimum: 15}
end
